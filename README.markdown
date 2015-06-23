#Album Manager

I listen to a lot of Latin music.  It can get confusing who is featured on what album and what styles are prominent on that album. For example: It can be difficult to remember that *Live at the Cheetah, Volume 1* has Ray Barretto, Santos Colón, Willie Colón, Celia Cruz, Cheo Feliciano and Héctor Lavoe featured on it, was issued in 1971 and features mainly songs in the Salsa style.

###Model Diagrams

<img src="http://i.imgur.com/W1RlPAL.png">

###Description

This will involve albums that have titles and years.  Styles such as Salsa, Bolero, Son, Latin Jazz, etc.  Also various Latin artists.

Each album has one title, one year, and may have one or more styles and one or more artists.  Each artist may be on one or many albums and may be associated with one or many styles.  

### "Should" cases

Here's what we want to be able to do:

* Create album records (heh heh)
* Edit album records
* Fetch and read album records
* Delete album records
* Create / update / delete artists
* Create / update / delete styles
* Fetch all albums with a given style
* Fetch all albums with a given artist
* Fetch all artists on a given album
* Fetch all artists with a given style

###"Should not" cases

We should not be able to:

* Be able to create an album that doesn't have a year, at least one style and at least one artist.

* Have a given single album repeated in the albums table.

* Delete an artist or style without first ensuring that it has no albums assigned to it.
