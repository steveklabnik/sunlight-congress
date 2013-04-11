require 'sunlight/congress'

class Sunlight::Congress::Bill
  attr_accessor :title

  def initialize(options)
    self.title = options["title"]
  end

  def self.by_title(title)
    uri = URI("#{Sunlight::Congress::BASE_URI}/bills/search?query=#{title}&apikey=#{Sunlight::Congress.api_key}")

    JSON.load(Net::HTTP.get(uri))["results"].collect{|json| new(json)}
  end
end
