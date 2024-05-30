import spotipy
from spotipy.oauth2 import SpotifyClientCredentials
from emotion import Emotion

client_credentials_manager = SpotifyClientCredentials(
    client_id='f304c6cebd0c4b409066e1c5e5a18309', 
    client_secret='8d8ba9c5f6a0489490ab81753b7e85ad'
    )

sp = spotipy.Spotify(client_credentials_manager=client_credentials_manager)
Emo = Emotion()

## 문제
# 1. 오디오 피쳐로 추천하는거 자체가 완전하지 않음
#   ( 우리가 생각하는 것 만큼 음원 자체가 가지고 있는 오디오 피쳐 값이 기대하는 바에 미치지 못함 
#    - 우울한 노래가 valence 값이 많이 낮지는 않고 등등...의 문제)
# 2. 가사를 토대로 추천하고 싶으나 불가능해보임...
# 3. 세밀한 오디오 피쳐 값 사이에서는 추천이 안됨 - 고려해야 할 피쳐 개수가 늘수록 더 세밀한 범위 추정이 어려움!!
# 4. 특정 아티스트, 노래를 계속 추천함 (왜?)

## mode - major: 1, minor: 0
## min, max 대신 target으로 변경

def recommandMusics(emotion):
    seed_artist=["3HqSLMAZ3g3d5poNaI7GOU", "3Nrfpe0tUJi4K4DXYWgMUX"]
    seed_genre=["k-pop"]
    seed_track=["1r9xUipOqoNwggBpENDsvJ"]

    rec1 = {}
    rec2 = {}

    # JOY 기쁨
    if emotion == Emo.JOY:
        rec1 = sp.recommendations(
            seed_artists=seed_artist, 
            seed_genres=seed_genre, 
            seed_tracks=seed_track, 
            limit=5,
            target_danceability=0.9,
            target_energy=0.9,
            target_valence=0.9,
            target_tempo=120
            )
        rec2 = sp.recommendations(
            seed_artists=seed_artist, 
            seed_genres=seed_genre, 
            seed_tracks=seed_track, 
            limit=5,
            target_danceability=0.3,
            target_energy=0.3,
            target_valence=0.3,
            target_tempo=60
            )
    
    # HOPE 희망
    elif emotion == Emo.HOPE:
        rec1 = sp.recommendations(
            seed_artists=seed_artist, 
            seed_genres=seed_genre, 
            seed_tracks=seed_track, 
            limit=5,
            target_danceability=0.6,
            target_energy=0.9,
            target_valence=0.9,
            target_tempo=120
            )
        rec2 = sp.recommendations(
            seed_artists=seed_artist, 
            seed_genres=seed_genre, 
            seed_tracks=seed_track, 
            limit=5,
            target_danceability=0.3,
            target_energy=0.3,
            target_valence=0.3,
            target_tempo=70
            )
    
    # NEUTRALITY 중립
    elif emotion == Emo.NEUTRALITY:
        rec1 = sp.recommendations(
            seed_artists=seed_artist, 
            seed_genres=seed_genre, 
            seed_tracks=seed_track, 
            limit=5,
            target_danceability=0.5,
            target_energy=0.5,
            target_valence=0.5,
            target_tempo=100
            )
        rec2 = sp.recommendations(
            seed_artists=seed_artist, 
            seed_genres=seed_genre, 
            seed_tracks=seed_track, 
            limit=5,
            target_danceability=0.6,
            target_energy=0.6,
            target_valence=0.6,
            target_tempo=100
            )
        
    # SADNESS 슬픔
    elif emotion == Emo.SADNESS:
        rec1 = sp.recommendations(
            seed_artists=seed_artist, 
            seed_genres=seed_genre, 
            seed_tracks=seed_track, 
            limit=5,
            target_danceability=0.1,
            target_energy=0.1,
            target_valence=0.1,
            target_tempo=60
            )
        rec2 = sp.recommendations(
            seed_artists=seed_artist, 
            seed_genres=seed_genre, 
            seed_tracks=seed_track, 
            limit=5,
            target_danceability=0.6,
            target_energy=0.7,
            target_valence=0.9,
            target_tempo=120
            )
    
    # ANGER 분노
    elif emotion == Emo.ANGER:
        rec1 = sp.recommendations(
            seed_artists=seed_artist, 
            seed_genres=seed_genre, 
            seed_tracks=seed_track, 
            limit=5,
            target_danceability=0.5,
            target_energy=0.9,
            target_valence=0.3,
            target_tempo=120
            )
        rec2 = sp.recommendations(
            seed_artists=seed_artist, 
            seed_genres=seed_genre, 
            seed_tracks=seed_track, 
            limit=5,
            target_danceability=0.9,
            target_energy=0.8,
            target_valence=0.8,
            target_tempo=100
            )

    # ANXIETY 불안
    elif emotion == Emo.ANXIETY:
        rec1 = sp.recommendations(
            seed_artists=seed_artist, 
            seed_genres=seed_genre, 
            seed_tracks=seed_track, 
            limit=5,
            target_danceability=0.3,
            target_energy=0.3,
            target_valence=0.2,
            target_tempo=80
            )
        rec2 = sp.recommendations(
            seed_artists=seed_artist, 
            seed_genres=seed_genre, 
            seed_tracks=seed_track, 
            limit=5,
            target_danceability=0.5,
            target_energy=0.5,
            target_valence=0.9,
            target_tempo=110
            )

    # TIREDNESS 피곤
    elif emotion == Emo.TIREDNESS:
        rec1 = sp.recommendations(
            seed_artists=seed_artist, 
            seed_genres=seed_genre, 
            seed_tracks=seed_track, 
            limit=5,
            target_danceability=0.1,
            target_energy=0.3,
            target_valence=0.4,
            target_tempo=70
            )
        rec2 = sp.recommendations(
            seed_artists=seed_artist, 
            seed_genres=seed_genre, 
            seed_tracks=seed_track, 
            limit=5,
            target_danceability=0.6,
            target_energy=0.6,
            target_valence=0.6,
            target_tempo=120
            )
    
    # REGERT 후회
    elif emotion == Emo.REGRET:
        rec1 = sp.recommendations(
            seed_artists=seed_artist, 
            seed_genres=seed_genre, 
            seed_tracks=seed_track, 
            limit=5,
            target_danceability=0.1,
            target_energy=0.2,
            target_valence=0.2,
            target_tempo=80
            )
        rec2 = sp.recommendations(
            seed_artists=seed_artist, 
            seed_genres=seed_genre, 
            seed_tracks=seed_track, 
            limit=5,
            target_danceability=0.3,
            target_energy=0.6,
            target_valence=0.6,
            target_tempo=100
            )
        

    return rec1['tracks'], rec2['tracks']
    