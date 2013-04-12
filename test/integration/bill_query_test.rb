require 'sunlight/congress'
require 'webmock/minitest'

class TestIntegrationCongress < MiniTest::Unit::TestCase
  def setup
    Sunlight::Congress.api_key = "specialapikey"
  end

  def test_bill_query_search
    stub_request(:get, "http://congress.api.sunlightfoundation.com/bills/search?apikey=thisismykey&query=%22health%20care%22")
      .to_return(body: File.new('test/integration/json/bill_query/health_care.json'))

    bills = Sunlight::Congress::BillQuery.search("health care")

    assert_equal "Patient Protection and Affordable Care Act", bills.results[0].short_title
  end

  def test_bill_query_next_page!
    stub_request(:get, "http://congress.api.sunlightfoundation.com/bills/search?apikey=thisismykey&query=%22health%20care%22")
      .to_return(body: File.new('test/integration/json/bill_query/health_care.json'))

    stub_request(:get, "http://congress.api.sunlightfoundation.com/bills/search?apikey=thisismykey&query=%22health%20care%22&page=2")
      .to_return(body: File.new('test/integration/json/bill_query/health_care_page_2.json'))

    bills = Sunlight::Congress::BillQuery.search("health care")
    bills.next_page!

    assert_equal 2, bills.current_page
  end

  def test_bill_query_page!
    stub_request(:get, "http://congress.api.sunlightfoundation.com/bills/search?apikey=thisismykey&query=%22health%20care%22")
      .to_return(body: File.new('test/integration/json/bill_query/health_care.json'))

    stub_request(:get, "http://congress.api.sunlightfoundation.com/bills/search?apikey=thisismykey&query=%22health%20care%22&page=7")
      .to_return(body: File.new('test/integration/json/bill_query/health_care_page_7.json'))

    bills = Sunlight::Congress::BillQuery.search("health care")
    bills.page!(7)

    assert_equal 7, bills.current_page
  end

  def test_bill_query_search_with_filters
    stub_request(:get, "http://congress.api.sunlightfoundation.com/bills/search?apikey=thisismykey&query=%22health%20care%22&bill_type=s")
      .to_return(body: File.new('test/integration/json/bill_query/health_care_bill_type_s.json'))

    bills = Sunlight::Congress::BillQuery.search("health care", :bill_type => 's')

    assert_equal 992, bills.count
    assert_equal 's', bills.results[0].bill_type
  end

  def test_bill_query_fields
    stub_request(:get, "http://congress.api.sunlightfoundation.com/bills?apikey=thisismykey&bill_type=s&congress=111&history.active=true")
      .to_return(body: File.new('test/integration/json/bill_query/fields.json'))

    bills = Sunlight::Congress::BillQuery.by_fields(:bill_type => 's', :congress => 111, 'history.active' => 'true')

    assert_equal 22, bills.count
  end
end
