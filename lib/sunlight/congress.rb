require "sunlight/congress/version"
require "sunlight/congress/legislator"
require "sunlight/congress/district"
require "sunlight/congress/committee"

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
