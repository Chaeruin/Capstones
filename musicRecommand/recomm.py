import spotipy
from spotipy.oauth2 import SpotifyClientCredentials
from emotion import Emotion

sp = spotipy.Spotify(client_credentials_manager=client_credentials_manager)
Emo = Emotion()

## 문제
# 1. 오디오 피쳐로 추천하는거 자체가 완전하지 않음
#   ( 우리가 생각하는 것 만큼 음원 자체가 가지고 있는 오디오 피쳐 값이 기대하는 바에 미치지 못함 
#    - 우울한 노래가 valence 값이 많이 낮지는 않고 등등...의 문제)
# 2. 가사를 토대로 추천하고 싶으나 불가능해보임...
# 3. 세밀한 오디오 피쳐 값 사이에서는 추천이 안됨 - 고려해야 할 피쳐 개수가 늘수록 더 세밀한 범위 추정이 어려움!!

def recommandMusics(emotion):
    seed_artist=["3HqSLMAZ3g3d5poNaI7GOU"]
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
            min_danceability=0.8,
            max_danceability=1,
            min_energy=0.8,
            max_energy=1,
            min_valence=0.8,
            max_valence=1
            )
        rec2 = sp.recommendations(
            seed_artists=seed_artist, 
            seed_genres=seed_genre, 
            seed_tracks=seed_track, 
            limit=5,
            min_danceability=0.2,
            max_danceability=0.5,
            min_energy=0.2,
            max_energy=0.5,
            min_valence=0.2,
            max_valence=0.5
            )
    
    # HOPE 희망
    if emotion == Emo.HOPE:
        rec1 = sp.recommendations(
            seed_artists=seed_artist, 
            seed_genres=seed_genre, 
            seed_tracks=seed_track, 
            limit=5,
            min_danceability=0.6,
            max_danceability=1,
            min_energy=0.8,
            max_energy=1,
            min_valence=0.7,
            max_valence=1
            )
        rec2 = sp.recommendations(
            seed_artists=seed_artist, 
            seed_genres=seed_genre, 
            seed_tracks=seed_track, 
            limit=5,
            min_danceability=0.3,
            max_danceability=0.5,
            min_energy=0.3,
            max_energy=0.5,
            min_valence=0.3,
            max_valence=0.5
            )
    
    # NEUTRALITY 중립
    if emotion == Emo.NEUTRALITY:
        rec1 = sp.recommendations(
            seed_artists=seed_artist, 
            seed_genres=seed_genre, 
            seed_tracks=seed_track, 
            limit=5,
            min_danceability=0.4,
            max_danceability=0.6,
            min_energy=0.4,
            max_energy=0.6,
            min_valence=0.4,
            max_valence=0.6
            )
        rec2 = sp.recommendations(
            seed_artists=seed_artist, 
            seed_genres=seed_genre, 
            seed_tracks=seed_track, 
            limit=5,
            min_danceability=0.5,
            max_danceability=1,
            min_energy=0.4,
            max_energy=1,
            min_valence=0.5,
            max_valence=1
            )
        
    # SADNESS 슬픔
    if emotion == Emo.SADNESS:
        rec1 = sp.recommendations(
            seed_artists=seed_artist, 
            seed_genres=seed_genre, 
            seed_tracks=seed_track, 
            limit=5,
            min_danceability=0.1,
            max_danceability=0.3,
            min_energy=0.1,
            max_energy=0.3,
            min_valence=0,
            max_valence=0.3
            )
        rec2 = sp.recommendations(
            seed_artists=seed_artist, 
            seed_genres=seed_genre, 
            seed_tracks=seed_track, 
            limit=5,
            min_danceability=0.8,
            max_danceability=1,
            min_energy=0.8,
            max_energy=1,
            min_valence=0.8,
            max_valence=1
            )
    
    # ANGER 분노
    if emotion == Emo.ANGER:
        rec1 = sp.recommendations(
            seed_artists=seed_artist, 
            seed_genres=seed_genre, 
            seed_tracks=seed_track, 
            limit=5,
            min_danceability=0.5,
            max_danceability=1,
            min_energy=0.8,
            max_energy=1,
            min_valence=0,
            max_valence=1
            )
        rec2 = sp.recommendations(
            seed_artists=seed_artist, 
            seed_genres=seed_genre, 
            seed_tracks=seed_track, 
            limit=5,
            min_danceability=0.8,
            max_danceability=1,
            min_energy=0.6,
            max_energy=1,
            min_valence=0.8,
            max_valence=1
            )

    # ANXIETY 불안
    if emotion == Emo.ANXIETY:
        rec1 = sp.recommendations(
            seed_artists=seed_artist, 
            seed_genres=seed_genre, 
            seed_tracks=seed_track, 
            limit=5,
            min_danceability=0,
            max_danceability=0.3,
            min_energy=0.3,
            max_energy=0.7,
            min_valence=0,
            max_valence=0.5
            )
        rec2 = sp.recommendations(
            seed_artists=seed_artist, 
            seed_genres=seed_genre, 
            seed_tracks=seed_track, 
            limit=5,
            min_danceability=0,
            max_danceability=1,
            min_energy=0.5,
            max_energy=1,
            min_valence=0.8,
            max_valence=1
            )

    # TIREDNESS 피곤
    if emotion == Emo.TIREDNESS:
        rec1 = sp.recommendations(
            seed_artists=seed_artist, 
            seed_genres=seed_genre, 
            seed_tracks=seed_track, 
            limit=5,
            min_danceability=0,
            max_danceability=0.3,
            min_energy=0,
            max_energy=0.3,
            min_valence=0,
            max_valence=0.4
            )
        rec2 = sp.recommendations(
            seed_artists=seed_artist, 
            seed_genres=seed_genre, 
            seed_tracks=seed_track, 
            limit=5,
            min_danceability=0.2,
            max_danceability=0.8,
            min_energy=0.5,
            max_energy=1,
            min_valence=0.6,
            max_valence=1
            )
    
    # REGERT 후회
    if emotion == Emo.REGRET:
        rec1 = sp.recommendations(
            seed_artists=seed_artist, 
            seed_genres=seed_genre, 
            seed_tracks=seed_track, 
            limit=5,
            min_danceability=0,
            max_danceability=0.2,
            min_energy=0,
            max_energy=0.5,
            min_valence=0,
            max_valence=0.3
            )
        rec2 = sp.recommendations(
            seed_artists=seed_artist, 
            seed_genres=seed_genre, 
            seed_tracks=seed_track, 
            limit=5,
            min_danceability=0.4,
            max_danceability=1,
            min_energy=0.4,
            max_energy=1,
            min_valence=0.4,
            max_valence=1
            )
        

    return rec1['tracks'], rec2['tracks']
    