require 'sunlight/congress'

class Sunlight::Congress::FloorUpdates
  attr_accessor :chamber, :timestamp, :congress, :year, :legislative_day, :bill_ids, :roll_ids, :legislator_ids, :update

  def initialize(options)
    options.each { |k,v| eval("@#{k}=#{v.inspect}") }
  end

  def self.by_bill_id(bill_id)
    get_resource(:bill_ids => bill_id)
  end

  def self.by_congress(congress)
    get_resource(:congress => congress)
  end

  def self.by_term(term)
    get_resource(:query => term)
  end

  def self.by_chamber(chamber)
    get_resource(:chamber => chamber)
  end

  def self.by_legislator(bioguide_id)
    get_resource(:legislator_ids => bioguide_id)
  end

  private

  def self.get_resource(query={})
    JSON.load(Net::HTTP.get(sunlight_uri(query)))["results"].collect{|json| new(json) }
  end

  def self.sunlight_uri(query={})
    query = URI.encode(query.merge({:apikey => Sunlight::Congress.api_key}).collect { |k,v|  "#{k.to_s}=#{v.to_s}"}.join("&"))
    URI("#{Sunlight::Congress::BASE_URI}/floor_updates?#{query}")
  end
end
