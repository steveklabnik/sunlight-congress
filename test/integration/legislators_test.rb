require 'sunlight/congress'
require 'webmock/minitest'

class TestIntegrationCongress < MiniTest::Unit::TestCase
  def setup
    Sunlight::Congress::Base.api_key = "thisismykey"
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

  def test_legislators_by_search
    stub_request(:get, "http://congress.api.sunlightfoundation.com/legislators?state=CA&chamber=senate&apikey=thisismykey")
      .to_return(body: File.new('test/integration/json/legislator_query/fields.json'))

    legislators = Sunlight::Congress::Legislator.search(state: "CA", chamber: "senate")

    assert_equal 2, legislators.size
    assert_equal "Barbara", legislators.first.first_name
    assert_equal "Dianne", legislators.last.first_name
    assert_equal "senate", legislators.last.chamber
  end
end
