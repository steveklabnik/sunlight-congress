require 'sunlight/congress'
require 'webmock/minitest'

# This stuff is behavior from initial development. It can be removed with a
# major version bump.
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

class TestIntegrationCongressLegislator < MiniTest::Unit::TestCase
  def setup
    @api = Sunlight::Congress.new("thisismykey")
  end

  def test_legislators_by_zipcode
    stub_request(:get, "http://congress.api.sunlightfoundation.com/legislators/locate?apikey=thisismykey&zip=90210")
      .to_return(body: '{"results":[{"first_name":"Joe"}]}')

    legislators = @api.legislator.by_zipcode(90210)

    assert_equal "Joe", legislators.first.first_name
  end

  def test_districts_by_latlong
    stub_request(:get, "http://congress.api.sunlightfoundation.com/legislators/locate?apikey=thisismykey&latitude=42.6525&longitude=-73.7567")
      .to_return(body: '{"results":[{"first_name":"Joe"}]}')

    legislators = @api.legislator.by_latlong(42.6525, -73.7567)

    assert_equal "Joe", legislators.first.first_name
  end
end
