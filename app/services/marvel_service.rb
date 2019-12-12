require "Faraday"
require "json"
require "pry"
require "digest"

class MarvelService
  def character(character)
    get_json("/v1/public/characters?ts=#{get_time}&apikey=#{ENV['MARVEL_PUBLIC']}&hash=#{get_hash}&name=#{character}")
  end

  def creators(last_name: nil, first_name: nil)
    if first_name.nil?
      get_json("/v1/public/creators?ts=#{get_time}&apikey=#{ENV['MARVEL_PUBLIC']}&hash=#{get_hash}&lastName=#{last_name}")
    else last_name.nil?
      get_json("/v1/public/creators?ts=#{get_time}&apikey=#{ENV['MARVEL_PUBLIC']}&hash=#{get_hash}&firstName=#{first_name}")
    end
  end

  private

  def conn
    conn = Faraday.new("https://gateway.marvel.com") do |f|
      f.adapter Faraday.default_adapter
    end
  end

  def get_time
    Time.now.to_i.to_s
  end

  def get_json(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def get_hash
    Digest::MD5.hexdigest(get_time + ENV['MARVEL_PRIVATE'] + ENV['MARVEL_PUBLIC'])
  end
end
