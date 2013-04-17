require 'net/http'
require 'json'
require 'ostruct'

module Sunlight
  class Congress
    BASE_URI = "http://congress.api.sunlightfoundation.com"

    attr_reader :api_key

    def initialize(api_key)
      @api_key = api_key
    end

    def self.api_key
      @api_key
    end

    def self.api_key=(api_key)
      @api_key = api_key
    end
  end
end
