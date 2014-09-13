require 'sunlight/congress'
require 'webmock/minitest'

class TestIntegrationCongress < MiniTest::Unit::TestCase
  def setup
    Sunlight::Congress.api_key = "thisismykey"
  end

  def test_committees_by_committee_id
    committee_id = 'SSAS13'
    stub_request(:get, "https://congress.api.sunlightfoundation.com/committees?committee_id=#{committee_id}&apikey=thisismykey")
      .to_return(body: '{"results":[{"chamber":"senate", "name":"SeaPower", "parent_committee_id":"SSAS", "subcommittee":true}]}')

    committee = Sunlight::Congress::Committee.by_committee_id(committee_id)

    assert_equal "SeaPower", committee.first.name
  end
end
