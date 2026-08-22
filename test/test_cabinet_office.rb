# frozen_string_literal: true

require 'test_helper'
require 'webmock/minitest'

class TestCabinetOffice < Minitest::Test
  def test_parse_utf8_csv
    csv = "国民の祝日・休日月日,国民の祝日・休日名称\n2026/1/1,元日\n2026/1/12,成人の日\n"
    result = VerifiedHolidays::CabinetOffice.parse(csv)
    assert_equal 2, result.size
    assert_equal '元日', result[Date.new(2026, 1, 1)]
    assert_equal '成人の日', result[Date.new(2026, 1, 12)]
  end

  def test_parse_with_bom
    csv = "\uFEFF国民の祝日・休日月日,国民の祝日・休日名称\n2026/1/1,元日\n"
    # BOM should be handled in fetch, but parse should still work if BOM is already removed
    result = VerifiedHolidays::CabinetOffice.parse(csv.delete_prefix('﻿'))
    assert_equal '元日', result[Date.new(2026, 1, 1)]
  end

  def test_fetch_converts_encoding
    # Simulate CP932-encoded CSV
    csv_utf8 = "国民の祝日・休日月日,国民の祝日・休日名称\n2026/1/1,元日\n"
    csv_cp932 = csv_utf8.encode('CP932')

    stub_request(:get, VerifiedHolidays::CabinetOffice::CSV_URL)
      .to_return(body: csv_cp932.b, status: 200)

    result = VerifiedHolidays::CabinetOffice.fetch
    assert_equal '元日', result[Date.new(2026, 1, 1)]
  end

  def test_fetch_raises_on_http_error_status
    # The Cabinet Office site answers 404 with an HTML page. Parsed as CSV that
    # yields zero rows, so without a status check fetch would quietly return {}.
    stub_request(:get, VerifiedHolidays::CabinetOffice::CSV_URL)
      .to_return(status: [404, 'Not Found'], body: '<html><body>Not Found</body></html>')

    error = assert_raises(VerifiedHolidays::CabinetOffice::FetchError) do
      VerifiedHolidays::CabinetOffice.fetch
    end
    assert_includes error.message, '404'
  end

  def test_fetch_raises_on_redirect
    # Net::HTTP.get_response does not follow redirects, so a moved CSV must not
    # be mistaken for an empty one.
    stub_request(:get, VerifiedHolidays::CabinetOffice::CSV_URL)
      .to_return(status: [301, 'Moved Permanently'], headers: { 'Location' => 'https://example.com/new.csv' })

    error = assert_raises(VerifiedHolidays::CabinetOffice::FetchError) do
      VerifiedHolidays::CabinetOffice.fetch
    end
    assert_includes error.message, '301'
  end

  def test_fetch_raises_when_the_response_holds_no_holidays
    # A 200 that is not the CSV — a maintenance page, say. Every row is skipped
    # for want of the expected header columns, leaving an empty hash that would
    # otherwise be taken for "the Cabinet Office publishes no holidays".
    stub_request(:get, VerifiedHolidays::CabinetOffice::CSV_URL)
      .to_return(status: 200, body: '<html><body>Under maintenance</body></html>')

    error = assert_raises(VerifiedHolidays::CabinetOffice::FetchError) do
      VerifiedHolidays::CabinetOffice.fetch
    end
    assert_includes error.message, 'no holidays'
  end

  def test_parse_raises_on_invalid_date_format
    csv = "国民の祝日・休日月日,国民の祝日・休日名称\ninvalid,元日\n"
    assert_raises(Date::Error) do
      VerifiedHolidays::CabinetOffice.parse(csv)
    end
  end

  def test_fetch_handles_bom
    # BOM in CP932 is the bytes 0xEF 0xBB 0xBF (same as UTF-8 BOM when interpreted as raw bytes)
    csv_utf8 = "国民の祝日・休日月日,国民の祝日・休日名称\n2026/1/1,元日\n"
    csv_cp932 = csv_utf8.encode('CP932')
    # Prepend UTF-8 BOM bytes (which is how the real file looks in raw bytes)
    body_with_bom = "\xEF\xBB\xBF".b + csv_cp932.b

    stub_request(:get, VerifiedHolidays::CabinetOffice::CSV_URL)
      .to_return(body: body_with_bom, status: 200)

    result = VerifiedHolidays::CabinetOffice.fetch
    assert_equal '元日', result[Date.new(2026, 1, 1)]
  end

  def test_parse_skips_rows_with_nil_date
    csv = "国民の祝日・休日月日,国民の祝日・休日名称\n,元日\n2026/1/12,成人の日\n"
    result = VerifiedHolidays::CabinetOffice.parse(csv)
    assert_equal 1, result.size
    assert_equal '成人の日', result[Date.new(2026, 1, 12)]
  end

  def test_parse_skips_rows_with_nil_name
    csv = "国民の祝日・休日月日,国民の祝日・休日名称\n2026/1/1,\n2026/1/12,成人の日\n"
    result = VerifiedHolidays::CabinetOffice.parse(csv)
    assert_equal 1, result.size
    assert_equal '成人の日', result[Date.new(2026, 1, 12)]
  end

  def test_parse_handles_empty_csv
    csv = "国民の祝日・休日月日,国民の祝日・休日名称\n"
    result = VerifiedHolidays::CabinetOffice.parse(csv)
    assert_equal 0, result.size
  end

  def test_parse_skips_rows_with_blank_date
    csv = "国民の祝日・休日月日,国民の祝日・休日名称\n   ,元日\n2026/1/12,成人の日\n"
    result = VerifiedHolidays::CabinetOffice.parse(csv)
    assert_equal 1, result.size
    assert_equal '成人の日', result[Date.new(2026, 1, 12)]
  end

  def test_parse_skips_rows_with_blank_name
    csv = "国民の祝日・休日月日,国民の祝日・休日名称\n2026/1/1,   \n2026/1/12,成人の日\n"
    result = VerifiedHolidays::CabinetOffice.parse(csv)
    assert_equal 1, result.size
    assert_equal '成人の日', result[Date.new(2026, 1, 12)]
  end
end
