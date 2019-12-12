require "Faraday"
require "json"
require "pry"

class DiscogsService

  def releases_from_artist(artist)
    conn = Faraday.new("https://api.discogs.com") do |f|
      f.adapter Faraday.default_adapter
    end

    response = conn.get("/database/search?q=#{artist}&key=#{ENV['DISCOGS_KEY']}&secret=#{ENV['DISCOGS_SECRET']}")
    artist_id = JSON.parse(response.body, symbolize_names: true)[:results][0][:id]

    release_response = conn.get("/artists/#{artist_id}/releases")
    release_results = JSON.parse(release_response.body, symbolize_names: true)
  end

  def release_rating(release_id)
    conn = Faraday.new("https://api.discogs.com") do |f|
      f.adapter Faraday.default_adapter
    end

    response = conn.get("/releases/#{release_id}")
    results = JSON.parse(response.body, symbolize_names: true)
  end
end
