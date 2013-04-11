require 'sunlight/congress'
require 'webmock/minitest'

class TestIntegrationCongress < MiniTest::Unit::TestCase
  def setup
    Sunlight::Congress.api_key = "specialapikey"
  end

  def test_bills_by_title
    stub_request(:get, "http://congress.api.sunlightfoundation.com/bills/search?apikey=thisismykey&query=Health").
      to_return(:status => 200, :body => '{"results":[{"title":"Awesome Health Care Bill"}]}', :headers => {})

    title = "Health"
    bills = Sunlight::Congress::Bill.by_title(title)

    assert_equal "Awesome Health Care Bill", bills.first.title
  end
end
