require 'sunlight/congress'

class Sunlight::Congress::District
  attr_accessor :state, :district

  def initialize(options)
    self.state = options["state"]
    self.district = options["district"]
  end

  def self.by_zipcode(zipcode)
    uri = URI("#{Sunlight::Congress::Base.base_uri}/districts/locate?zip=#{zipcode}&apikey=#{Sunlight::Congress::Base.api_key}")

    new(JSON.load(Net::HTTP.get(uri))["results"].first)
  end

  def self.by_latlong(latitude, longitude)
    uri = URI("#{Sunlight::Congress::Base.base_uri}/districts/locate?latitude=#{latitude}&longitude=#{longitude}&apikey=#{Sunlight::Congress::Base.api_key}")

    new(JSON.load(Net::HTTP.get(uri))["results"].first)
  end
end
