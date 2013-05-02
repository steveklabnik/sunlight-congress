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
    get_resource(uri)
  end

  private
  def self.parse_response(uri)
    Sunlight::Congress::Base.new(self).parse_response(uri)
  end

  def self.get_resource(uri)
    response = JSON.load(Net::HTTP.get(uri))["results"]
    Sunlight::Congress::Base.new(self).parse_response(response)
  end
end
