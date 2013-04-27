require 'sunlight/congress'

class Sunlight::Congress::Base

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
    uri = "#{Sunlight::Congress::BASE_URI}/#{method}?apikey=#{Sunlight::Congress.api_key}"
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
end
