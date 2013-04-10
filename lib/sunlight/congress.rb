require 'net/http'
require 'json'
require "sunlight/congress/version"

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
