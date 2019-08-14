require_relative('../db/sql_runner')
require_relative('./artist')

class Album

  attr_reader(:id, :artist_id)
  attr_accessor(:title, :genre)

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @genre = options['genre']
    @artist_id = options['artist_id'].to_i
  end

  def save
    sql = "
    INSERT INTO albums
    (
      title,
      genre,
      artist_id
    )
    VALUES
    ($1, $2, $3)
    RETURNING *
    "
    values = [@title, @genre, @artist_id]
    albums = SqlRunner.run(sql, values)
    @id = albums[0]["id"].to_i
  end

  def Album.all
    sql = "SELECT * FROM albums"
    albums = SqlRunner.run(sql)
    return albums.map { |album| Album.new(album) }
  end
  def Album.delete_all
    sql = "DELETE FROM albums"
    SqlRunner.run(sql)
  end

  def delete
    sql = "DELETE FROM albums WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def update
    sql = "
    UPDATE albums
    SET (
      title,
      genre,
      artist_id
      ) =
      (
        $1, $2, $3
      )
      WHERE id = $4
      RETURNING *
      "
      values = [@title, @genre, @artist_id]
      result = SqlRunner.run(sql, values)
      updated_album = Album.new(result[0])
      return updated_album
    end

    def artist
      sql = "SELECT * FROM artists
      WHERE id = $1"
      values = [@artist_id]
      results = SqlRunner.run(sql, values)
      artist_data = results[0]
      artist = Artist.new(artist_data)
      return artist
    end

  end
