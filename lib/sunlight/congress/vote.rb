require 'sunlight/congress'

class Sunlight::Congress::Vote < OpenStruct
  def self.by_question(question)
    votes_by :query, question
  end

  def self.by_year(year)
    votes_by :year, year
  end

  def self.by_required_amount(required_amount)
    votes_by :required, format_argument(required_amount, "/")
  end

  def self.by_result(result)
    votes_by :result, format_argument(result, " ")
  end

  def self.by_chamber(chamber)
    votes_by :chamber, chamber.downcase
  end

  def self.format_argument(argument, character)
    URI.escape(argument, character)
  end

  def self.uri(query_method, query_value)
    URI("#{Sunlight::Congress::BASE_URI}/votes?#{query_method}=#{query_value}&apikey=#{Sunlight::Congress.api_key}")
  end

  def self.votes_by(query_method, query_value)
    response = Net::HTTP.get(uri(query_method, query_value))
    response_hash = JSON.load(response)
    response_hash["results"].collect{ |vote| self.new(vote) }
  end

  private_class_method :uri, :votes_by, :format_argument
end
