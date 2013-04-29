require 'sunlight/congress'

class Sunlight::Congress::Base

  def self.base_uri
    @base_uri ||= "http://congress.api.sunlightfoundation.com"
  end

  def self.base_uri=(base_uri)
    @base_uri = base_uri
  end

  def self.api_key
    @api_key ||= "c4a172b828c242b9b03c504a47ab6ff5"
  end

  def self.api_key=(api_key)
    @api_key = api_key
  end


  def initialize(klass)
    @klass = klass
  end

  def criteria
    @criteria ||= {:conditions => {}}
  end

  def method
    method = @klass.name.split("::").last
    method << "s" ## cheap hack to pluralize
    method.downcase!
  end

  def search(args)
    criteria[:conditions].merge!(args)
    uri = "#{base_uri}/#{method}?apikey=#{api_key}"
    criteria[:conditions].each do |f,v|
      uri << "&#{f}=#{v}"
    end
    uri = URI(uri)
    parse_response(uri)
  end

  def parse_response(uri)
    response =  JSON.load(Net::HTTP.get(uri))["results"]
    response.collect{|json| @klass.new(json) }
  end

  def base_uri
    self.class.base_uri
  end

  def api_key
    self.class.api_key
  end
end
