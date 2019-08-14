require_relative('../db/sql_runner')
require_relative('./album')

class Artist

  attr_reader(:id)
  attr_accessor(:name)

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end

  def save
    sql = "INSERT INTO artists (name)
    VALUES
    ($1)
    RETURNING id"
    values = [@name]
    artists = Sqlrunner.run(sql, values)
    @id = artists[0]["id"].to_i
  end

  def Artist.all
    sql = "SELECT * FROM artists"
    artists = Sqlrunner.run(sql)
    return artists.map { |artist| Artist.new(artist) }
  end

  def album
    sql = "SELECT * FROM albums
          WHERE artist_id = $1"
    values = [@id]
    results = Sqlrunner.run(sql, values)
    album_data = results[0]
    album = Album.new(album_data)
    return album
  end

end
