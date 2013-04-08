require 'net/http'
require 'json'

module Sunlight
  module Congress
  end
end

class Sunlight::Congress::Legislator
  attr_accessor :first_name, :last_name, :website

  def initialize(options)
    self.first_name = options["first_name"]
    self.last_name = options["last_name"]
    self.website = options["website"]
  end

  def self.by_zipcode(zipcode)
    uri = URI("http://congress.api.sunlightfoundation.com/legislators/locate?zip=#{zipcode}&apikey=#{Sunlight::Congress.api_key}")

    JSON.load(Net::HTTP.get(uri))["results"].collect{|json| new(json) }
  end
end
