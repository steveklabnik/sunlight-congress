require 'sunlight/congress'
require 'webmock/minitest'

class TestIntegrationDistrict < MiniTest::Unit::TestCase
  def setup
    Sunlight::Congress.api_key = "thisismykey"
  end

  def test_districts_by_zipcode
    stub_request(:get, "http://congress.api.sunlightfoundation.com/districts/locate?apikey=thisismykey&zip=90210")
      .to_return(body: '{"results":[{"state":"CA","district":28},{"state":"CA","district":30},{"state":"CA","district":33}],"count":3}')

    districts = Sunlight::Congress::District.by_zipcode(90210)

    assert_equal "CA", districts.first.state
    assert districts.any?{|d| d.district == 28}
    assert_equal 3, districts.length
  end
  
  def test_districts_by_location
    stub_request(:get, "http://congress.api.sunlightfoundation.com/districts/locate?apikey=thisismykey&latitude=42.96&longitude=-108.09")
      .to_return(body: '{"results":[{"state":"WY","district":0}],"count":1}')

    districts = Sunlight::Congress::District.by_location(42.96,-108.09)

    assert_equal "WY", districts.first.state
    assert_equal 0, districts.first.district
    assert_equal 1, districts.length
  end
end
