require 'sunlight-congress'
require 'webmock/minitest'

class TestIntegrationCongressDistrict < MiniTest::Unit::TestCase
  def setup
    @api = Sunlight::Congress.new("thisismykey")
  end

  def test_districts_by_zipcode
    stub_request(:get, "http://congress.api.sunlightfoundation.com/districts/locate?apikey=thisismykey&zip=12186")
      .to_return(body: '{"results":[{"state":"NY", "district":20}]}')

    district = @api.district.by_zipcode(12186)

    assert_equal "NY", district.state
    assert_equal 20, district.district
  end

  def test_districts_by_latlong
    stub_request(:get, "http://congress.api.sunlightfoundation.com/districts/locate?apikey=thisismykey&latitude=42.6525&longitude=-73.7567")
      .to_return(body: '{"results":[{"state":"NY", "district":20}]}')

    district = @api.district.by_latlong(42.6525, -73.7567)

    assert_equal "NY", district.state
    assert_equal 20, district.district
  end
end
