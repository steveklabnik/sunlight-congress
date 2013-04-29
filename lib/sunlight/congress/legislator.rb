require 'sunlight/congress'

class Sunlight::Congress::Legislator
  attr_accessor :first_name, :last_name, :website

  def initialize(options)
    options.each { |k,v| eval("@#{k}=#{v.inspect}") }
  end

  def self.search(*args)
    Sunlight::Congress::Base.new(self).search(*args)
  end

  def self.by_zipcode(zipcode)
    uri = URI("#{Sunlight::Congress::Base.base_uri}/legislators/locate?zip=#{zipcode}&apikey=#{Sunlight::Congress::Base.api_key}")

    JSON.load(Net::HTTP.get(uri))["results"].collect{|json| new(json) }
  end

  def self.by_latlong(latitude, longitude)
    uri = URI("#{Sunlight::Congress::Base.base_uri}/legislators/locate?latitude=#{latitude}&longitude=#{longitude}&apikey=#{Sunlight::Congress::Base.api_key}")

    JSON.load(Net::HTTP.get(uri))["results"].collect{|json| new(json) }
  end
end
