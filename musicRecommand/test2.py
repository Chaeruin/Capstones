import spotipy
from spotipy.oauth2 import SpotifyClientCredentials

client_credentials_manager = SpotifyClientCredentials(
    client_id='f304c6cebd0c4b409066e1c5e5a18309', 
    client_secret='8d8ba9c5f6a0489490ab81753b7e85ad'
    )

sp = spotipy.Spotify(client_credentials_manager=client_credentials_manager)



result = sp.search('',limit=2,type = 'artist')
print(result['artists']['items'][0]['id'])