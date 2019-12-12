require "Faraday"
require "json"
require "pry"
require "digest"

class MarvelService
  def character(character)
    conn = Faraday.new("https://gateway.marvel.com") do |f|
      f.adapter Faraday.default_adapter
    end
    time_stamp = Time.now.to_i.to_s

    response = conn.get("/v1/public/characters?ts=#{time_stamp}&apikey=#{ENV['MARVEL_PUBLIC']}&hash=#{Digest::MD5.hexdigest(time_stamp + ENV['MARVEL_PRIVATE'] + ENV['MARVEL_PUBLIC'])}&name=#{character}")
    json = JSON.parse(response.body, symbolize_names: true)
  end

  def creators(last_name: nil, first_name: nil)
    conn = Faraday.new("https://gateway.marvel.com") do |f|
      f.adapter Faraday.default_adapter
    end
    time_stamp = Time.now.to_i.to_s

    if first_name.nil?
      response = conn.get("/v1/public/creators?ts=#{time_stamp}&apikey=#{ENV['MARVEL_PUBLIC']}&hash=#{Digest::MD5.hexdigest(time_stamp + ENV['MARVEL_PRIVATE'] + ENV['MARVEL_PUBLIC'])}&lastName=#{last_name}")
    else last_name.nil?
      response = conn.get("/v1/public/creators?ts=#{time_stamp}&apikey=#{ENV['MARVEL_PUBLIC']}&hash=#{Digest::MD5.hexdigest(time_stamp + ENV['MARVEL_PRIVATE'] + ENV['MARVEL_PUBLIC'])}&firstName=#{first_name}")
    end

    json = JSON.parse(response.body, symbolize_names: true)
  end
end
