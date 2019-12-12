require "Faraday"
require "json"
require "pry"

class DiscogsService

  def releases_from_artist(artist)
    artist_id = get_artist_id(artist)
    get_json("/artists/#{artist_id}/releases")
  end

  def release_rating(release_id)
    get_json("/releases/#{release_id}")
  end

  private

  def conn
    Faraday.new("https://api.discogs.com") do |f|
      f.adapter Faraday.default_adapter
    end
  end

  def get_json(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def get_artist_id(artist)
    response = get_json("/database/search?q=#{artist}&key=#{ENV['DISCOGS_KEY']}&secret=#{ENV['DISCOGS_SECRET']}")
    response[:results][0][:id]
  end
end
