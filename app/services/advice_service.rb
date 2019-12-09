require "Faraday"
require "json"
require "pry"

class AdviceService

  def random
    conn = Faraday.new(url: "https://api.adviceslip.com") do |faraday|
      faraday.adapter Faraday.default_adapter
    end

    response = conn.get("/advice")
    json = JSON.parse(response.body, symbolize_names: true)
  end

  def find(slip_id)
    conn = Faraday.new(url: "https://api.adviceslip.com") do |faraday|
      faraday.adapter Faraday.default_adapter
    end

    response = conn.get("/advice/#{slip_id}")
    json = JSON.parse(response.body, symbolize_names: true)
  end

  def search(query)
    conn = Faraday.new(url: "https://api.adviceslip.com") do |faraday|
      faraday.adapter Faraday.default_adapter
    end

    response = conn.get("/advice/search/#{query}")
    json = JSON.parse(response.body, symbolize_names: true)
  end

end
