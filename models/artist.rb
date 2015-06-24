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
  
  # Check to see if name exisits, if so, return object.
  def self.exist(name)
    get_name = CONNECTION.execute("SELECT id FROM artists WHERE name = '#{name}';") 
    if get_name.count != 0
      Artist.find(get_name.first["id"])
    else 
      false #run the self.add to add the name
    end
  end
  
  # CREATE Artist record, returns an object.
  def self.add(name)
    CONNECTION.execute("INSERT INTO artists (name) VALUES ('#{name}');")
    id = CONNECTION.last_insert_row_id
    Artist.find(id)
  end
end
 