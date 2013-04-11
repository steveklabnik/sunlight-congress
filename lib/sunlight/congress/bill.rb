require 'sunlight/congress'

class Sunlight::Congress::Bill
  attr_accessor :title, :bill_id, :bill_type, :number, :congress, :chamber,
    :introduced_on, :last_action_at, :last_vote_at, :last_version_on,
    :sponsor_id, :nicknames, :urls, :committee_ids, :official_title,
    :cosponsors_count, :history, :short_title, :enacted_as, :search,
    :popular_title, :related_bill_ids, :last_version,
    :withdrawn_cosponsors_count

  def initialize(options)
    self.title                      = options["title"]
    self.bill_id                    = options["bill_id"]
    self.bill_type                  = options["bill_type"]
    self.number                     = options["number"]
    self.congress                   = options["congress"]
    self.chamber                    = options["chamber"]
    self.introduced_on              = options["introduced_on"]
    self.last_action_at             = options["last_action_at"]
    self.last_vote_at               = options["last_vote_at"]
    self.last_version_on            = options["last_version_on"]
    self.nicknames                  = options["nicknames"]
    self.sponsor_id                 = options["sponsor_id"]
    self.urls                       = OpenStruct.new(options["urls"])
    self.committee_ids              = options["committee_ids"]
    self.official_title             = options["official_title"]
    self.cosponsors_count           = options["cosponsors_count"]
    self.history                    = OpenStruct.new(options["history"])
    self.short_title                = options["short_title"]
    self.enacted_as                 = OpenStruct.new(options["enacted_as"])
    self.popular_title              = options["popular_title"]
    self.related_bill_ids           = options["related_bill_ids"]
    self.last_version               = OpenStruct.new(options["last_version"])
    self.last_version.urls          = OpenStruct.new(self.last_version.urls)
    self.withdrawn_cosponsors_count = options["withdrawn_cosponsors_count"]
    self.search                     = OpenStruct.new(options["search"])
  end

  def self.by_title(title)
    uri = URI("#{Sunlight::Congress::BASE_URI}/bills/search?query=#{title}&apikey=#{Sunlight::Congress.api_key}")

    JSON.load(Net::HTTP.get(uri))["results"].collect{|json| new(json)}
  end

  def self.by_congress(congress)
    uri = URI("http://congress.api.sunlightfoundation.com/bills?congress=#{congress}&apikey=#{Sunlight::Congress.api_key}")

    JSON.load(Net::HTTP.get(uri))["results"].collect{|json| new(json) }
  end

  def self.by_term(term)
    uri = URI("http://congress.api.sunlightfoundation.com/bills/search?query='#{term}'&apikey=#{Sunlight::Congress.api_key}")

    JSON.load(Net::HTTP.get(uri))["results"].collect{|json| new(json) }
  end

  def self.by_sponsor_party(party)
    party = party[0].upcase
    uri = URI("http://congress.api.sunlightfoundation.com/bills?sponsor.party='#{party}'&apikey=#{Sunlight::Congress.api_key}")

    JSON.load(Net::HTTP.get(uri))["results"].collect{|json| new(json) }
  end
end
