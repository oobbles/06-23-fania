get "/albums/display_albums/:number" do
  erb :"/albums/display_albums"
end

get "/albums/add_album_form" do
  erb :"albums/add_album_form"
end


get "/albums/add_album_input" do

  album=Album.add(params["album"]["title"], params["album"]["year"])
  @album=album.title

  if
   style= Style.exist(params["album"]["style"])
 else
   style= Style.add(params["album"]["style"])
  end

  if
   artist= Artist.exist(params["album"]["artist"])
 else
   artist= Artist.add(params["album"]["artist"])
  end
  album.set_style(style.id)
  album.set_artist(artist.id)
  erb :"albums/album_added"
end



