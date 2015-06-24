require "pry"
require "sinatra"
require "sinatra/reloader"

# SQL/Database
require "sqlite3"
require_relative "database_setup.rb"

# Models
require_relative "models/album.rb"
require_relative "models/artist.rb"
require_relative "models/style.rb"


# Controllers
require_relative "controllers/main.rb"
