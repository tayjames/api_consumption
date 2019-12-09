require "Faraday"
require "json"
require "pry"

class AdviceService

  def random
    get_json("/advice")
  end

  def find(slip_id)
    get_json("/advice/#{slip_id}")
  end

  def search(query)
    get_json("/advice/search/#{query}")
  end

  private

  def conn
    Faraday.new(url: "https://api.adviceslip.com") do |faraday|
      faraday.adapter Faraday.default_adapter
    end
  end

  def get_json(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end
