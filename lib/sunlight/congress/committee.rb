require 'sunlight/congress'

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
    uri = URI("#{Sunlight::Congress::Base.base_uri}/committees?committee_id=#{committee_id}&apikey=#{Sunlight::Congress::Base.api_key}")

    JSON.load(Net::HTTP.get(uri))["results"].collect{|json| new(json) }
  end
end
