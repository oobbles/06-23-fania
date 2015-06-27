# ---------------------------------------------------------------------
# Menu
# ---------------------------------------------------------------------

#home
get "/home" do
  erb :"home"
end

#list artists
get "/artists/list_artists" do
  erb :"/artists/list_artists"
end

#list albums
get "/albums/list_albums" do
  erb :"/albums/list_albums"
end



#list styles
