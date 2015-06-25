require "active_support"
require "active_support/inflector"

module DatabaseClassMethods

  # Get all of the rows for a table.
  #
  # Returns an Array containing Objects for each row.
  def all
    table_name = self.to_s.pluralize.underscore

    results = CONNECTION.execute("SELECT * FROM #{table_name}")

    results_as_objects = []

    results.each do |result_hash|
      results_as_objects << self.new(result_hash)
    end
    return results_as_objects    
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
    
    results_as_objects = []

    results.each do |result_hash|
      results_as_objects << self.new(result_hash)
    end
    return results_as_objects 
  end

end