import spotipy
from spotipy.oauth2 import SpotifyClientCredentials
from emotion import Emotion

client_credentials_manager = SpotifyClientCredentials(
    client_id='f304c6cebd0c4b409066e1c5e5a18309', 
    client_secret='8d8ba9c5f6a0489490ab81753b7e85ad'
    )

sp = spotipy.Spotify(client_credentials_manager=client_credentials_manager)
Emo = Emotion()

def recommandMusics(self, emotion):
    seed_artist=["3HqSLMAZ3g3d5poNaI7GOU"]
    seed_genre=["pop","k-pop"]
    seed_track=["1r9xUipOqoNwggBpENDsvJ"]

    rec = {}

    # JOY 기쁨
    if emotion == Emo.JOY:
        rec1 = sp.recommendations(
            seed_artists=seed_artist, 
            seed_genres=seed_genre, 
            seed_tracks=seed_track, 
            limit=5,
            min_danceability=0,
            max_danceability=100,
            min_energy=0,
            max_energy=100,
            min_valence=0,
            max_valence=100
            )
        rec2 = sp.recommendations(
            seed_artists=seed_artist, 
            seed_genres=seed_genre, 
            seed_tracks=seed_track, 
            limit=5,
            min_danceability=0,
            max_danceability=100,
            min_energy=0,
            max_energy=100,
            min_valence=0,
            max_valence=100
            )
    
    # HOPE 희망
    if emotion == Emo.HOPE:
        rec1 = sp.recommendations(
            seed_artists=seed_artist, 
            seed_genres=seed_genre, 
            seed_tracks=seed_track, 
            limit=5,
            min_danceability=0,
            max_danceability=100,
            min_energy=0,
            max_energy=100,
            min_valence=0,
            max_valence=100
            )
        rec2 = sp.recommendations(
            seed_artists=seed_artist, 
            seed_genres=seed_genre, 
            seed_tracks=seed_track, 
            limit=5,
            min_danceability=0,
            max_danceability=100,
            min_energy=0,
            max_energy=100,
            min_valence=0,
            max_valence=100
            )
    
    # NEUTRALITY 중립
    if emotion == Emo.NEUTRALITY:
        rec1 = sp.recommendations(
            seed_artists=seed_artist, 
            seed_genres=seed_genre, 
            seed_tracks=seed_track, 
            limit=5,
            min_danceability=0,
            max_danceability=100,
            min_energy=0,
            max_energy=100,
            min_valence=0,
            max_valence=100
            )
        rec2 = sp.recommendations(
            seed_artists=seed_artist, 
            seed_genres=seed_genre, 
            seed_tracks=seed_track, 
            limit=5,
            min_danceability=0,
            max_danceability=100,
            min_energy=0,
            max_energy=100,
            min_valence=0,
            max_valence=100
            )
        
    # SADNESS 슬픔
    if emotion == Emo.SADNESS:
        rec1 = sp.recommendations(
            seed_artists=seed_artist, 
            seed_genres=seed_genre, 
            seed_tracks=seed_track, 
            limit=5,
            min_danceability=0,
            max_danceability=100,
            min_energy=0,
            max_energy=100,
            min_valence=0,
            max_valence=100
            )
        rec2 = sp.recommendations(
            seed_artists=seed_artist, 
            seed_genres=seed_genre, 
            seed_tracks=seed_track, 
            limit=5,
            min_danceability=0,
            max_danceability=100,
            min_energy=0,
            max_energy=100,
            min_valence=0,
            max_valence=100
            )
    
    # ANGER 분노
    if emotion == Emo.ANGER:
        rec1 = sp.recommendations(
            seed_artists=seed_artist, 
            seed_genres=seed_genre, 
            seed_tracks=seed_track, 
            limit=5,
            min_danceability=0,
            max_danceability=100,
            min_energy=0,
            max_energy=100,
            min_valence=0,
            max_valence=100
            )
        rec2 = sp.recommendations(
            seed_artists=seed_artist, 
            seed_genres=seed_genre, 
            seed_tracks=seed_track, 
            limit=5,
            min_danceability=0,
            max_danceability=100,
            min_energy=0,
            max_energy=100,
            min_valence=0,
            max_valence=100
            )

    # ANXIETY 불안
    if emotion == Emo.ANXIETY:
        rec1 = sp.recommendations(
            seed_artists=seed_artist, 
            seed_genres=seed_genre, 
            seed_tracks=seed_track, 
            limit=5,
            min_danceability=0,
            max_danceability=100,
            min_energy=0,
            max_energy=100,
            min_valence=0,
            max_valence=100
            )
        rec2 = sp.recommendations(
            seed_artists=seed_artist, 
            seed_genres=seed_genre, 
            seed_tracks=seed_track, 
            limit=5,
            min_danceability=0,
            max_danceability=100,
            min_energy=0,
            max_energy=100,
            min_valence=0,
            max_valence=100
            )

    # TIREDNESS 피곤
    if emotion == Emo.TIREDNESS:
        rec1 = sp.recommendations(
            seed_artists=seed_artist, 
            seed_genres=seed_genre, 
            seed_tracks=seed_track, 
            limit=5,
            min_danceability=0,
            max_danceability=100,
            min_energy=0,
            max_energy=100,
            min_valence=0,
            max_valence=100
            )
        rec2 = sp.recommendations(
            seed_artists=seed_artist, 
            seed_genres=seed_genre, 
            seed_tracks=seed_track, 
            limit=5,
            min_danceability=0,
            max_danceability=100,
            min_energy=0,
            max_energy=100,
            min_valence=0,
            max_valence=100
            )
    
    # REGERT 후회
    if emotion == Emo.REGRET:
        rec1 = sp.recommendations(
            seed_artists=seed_artist, 
            seed_genres=seed_genre, 
            seed_tracks=seed_track, 
            limit=5,
            min_danceability=0,
            max_danceability=100,
            min_energy=0,
            max_energy=100,
            min_valence=0,
            max_valence=100
            )
        rec2 = sp.recommendations(
            seed_artists=seed_artist, 
            seed_genres=seed_genre, 
            seed_tracks=seed_track, 
            limit=5,
            min_danceability=0,
            max_danceability=100,
            min_energy=0,
            max_energy=100,
            min_valence=0,
            max_valence=100
            )
        

    return rec1['tracks'], rec2['tracks']
    