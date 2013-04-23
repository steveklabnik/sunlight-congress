require 'sunlight/congress'
require 'webmock/minitest'

# This stuff is behavior from initial development. It can be removed with a
# major version bump.

class TestIntegrationCongressBillQueryOldAPI < MiniTest::Unit::TestCase
  def setup
    Sunlight::Congress.api_key = "thisismykey"
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

class TestIntegrationCongressBillOldAPI < MiniTest::Unit::TestCase
  def setup
    Sunlight::Congress.api_key = "thisismykey"
  end

  def test_bills_by_title
    stub_request(:get, "http://congress.api.sunlightfoundation.com/bills/search?apikey=thisismykey&query=Health").
      to_return(:status => 200, :body => '{"results":[{"title":"Awesome Health Care Bill"}]}', :headers => {})

    title = "Health"
    bills = Sunlight::Congress::Bill.by_title(title)

    assert_equal "Awesome Health Care Bill", bills.first.title
  end

  def test_bills_by_id
    stub_request(:get, "http://congress.api.sunlightfoundation.com/bills?bill_id=s668-113&apikey=thisismykey").
          to_return(:status => 200, :body => '{"results":[{"bill_id":"s668-113"}]}')
    bill = Sunlight::Congress::Bill.by_bill_id("s668-113")

    assert_equal "s668-113", bill.bill_id
  end
end

class TestIntegrationCongressCommitteeOldAPI < MiniTest::Unit::TestCase
  def setup
    Sunlight::Congress.api_key = "thisismykey"
  end

  def test_committees_by_committee_id
    committee_id = 'SSAS13'
    stub_request(:get, "http://congress.api.sunlightfoundation.com/committees?committee_id=#{committee_id}&apikey=thisismykey")
      .to_return(body: '{"results":[{"chamber":"senate", "name":"SeaPower", "parent_committee_id":"SSAS", "subcommittee":true}]}')

    committee = Sunlight::Congress::Committee.by_committee_id(committee_id)

    assert_equal "SeaPower", committee.first.name
  end
end

class TestIntegrationCongressDistrictOldAPI < MiniTest::Unit::TestCase
  def setup
    Sunlight::Congress.api_key = "thisismykey"
  end

  def test_districts_by_zipcode
    stub_request(:get, "http://congress.api.sunlightfoundation.com/districts/locate?apikey=thisismykey&zip=12186")
      .to_return(body: '{"results":[{"state":"NY", "district":20}]}')

    district = Sunlight::Congress::District.by_zipcode(12186)

    assert_equal "NY", district.state
    assert_equal 20, district.district
  end

  def test_districts_by_latlong
    stub_request(:get, "http://congress.api.sunlightfoundation.com/districts/locate?apikey=thisismykey&latitude=42.6525&longitude=-73.7567")
      .to_return(body: '{"results":[{"state":"NY", "district":20}]}')

    district = Sunlight::Congress::District.by_latlong(42.6525, -73.7567)

    assert_equal "NY", district.state
    assert_equal 20, district.district
  end
end

class TestIntegrationCongressLegislatorOldAPI < MiniTest::Unit::TestCase
  def setup
    Sunlight::Congress.api_key = "thisismykey"
  end

  def test_legislators_by_zipcode
    stub_request(:get, "http://congress.api.sunlightfoundation.com/legislators/locate?apikey=thisismykey&zip=90210")
      .to_return(body: '{"results":[{"first_name":"Joe"}]}')

    legislators = Sunlight::Congress::Legislator.by_zipcode(90210)

    assert_equal "Joe", legislators.first.first_name
  end

  def test_districts_by_latlong
    stub_request(:get, "http://congress.api.sunlightfoundation.com/legislators/locate?apikey=thisismykey&latitude=42.6525&longitude=-73.7567")
      .to_return(body: '{"results":[{"first_name":"Joe"}]}')

    legislators = Sunlight::Congress::Legislator.by_latlong(42.6525, -73.7567)

    assert_equal "Joe", legislators.first.first_name
  end
end

