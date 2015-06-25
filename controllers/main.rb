# ---------------------------------------------------------------------
# Menu
# ---------------------------------------------------------------------
get "/home" do
  erb :"home"
end

get "/artists/list_artists" do
  erb :"/artists/list_artists"
end

get "/artists/display_artists/:number" do
  erb :"/artists/display_artists"
end