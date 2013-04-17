require 'sunlight/congress'
require 'webmock/minitest'

# This stuff is behavior from initial development. It can be removed with a
# major version bump.
class TestIntegrationCongressCommitteeOLDAPI < MiniTest::Unit::TestCase
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

class TestIntegrationCongressCommittee < MiniTest::Unit::TestCase
  def setup
    @api = Sunlight::Congress.new("thisismykey")
  end

  def test_committees_by_committee_id
    committee_id = 'SSAS13'
    stub_request(:get, "http://congress.api.sunlightfoundation.com/committees?committee_id=#{committee_id}&apikey=thisismykey")
      .to_return(body: '{"results":[{"chamber":"senate", "name":"SeaPower", "parent_committee_id":"SSAS", "subcommittee":true}]}')

    committee = @api.committee.by_committee_id(committee_id)

    assert_equal "SeaPower", committee.first.name
  end
end
