require 'sunlight/congress'
require 'webmock/minitest'

class TestIntegrationCongressBill < MiniTest::Unit::TestCase
  def setup
    @api = Sunlight::Congress.new("thisismykey")
  end

  def test_bills_by_title
    stub_request(:get, "http://congress.api.sunlightfoundation.com/bills/search?apikey=thisismykey&query=Health").
      to_return(:status => 200, :body => '{"results":[{"title":"Awesome Health Care Bill"}]}', :headers => {})

    title = "Health"
    bills = @api.bill.by_title(title)

    assert_equal "Awesome Health Care Bill", bills.first.title
  end

  def test_bills_by_id
    stub_request(:get, "http://congress.api.sunlightfoundation.com/bills?bill_id=s668-113&apikey=thisismykey").
          to_return(:status => 200, :body => '{"results":[{"bill_id":"s668-113"}]}')
    bill = @api.bill.by_bill_id("s668-113")

    assert_equal "s668-113", bill.bill_id
  end
end
