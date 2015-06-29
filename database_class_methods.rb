require "active_support"
require "active_support/inflector"

module DatabaseClassMethods
  
  # Utility method to dry up code
  #
  # Returns the table name of the class it is called on.
  def table_name
    self.to_s.pluralize.underscore
  end

  # Utility method to dry up code
  #
  # Returns Array of Objects
  def results_as_objects(results)
  results_as_objects = []
    results.each do |result_hash|
      results_as_objects << self.new(result_hash)
    end
    return results_as_objects    
  end
  # Utility method to change a current name to new name
  # 
  # field - String of the field name
  #
  # new_name - String used to replace name
  #
  # Returns an empty Array.
  def change_name(field, new_name)
    CONNECTION.execute("UPDATE #{table_name} SET #{field} = '#{new_name}' WHERE id = #{@id};")
  end
 
  # Get all of the rows for a table.
  #
  # Returns an Array containing Objects for each row.
  def all
    results = CONNECTION.execute("SELECT * FROM #{table_name}")

    results_as_objects(results)

  end

  # Get a single row.
  #
  # record_id - The record's Integer ID.
  #
  # Returns an Array containing the Object of the row.
  def find(record_id)
    results = CONNECTION.execute("SELECT * FROM #{table_name} WHERE id = #{record_id}")
    results_as_objects = []

    results.each do |result_hash|
      results_as_objects << self.new(result_hash)
    end
    return results_as_objects.first   
  end

  # Method used to find many rows of a table
  # 
  # array - Array of id's
  #
  # Returns Array of Objects
  def find_many(array)
    results = CONNECTION.execute("SELECT * FROM #{table_name} WHERE id IN (#{array.join(",")})")
    
    results_as_objects(results)
  end
 
  #This was required (I think) to use the musicbrainz gem
  MusicBrainz.configure do |c|
    # Application identity (required)
    c.app_name = "My Music App"
    c.app_version = "1.0"
    c.contact = "support@mymusicapp.com"
  end
  

end