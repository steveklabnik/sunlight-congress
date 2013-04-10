require 'sunlight/congress' unless defined?(Sunlight::Congress)

class Sunlight::Congress::Committee
  attr_accessor :chamber, :committee_id, :name, :parent_committee_id, :subcommittee

  def initialize(options)
    self.chamber = options["chamber"]
    self.committee_id = options["committee_id"]
    self.name = options["name"]
    self.parent_committee_id = options["parent_committee_id"]
    self.subcommittee = options["subcommittee"]
  end

  def self.by_committee_id(committee_id)
    uri = URI("http://congress.api.sunlightfoundation.com/committees?committee_id=#{committee_id}&apikey=#{Sunlight::Congress.api_key}")

    JSON.load(Net::HTTP.get(uri))["results"].collect{|json| new(json) }
  end
end
