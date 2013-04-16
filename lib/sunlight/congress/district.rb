require 'sunlight/congress'

class Sunlight::Congress
  def district
    Sunlight::Congress::District::Finder.new(self.api_key)
  end

  class District
    attr_accessor :state, :district

    def initialize(options)
      self.state = options["state"]
      self.district = options["district"]
    end

    class Finder
      attr_reader :api_key

      def initialize(api_key)
        @api_key = api_key
      end

      def by_zipcode(zipcode)
        uri = URI("#{Sunlight::Congress::BASE_URI}/districts/locate?zip=#{zipcode}&apikey=#{api_key}")

        Sunlight::Congress::District.new(JSON.load(Net::HTTP.get(uri))["results"].first)
      end

      def by_latlong(latitude, longitude)
        uri = URI("#{Sunlight::Congress::BASE_URI}/districts/locate?latitude=#{latitude}&longitude=#{longitude}&apikey=#{api_key}")

        Sunlight::Congress::District.new(JSON.load(Net::HTTP.get(uri))["results"].first)
      end
    end
  end
end
