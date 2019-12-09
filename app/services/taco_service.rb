require "Faraday"
require "json"
require "pry"

class TacoService

  def random_ingredients
    get_json("/random/")
  end

  def random_taco
    get_json("/random/?full-taco=true")
  end

  def contributors
    get_json("/contributions/")
  end

  def contributions(contributor)
    get_json("/contributions/#{contributor}/")
  end

  def ingredients_by_type(recipe_type)
    get_json("/contributors/#{recipe_type}/")
  end

  def contributors_by_ingredient(recipe_type, recipe_slug)
    get_json("/contributors/#{recipe_type}/#{recipe_slug}/")
  end

  private

  def conn
    conn = Faraday.new("http://taco-randomizer.herokuapp.com") do |f|
      f.adapter Faraday.default_adapter
    end
  end

  def get_json(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end
