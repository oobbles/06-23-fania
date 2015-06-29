require "active_support"
require "active_support/inflector"

module DatabaseClassMethods
  
  # utility method to dry up code
  #
  # returns Array of Objects
  def results_as_objects(results)
  results_as_objects = []
  results.each do |result_hash|
    results_as_objects << self.new(result_hash)
  end
  return results_as_objects    
end
 
  # Get all of the rows for a table.
  #
  # Returns an Array containing Objects for each row.
  def all
    table_name = self.to_s.pluralize.underscore

    results = CONNECTION.execute("SELECT * FROM #{table_name}")

    results_as_objects(results)

  end

  # Get a single row.
  #
  # record_id - The record's Integer ID.
  #
  # Returns an Array containing the Object of the row.
  def find(record_id)
    table_name = self.to_s.pluralize.underscore

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
    table_name = self.to_s.pluralize.underscore
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