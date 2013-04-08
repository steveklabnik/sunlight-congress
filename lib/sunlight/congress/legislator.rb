require 'net/http'
require 'json'

module Sunlight
  module Congress
    def self.api_key
      @api_key
    end

    def self.api_key=(api_key)
      @api_key = api_key
    end
  end
end

class Sunlight::Congress::Legislator
  attr_accessor :first_name

  def initialize(options)
    self.first_name = options["first_name"]
  end

  def self.by_zipcode(zipcode)
    uri = URI("http://congress.api.sunlightfoundation.com/legislators/locate?zip=#{zipcode}&apikey=#{Sunlight::Congress.api_key}")

    JSON.load(Net::HTTP.get(uri))["results"].collect{|json| new(json) }
  end
end
