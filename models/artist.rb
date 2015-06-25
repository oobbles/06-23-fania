require_relative "../database_class_methods.rb"

class Artist
  extend DatabaseClassMethods
  attr_reader :id
  attr_accessor :name
  
  # Initializes a new album object
  #
  # id (optional) - Integer of the album record in artists table
  #
  # name (optional) - String of the name in the artists table
  def initialize(options={})
    @id = options["id"]
    @name = options["name"]
  end
  
  # Check to see if name exisits, if so, returns Array with Artist Object.
  def self.exist(name)
    get_name = CONNECTION.execute("SELECT id FROM artists WHERE name = '#{name}';") 
    if get_name.count != 0
      Artist.find(get_name.first["id"])
    else 
      false #run the self.add to add the name
    end
  end
  
  # CREATE Artist record, returns an Artist Object.
  def self.add(name)
    CONNECTION.execute("INSERT INTO artists (name) VALUES ('#{name}');")
    id = CONNECTION.last_insert_row_id
    Artist.find(id)
  end
 
  # Utility method to change a current name to new name. Returns an 
  # empty Array.
  def change_name(new_name)
    CONNECTION.execute("UPDATE artists SET name = '#{new_name}' WHERE id = #{@id};")
  end

  # Utility method to delete a current Artist. Does not allow an Artist to be
  # deleted if its ID is used in the albums_artists table. Returns Boolean.
  def delete
    artists_in_table = CONNECTION.execute("SELECT COUNT(*) FROM albums_artists WHERE artist_id = #{@id};")
    if artists_in_table.first[0] == 0
      CONNECTION.execute("DELETE FROM artists WHERE id = #{@id};")
      true
    else
      false
    end
  end
  
  # Method goes to lookup table to get all albums where there is a match with
  # the artist id.  It then uses the aray of album_ids as an argument for the 
  # class method find_many.  Returns an Array of Album Objects.
  def find_albums
    album_ids =[]
    results = CONNECTION.execute("SELECT * FROM albums_artists WHERE artist_id = #{@id};")
      results.each do |hash|
        album_ids << hash["album_id"]
      end
      Album.find_many(album_ids)
      
      end
    
  
  
  
  
end