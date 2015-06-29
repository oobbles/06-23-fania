require_relative "../database_class_methods.rb"

class Album
  extend DatabaseClassMethods
  attr_reader :id
  attr_accessor :title, :year

  # Initializes a new album object
  #
  # options{} - Hash of arguments
  #
  # id (optional) - Integer of the album record in albums table
  #
  # title (optional) - String of the title in the album table
  #
  # year (optional) - Integer of the year in the album table
  def initialize(options={})
    @id = options["id"]
    @title = options["title"]
    @year = options["year"]
  end

  # CREATE Album record
  #
  # name - String
  #
  # year - Int
  #
  # Returns an Album Object
  def self.add(title, year)
    CONNECTION.execute("INSERT INTO albums (title, year) VALUES ('#{title}', #{year});")
    id = CONNECTION.last_insert_row_id
    Album.find(id)
  end
  
  # Insert method for the lookup table albums_styles
  #
  # style_id - integer
  #
  # Returns and empty Array
  def set_style(style_id)
    CONNECTION.execute("INSERT INTO albums_styles (album_id, style_id) VALUES (#{@id}, #{style_id});")
  end
  
  # Insert method for the lookup table albums_artists
  #
  # artist_id - integer
  #
  # Returns and empty Array
  def set_artist(artist_id)
    CONNECTION.execute("INSERT INTO albums_artists (album_id, artist_id) VALUES (#{@id}, #{artist_id});")
  end

  # Method deletes a row based on id of object
  #
  # Returns and Empty Array
  def delete
    CONNECTION.execute("DELETE FROM albums WHERE id = #{@id};")
  end

  # Finds all artists tied to an instance of Album
  #
  # Returns an Array of Artist Objects
  def find_artists
    artist_results = CONNECTION.execute("SELECT * FROM artists JOIN albums_artists ON artists.id = albums_artists.artist_id
    WHERE albums_artists.album_id = #{@id};")
   
    artist_ids = []
    
    artist_results.each do |hash|
      artist_ids << hash["artist_id"]
    end

    Artist.find_many(artist_ids)
  end

end