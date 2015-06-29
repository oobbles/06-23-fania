require_relative "../database_class_methods.rb"

class Style
  extend DatabaseClassMethods
  attr_reader :id
  attr_accessor :name
  
  # Initializes a new style object
  #
  # options{} - Hash of arguments
  #
  # id (optional) - Integer of the style record in styles table
  #
  # name (optional) - String of the name in the styles table
  def initialize(options={})
    @id = options["id"]
    @name = options["name"]
  end
  
  # CREATE Style record
  #
  # name - String
  #
  # Returns a Style Object
  def self.add(name)
    CONNECTION.execute("INSERT INTO styles (name) VALUES ('#{name}');")
    id = CONNECTION.last_insert_row_id
    Style.find(id)
  end
  
  # Check to see if name exisits
  #
  # name - String
  #
  # Returns Array with Style Object or if no such name exists, returns false
  def self.exist(name)
    get_name = CONNECTION.execute("SELECT id FROM styles WHERE name = '#{name}';") 
    if get_name.count != 0
      Style.find(get_name.first["id"])
    else 
      false #run the self.add to add the name
    end
  end

  # Utility method to delete a current Artist. Does not allow an Artist to be
  # deleted if its ID is used in the albums_artists table. 
  #
  # Returns Boolean.
  def delete
    styles_in_table = CONNECTION.execute("SELECT COUNT(*) FROM albums_styles WHERE style_id = #{@id};")
    if styles_in_table.first[0] == 0
      CONNECTION.execute("DELETE FROM styles WHERE id = #{@id};")
      true
    else
      false
    end
  end
  
  # Method goes to lookup table to get all albums where there is a match with
  # the style id.  
  # 
  # Returns an Array of Album Objects.
  def find_albums
    album_ids =[]
    results = CONNECTION.execute("SELECT * FROM albums_styles WHERE style_id = #{@id};")
      results.each do |hash|
        album_ids << hash["album_id"]
      end
      Album.find_many(album_ids)
  end
  
  # Method goes to lookup table to get all album_ids where there is a match with
  # the style_ids.  Does a second look up to match album_ids to artist_ids.
  # 
  # Returns an Array of Artist Objects.
  def find_artists
    album_ids = []
    album_results = CONNECTION.execute("SELECT * FROM albums_styles WHERE style_id = #{@id};")
      album_results.each do |hash|
        album_ids << hash["album_id"]
      end
      artist_ids = []
      artist_results = CONNECTION.execute("SELECT * FROM albums_artists WHERE album_id IN (#{album_ids.join(",")})")
      artist_results.each do |hash|
        artist_ids << hash["artist_id"]
      end
    
      Artist.find_many(artist_ids)
  end
end


