require 'net/http'
require 'json'
require 'ostruct'

module Sunlight
  module Congress
    BASE_URI = "https://congress.api.sunlightfoundation.com"

    def self.api_key
      @api_key
    end

    def self.api_key=(api_key)
      @api_key = api_key
    end
  end
end
