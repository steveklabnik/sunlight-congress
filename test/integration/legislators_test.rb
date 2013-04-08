require 'sunlight/congress'
require 'webmock/minitest'

class TestIntegrationCongress < MiniTest::Unit::TestCase
  def setup
    Sunlight::Congress.api_key = "thisismykey"
  end

  def test_legislators_by_zipcode
    stub_request(:get, "http://congress.api.sunlightfoundation.com/legislators/locate?apikey=thisismykey&zip=90210")
      .to_return(body: '{"results":[{"first_name":"Joe"}]}')

    legislators = Sunlight::Congress::Legislator.by_zipcode(90210)

    assert_equal "Joe", legislators.first.first_name
  end
end
