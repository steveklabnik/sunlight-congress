require 'active_support/configurable'
require 'active_support/core_ext/object/blank'

module Sunlight::Congress
  class Base
    include ActiveSupport::Configurable

    CONFIGS = [
      :base_uri, :api_key
    ]
    config_accessor *CONFIGS

    self.api_key = ""
    self.base_uri = "http://congress.api.sunlightfoundation.com"

    def self.configured?
      base_uri.present? && api_key.present?
    end

    def initialize(klass)
      @klass = klass
    end

    def parse_response(response)
      response.collect{|json| @klass.new(json) }
    end
  end
end
