require "Faraday"
require "json"
require "pry"

class TacoService

  def random_ingredients
    conn = Faraday.new("http://taco-randomizer.herokuapp.com") do |f|
      f.adapter Faraday.default_adapter
    end

    response = conn.get("/random/")
    json = JSON.parse(response.body, symbolize_names: true)
  end

  def random_taco
    conn = Faraday.new("http://taco-randomizer.herokuapp.com") do |f|
      f.adapter Faraday.default_adapter
    end

    response = conn.get("/random/?full-taco=true")
    json = JSON.parse(response.body, symbolize_names: true)
  end

  def contributors
    conn = Faraday.new("http://taco-randomizer.herokuapp.com") do |f|
      f.adapter Faraday.default_adapter
    end

    response = conn.get("/contributions/")
    json = JSON.parse(response.body, symbolize_names: true)
  end

  def contributions(contributor)
    conn = Faraday.new("http://taco-randomizer.herokuapp.com") do |f|
      f.adapter Faraday.default_adapter
    end

    response = conn.get("/contributions/#{contributor}/")
    json = JSON.parse(response.body, symbolize_names: true)
  end

  def ingredients_by_type(recipe_type)
    conn = Faraday.new("http://taco-randomizer.herokuapp.com") do |f|
      f.adapter Faraday.default_adapter
    end

    response = conn.get("/contributors/#{recipe_type}/")
    json = JSON.parse(response.body, symbolize_names: true)
  end

  def contributors_by_ingredient(recipe_type, recipe_slug)
    conn = Faraday.new("http://taco-randomizer.herokuapp.com") do |f|
      f.adapter Faraday.default_adapter
    end

    response = conn.get("/contributors/#{recipe_type}/#{recipe_slug}/")
    json = JSON.parse(response.body, symbolize_names: true)
  end
end
