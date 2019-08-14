require_relative('./models/album.rb')
require_relative('./models/artist.rb')
require('pry')

Album.delete_all()
Artist.delete_all()

artist1 = Artist.new( { 'name' => 'Tool' } )
artist1.save()

artist2 = Artist.new( { 'name' => 'Queen' } )
artist2.save()

artist3 = Artist.new( { 'name' => 'Pavarotti' } )
artist3.save()


album1 = Album.new( {
  'title' => 'Fear Inoculum',
  'genre' => 'Progressive Metal',
  'artist_id' => artist1.id
})
album1.save()

album2 = Album.new( {
  'title' => 'Bohemian Rhapsody',
  'genre' => 'Progressive Rock',
  'artist_id' => artist2.id
})
album2.save()

album3 = Album.new( {
  'title' => 'Oh sole mio',
  'genre' => 'Progressive Opera',
  'artist_id' => artist3.id
})
album3.save()


binding.pry
nil
