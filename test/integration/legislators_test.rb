require 'sunlight/congress'
require 'webmock/minitest'

class TestIntegrationCongress < MiniTest::Unit::TestCase
  def setup
    Sunlight::Congress.api_key = "thisismykey"
  end

  def test_legislators_by_zipcode
    stub_request(:get, "https://congress.api.sunlightfoundation.com/legislators/locate?apikey=thisismykey&zip=90210")
      .to_return(body: '{"results":[{"first_name":"Joe"}]}')

    legislators = Sunlight::Congress::Legislator.by_zipcode(90210)

    assert_equal "Joe", legislators.first.first_name
  end

  def test_districts_by_latlong
    stub_request(:get, "https://congress.api.sunlightfoundation.com/legislators/locate?apikey=thisismykey&latitude=42.6525&longitude=-73.7567")
      .to_return(body: '{"results":[{"first_name":"Joe"}]}')

    legislators = Sunlight::Congress::Legislator.by_latlong(42.6525, -73.7567)

    assert_equal "Joe", legislators.first.first_name
  end

  def test_legislators_by_name
    stub_request(:get, "https://congress.api.sunlightfoundation.com/legislators?query=joe&apikey=thisismykey")
      .to_return(body: '{"results":[{"first_name":"Joe"}]}')

    legislators = Sunlight::Congress::Legislator.by_name("joe")

    assert_equal "Joe", legislators.first.first_name
  end

  def test_legislators_by_state
    stub_request(:get, "https://congress.api.sunlightfoundation.com/legislators?state=CA&apikey=thisismykey")
      .to_return(body: '{"results": [{"first_name":"Joe",
                                       "state":"CA",
                                       "state_name":"California"}]}')

    legislators = Sunlight::Congress::Legislator.by_state("CA")

    assert_equal "CA", legislators.first.state
    assert_equal "California", legislators.first.state_name

    stub_request(:get, "https://congress.api.sunlightfoundation.com/legislators?state_name=California&apikey=thisismykey")
      .to_return(body: '{"results": [{"first_name":"Joe",
                                       "state":"CA",
                                       "state_name":"California"}]}')

    legislators = Sunlight::Congress::Legislator.by_state("California")

    assert_equal "CA", legislators.first.state
    assert_equal "California", legislators.first.state_name
  end
end
