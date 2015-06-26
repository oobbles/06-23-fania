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
  

# Utility method to change a current name to new name
# 
# new_name - String used to replace name
#
# Returns an empty Array.
def change_name(new_name)
  CONNECTION.execute("UPDATE albums SET name = '#{new_name}' WHERE id = #{@id};")
end

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