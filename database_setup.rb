# Load/create our database for this program.
CONNECTION = SQLite3::Database.new("fania.db")

# Make the tables.
CONNECTION.execute("CREATE TABLE IF NOT EXISTS albums (id INTEGER PRIMARY KEY, title TEXT UNIQUE, year INTEGER);")
CONNECTION.execute("CREATE TABLE IF NOT EXISTS styles (id INTEGER PRIMARY KEY, name TEXT UNIQUE);")
CONNECTION.execute("CREATE TABLE IF NOT EXISTS artists (id INTEGER PRIMARY KEY, name TEXT UNIQUE);")
CONNECTION.execute("CREATE TABLE IF NOT EXISTS albums_styles (album_id INTEGER, style_id INTEGER);")
CONNECTION.execute("CREATE TABLE IF NOT EXISTS albums_artists (album_id INTEGER, artist_id INTEGER);")

# Get results as an Array of Hashes.
CONNECTION.results_as_hash = true