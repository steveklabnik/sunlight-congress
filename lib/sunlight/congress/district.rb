require 'net/http'
require 'json'

module Sunlight
  module Congress
  end
end

class Sunlight::Congress::District
  attr_accessor :state, :district

  def initialize(options)
    self.state = options["state"]
    self.district = options["district"]
  end

  def self.by_zipcode(zipcode)
    uri = URI("http://congress.api.sunlightfoundation.com/districts/locate?zip=#{zipcode}&apikey=#{Sunlight::Congress.api_key}")

    JSON.load(Net::HTTP.get(uri))["results"].collect{|json| new(json) }
  end
  
  def self.by_location(latitude, longitude)
    uri = URI("http://congress.api.sunlightfoundation.com/districts/locate?latitude=42.96&longitude=-108.09&apikey=#{Sunlight::Congress.api_key}")

    JSON.load(Net::HTTP.get(uri))["results"].collect{|json| new(json) }    
  end
end
