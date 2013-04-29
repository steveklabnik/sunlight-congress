require 'sunlight/congress'

class Sunlight::Congress::Legislator
  attr_accessor :bioguide_id, :birthday, :chamber, :contact_form, :crp_id, :district, :facebook_id, :fax, :fec_ids, :first_name, :gender, :govtrack_id, :in_office, :last_name, :lis_id, :middle_name, :name_suffix, :nickname, :office, :party, :phone, :senate_class, :state, :state_name, :state_rank, :thomas_id, :title, :twitter_id, :votesmart_id, :website, :youtube_id

  def initialize(options)
    options.each { |k,v| eval("@#{k}=#{v.inspect}") }
  end

  def self.by_zipcode(zipcode)
    uri = URI("#{Sunlight::Congress::BASE_URI}/legislators/locate?zip=#{zipcode}&apikey=#{Sunlight::Congress.api_key}")

    JSON.load(Net::HTTP.get(uri))["results"].collect{|json| new(json) }
  end

  def self.by_latlong(latitude, longitude)
    uri = URI("#{Sunlight::Congress::BASE_URI}/legislators/locate?latitude=#{latitude}&longitude=#{longitude}&apikey=#{Sunlight::Congress.api_key}")

    JSON.load(Net::HTTP.get(uri))["results"].collect{|json| new(json) }
  end

  def self.by_name(name)
    uri = URI("#{Sunlight::Congress::BASE_URI}/legislators?query=#{name}&apikey=#{Sunlight::Congress.api_key}")
    JSON.load(Net::HTTP.get(uri))["results"].collect{|json| new(json) }

  end

  def self.by_state(state)
    if state.size == 2
      state_search, state_param = "state", state.upcase
    else
      state_search, state_param = "state_name", state.capitalize
    end

    uri = URI("#{Sunlight::Congress::BASE_URI}/legislators?#{state_search}=#{state_param}&apikey=#{Sunlight::Congress.api_key}")
    JSON.load(Net::HTTP.get(uri))["results"].collect{|json| new(json) }
  end
end
