require "sunlight/congress/version"
require "sunlight/congress/legislator"
require "sunlight/congress/district"
require "sunlight/congress/committee"

module Sunlight
  module Congress
    BASE_URI = "http://congress.api.sunlightfoundation.com"

    def self.api_key
      @api_key
    end

    def self.api_key=(api_key)
      @api_key = api_key
    end
  end
end
