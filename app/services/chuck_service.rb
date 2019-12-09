require "Faraday"
require "json"
require "pry"

class ChuckService

  def random
    conn = Faraday.new(url: "https://api.chucknorris.io") do |f|
      f.adapter Faraday.default_adapter
    end

    response = conn.get("/jokes/random")
    json = JSON.parse(response.body, symbolize_names: true)
  end

  def random_in_category(category)
    conn = Faraday.new(url: "https://api.chucknorris.io") do |f|
      f.adapter Faraday.default_adapter
    end

    response = conn.get("/jokes/random?category=#{category}")
    json = JSON.parse(response.body, symbolize_names: true)
  end

  def categories
    conn = Faraday.new(url: "https://api.chucknorris.io") do |f|
      f.adapter Faraday.default_adapter
    end

    response = conn.get("/jokes/categories")
    json = JSON.parse(response.body, symbolize_names: true)
  end

  def search(query)
    conn = Faraday.new("https://api.chucknorris.io") do |f|
      f.adapter Faraday.default_adapter
    end

    response = conn.get("/jokes/search?query=#{query}")
    json = JSON.parse(response.body, symbolize_names: true)
  end
end
