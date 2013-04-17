require 'sunlight/congress'

class Sunlight::Congress
  def legislator
    Sunlight::Congress::Legislator::Finder.new(self.api_key)
  end

  class Legislator
    attr_accessor :first_name, :last_name, :website

    def initialize(options)
      self.first_name = options["first_name"]
      self.last_name = options["last_name"]
      self.website = options["website"]
    end

    def self.by_zipcode(zipcode)
      uri = URI("#{Sunlight::Congress::BASE_URI}/legislators/locate?zip=#{zipcode}&apikey=#{Sunlight::Congress.api_key}")

      JSON.load(Net::HTTP.get(uri))["results"].collect{|json| new(json) }
    end

    def self.by_latlong(latitude, longitude)
      uri = URI("#{Sunlight::Congress::BASE_URI}/legislators/locate?latitude=#{latitude}&longitude=#{longitude}&apikey=#{Sunlight::Congress.api_key}")

      JSON.load(Net::HTTP.get(uri))["results"].collect{|json| new(json) }
    end

    class Finder
      attr_reader :api_key

      def initialize(api_key)
        @api_key = api_key
      end

      def by_zipcode(zipcode)
        uri = URI("#{Sunlight::Congress::BASE_URI}/legislators/locate?zip=#{zipcode}&apikey=#{api_key}")

        JSON.load(Net::HTTP.get(uri))["results"].collect do |json|
          Sunlight::Congress::Legislator.new(json)
        end
      end

      def by_latlong(latitude, longitude)
        uri = URI("#{Sunlight::Congress::BASE_URI}/legislators/locate?latitude=#{latitude}&longitude=#{longitude}&apikey=#{api_key}")

        JSON.load(Net::HTTP.get(uri))["results"].collect do |json|
          Sunlight::Congress::Legislator.new(json)
        end
      end
    end
  end
end
