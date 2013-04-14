require 'sunlight/congress/vote'
require 'webmock/minitest'
require 'minitest/autorun'

class TestIntegrationVote < MiniTest::Unit::TestCase
  def setup
    Sunlight::Congress.api_key = 'thisismykey'
  end

  def test_vote_by_question
    stub_request(:get, "http://congress.api.sunlightfoundation.com/votes?query=food&apikey=thisismykey")
      .to_return(body: '{"results":[{"year":"2013"}]}')

    votes = Sunlight::Congress::Vote.by_question('food')

    assert_equal "2013", votes.first.year
  end

  def test_vote_by_year
    stub_request(:get, "http://congress.api.sunlightfoundation.com/votes?year=2013&apikey=thisismykey")
      .to_return(body: '{"results":[{"year":"2013"}]}')

    votes = Sunlight::Congress::Vote.by_year(2013)

    assert_equal '2013', votes.first.year
  end

  def test_vote_by_required_amount
    stub_request(:get, "http://congress.api.sunlightfoundation.com/votes?required=2%2F3&apikey=thisismykey")
      .to_return(body: '{"results":[{"required":"2/3"}]}')

    votes = Sunlight::Congress::Vote.by_required_amount('2/3')

    assert_equal '2/3', votes.first.required
  end

  def test_vote_by_result
    stub_request(:get, "http://congress.api.sunlightfoundation.com/votes?result=Passed&apikey=thisismykey")
      .to_return(body: '{"results":[{"result":"Passed"}]}')

    votes = Sunlight::Congress::Vote.by_result('Passed')

    assert_equal 'Passed', votes.first.result
  end

  def test_vote_by_result_takes_string_with_spaces
    stub_request(:get, "http://congress.api.sunlightfoundation.com/votes?result=Bill%20Passed&apikey=thisismykey")
      .to_return(body: '{"results":[{"result":"Bill Passed"}]}')

    votes = Sunlight::Congress::Vote.by_result('Bill Passed')

    assert_equal 'Bill Passed', votes.first.result
  end

  def test_vote_by_chamber
    stub_request(:get, "http://congress.api.sunlightfoundation.com/votes?chamber=house&apikey=thisismykey")
      .to_return(body: '{"results":[{"chamber":"house"}]}')

    votes = Sunlight::Congress::Vote.by_chamber('house')

    assert_equal 'house', votes.first.chamber
  end
end
