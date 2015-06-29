# ---------------------------------------------------------------------
# Artist Controllers
# ---------------------------------------------------------------------


get "/artists/display_artists/:number" do
  erb :"/artists/display_artists"
end

get "/artists/artist_of_the_week" do
  erb :"/artists/artist_of_the_week"
end
