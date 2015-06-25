require_relative "../database_class_methods.rb"

class Style
  extend DatabaseClassMethods
  attr_reader :id
  attr_accessor :name
  
  # Initializes a new style object
  #
  # options{} - Hash of arguments
  #
  # id (optional) - Integer of the style in styles table
  #
  # name (optional) - String of the name in the styles table
  def initialize(options={})
    @id = options["id"]
    @name = options["name"]
  end
  
  # CREATE Style record, returns an empty Array.
  def self.add(name)
    CONNECTION.execute("INSERT INTO albums (name) VALUES ('#{name}';")
    return CONNECTION.last_insert_row_id
  end
  
end
