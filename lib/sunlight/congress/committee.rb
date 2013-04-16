require 'sunlight/congress'

class Sunlight::Congress
  def committee
    Sunlight::Congress::Committee::Finder.new(self.api_key)
  end

  class Committee
    attr_accessor :chamber, :committee_id, :name, :parent_committee_id, :subcommittee

    def initialize(options)
      self.chamber = options["chamber"]
      self.committee_id = options["committee_id"]
      self.name = options["name"]
      self.parent_committee_id = options["parent_committee_id"]
      self.subcommittee = options["subcommittee"]
    end

    class Finder
      attr_reader :api_key

      def initialize(api_key)
        @api_key = api_key
      end

      def by_committee_id(committee_id)
        uri = URI("#{Sunlight::Congress::BASE_URI}/committees?committee_id=#{committee_id}&apikey=#{api_key}")

        JSON.load(Net::HTTP.get(uri))["results"].collect do |json|
          Sunlight::Congress::Committee.new(json)
        end
      end
    end
  end
end
