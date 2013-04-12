require 'sunlight/congress'

class Sunlight::Congress::BillQuery
  attr_accessor :count, :per_page, :current_page, :current_page_count,
                :pages, :results

  def initialize(response, uri)
    @uri                = uri
    @results            = response['results'].collect { |json| Sunlight::Congress::Bill.new(json) }
    @count              = response['count']
    @per_page           = response['page']['per_page']
    @current_page       = response['page']['page']
    @current_page_count = response['page']['count']
    @pages          = ((@count / @per_page) + 0.5).round
  end

  def page(page_num)
    return false unless page_num <= @pages

    new_uri = URI("#{@uri}&page=#{page_num}")
    JSON.load(Net::HTTP.get(new_uri))['results'].collect { |json| Sunlight::Congress::Bill.new(json) }
  end

  def page!(page_num)
    return false unless page_num <= @pages

    new_uri = URI("#{@uri}&page=#{page_num}")
    response = JSON.load(Net::HTTP.get(new_uri))

    @current_page = response['page']['page']
    @current_page_count = response['page']['count']
    @results = response['results'].collect { |json| Sunlight::Congress::Bill.new(json) }
  end

  def next_page!
    return false unless (@current_page + 1) <= @pages

    @current_page += 1
    new_uri = URI("#{@uri}&page=#{@current_page}")
    response = JSON.load(Net::HTTP.get(new_uri))

    @current_page_count = response['page']['count']
    @results = response['results'].collect { |json| Sunlight::Congress::Bill.new(json) }
  end

  def self.search(query, filters = {})
    args = filters.inject("") { |str, arr| str << "&#{arr[0]}=#{arr[1]}" }
    uri = URI(URI.escape("#{Sunlight::Congress::BASE_URI}/bills/search?query=\"#{query}\"&apikey=#{Sunlight::Congress.api_key}#{args}"))

    new(JSON.load(Net::HTTP.get(uri)), uri)
  end

  def self.by_fields(filters = {})
    args = filters.inject("") { |str, arr| str << "&#{arr[0]}=#{arr[1]}" }
    uri = URI(URI.escape("#{Sunlight::Congress::BASE_URI}/bills?apikey=#{Sunlight::Congress.api_key}#{args}"))

    new(JSON.load(Net::HTTP.get(uri)), uri)
  end
end
