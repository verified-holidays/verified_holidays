# frozen_string_literal: true

require 'test_helper'
require 'webmock/minitest'

class TestVerifier < Minitest::Test
  def setup
    # Build a small CSV that matches a subset of our local data
    @csv_matching = csv_from_entries([
                                       ['2026/1/1', '元日'],
                                       ['2026/1/12', '成人の日'],
                                       ['2026/2/11', '建国記念の日'],
                                     ])
  end

  def test_valid_when_data_matches
    stub_cabinet_office(@csv_matching)
    result = VerifiedHolidays.verify!
    assert result.valid?
    assert_empty result.missing
    assert_empty result.extra
    assert_empty result.mismatched
  end

  def test_extra_when_cabinet_has_more
    csv = csv_from_entries([
                             ['2026/1/1', '元日'],
                             ['2026/1/12', '成人の日'],
                             ['2026/2/11', '建国記念の日'],
                             ['2026/2/23', '天皇誕生日'],
                           ])
    stub_cabinet_office(csv)
    result = VerifiedHolidays.verify!
    # Should still be valid since our local data also has Feb 23
    assert result.valid?
  end

  def test_extra_detected_for_unknown_date
    csv = csv_from_entries([
                             ['2026/1/1', '元日'],
                             ['2026/1/2', 'テスト祝日'],
                           ])
    stub_cabinet_office(csv)
    result = VerifiedHolidays.verify!
    refute result.valid?
    assert(result.extra.any? { |e| e[:name] == 'テスト祝日' })
  end

  def test_missing_detected_single_date_range
    # Cabinet Office CSV only has Jan 1, range is just that one day, so no missing
    csv = csv_from_entries([
                             ['2026/1/1', '元日'],
                           ])
    stub_cabinet_office(csv)
    result = VerifiedHolidays.verify!
    assert result.valid?
  end

  def test_missing_detected_when_local_has_extra_in_range
    # Cabinet CSV spans Jan 1 to Feb 11 but omits Jan 12 (成人の日).
    # Local data has Jan 12 in that range, so it should be reported as missing from cabinet.
    csv = csv_from_entries([
                             ['2026/1/1', '元日'],
                             ['2026/2/11', '建国記念の日'],
                           ])
    stub_cabinet_office(csv)
    result = VerifiedHolidays.verify!
    refute result.valid?
    assert(result.missing.any? { |e| e[:date] == Date.new(2026, 1, 12) && e[:name] == '成人の日' })
  end

  def test_mismatched_name
    csv = csv_from_entries([
                             ['2026/1/1', '新年'],
                           ])
    stub_cabinet_office(csv)
    result = VerifiedHolidays.verify!
    refute result.valid?
    assert(result.mismatched.any? { |e| e[:date] == Date.new(2026, 1, 1) })
  end

  def test_result_attributes
    csv = csv_from_entries([
                             ['2026/1/1', '新年'],
                             ['2026/1/2', 'テスト'],
                           ])
    stub_cabinet_office(csv)
    result = VerifiedHolidays.verify!

    refute result.valid?
    assert_kind_of Array, result.missing
    assert_kind_of Array, result.extra
    assert_kind_of Array, result.mismatched
  end

  private

  def csv_from_entries(entries)
    lines = ['国民の祝日・休日月日,国民の祝日・休日名称']
    entries.each { |date, name| lines << "#{date},#{name}" }
    "#{lines.join("\n")}\n"
  end

  def stub_cabinet_office(csv_utf8)
    csv_cp932 = csv_utf8.encode('CP932')
    stub_request(:get, VerifiedHolidays::CabinetOffice::CSV_URL)
      .to_return(body: csv_cp932.b, status: 200)
  end
end
