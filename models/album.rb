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
end

   #
  # # CREATE Album record, returns an empty Array.
  # def self.add(title, year)
  #   CONNECTION.execute("INSERT INTO albums (title, year) VALUES ('#{title}', #{year});")
  #   return CONNECTION.last_insert_row_id
  # end
  # 
  # INSERT INTO albums_styles VALUES (the return of Album.add, Style.id);
  # INSERT INTO albums_styles VALUES (the return of Album.add, Style.id);(optional)
  # INSERT INTO albums_artists VALUES(the return of Album.add, Artist.id);
  # INSERT INTO albums_artists VALUES(the return of Album.add, Artist.id);
  # INSERT INTO albums_artists VALUES(the return of Album.add, Artist.id);
  #
  #
