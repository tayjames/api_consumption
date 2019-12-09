require "Faraday"
require "json"
require "pry"

class ChuckService

  def random
    get_json("/jokes/random")
  end

  def random_in_category(category)
    get_json("/jokes/random?category=#{category}")
  end

  def categories
    get_json("/jokes/categories")
  end

  def search(query)
    get_json("/jokes/search?query=#{query}")
  end

  private

  def conn
    Faraday.new(url: "https://api.chucknorris.io") do |f|
      f.adapter Faraday.default_adapter
    end
  end

  def get_json(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end
