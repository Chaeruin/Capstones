from recomm import recommandMusics
from emotion import Emotion

Emo = Emotion()

emotion = Emo.SADNESS

empathy_tracks, overcome_tracks = recommandMusics(emotion=emotion)
    
# 공감형 트랙
empathy_results = [
    {'artist': empathy_tracks[0]['artists'][0]['name'], 'name': empathy_tracks[0]['name'], 'image': empathy_tracks[0]['album']['images']},
    {'artist': empathy_tracks[1]['artists'][0]['name'], 'name': empathy_tracks[1]['name'], 'image': empathy_tracks[1]['album']['images']},
    {'artist': empathy_tracks[2]['artists'][0]['name'], 'name': empathy_tracks[2]['name'], 'image': empathy_tracks[2]['album']['images']},
    {'artist': empathy_tracks[3]['artists'][0]['name'], 'name': empathy_tracks[3]['name'], 'image': empathy_tracks[3]['album']['images']},
    {'artist': empathy_tracks[4]['artists'][0]['name'], 'name': empathy_tracks[4]['name'], 'image': empathy_tracks[4]['album']['images']}
]

# 극복형 트랙 (제 2 트랙)
overcome_results = [
    {'artist': overcome_tracks[0]['artists'][0]['name'], 'name': overcome_tracks[0]['name'], 'image': overcome_tracks[0]['album']['images']},
    {'artist': overcome_tracks[1]['artists'][0]['name'], 'name': overcome_tracks[1]['name'], 'image': overcome_tracks[1]['album']['images']},
    {'artist': overcome_tracks[2]['artists'][0]['name'], 'name': overcome_tracks[2]['name'], 'image': overcome_tracks[2]['album']['images']},
    {'artist': overcome_tracks[3]['artists'][0]['name'], 'name': overcome_tracks[3]['name'], 'image': overcome_tracks[3]['album']['images']},
    {'artist': overcome_tracks[4]['artists'][0]['name'], 'name': overcome_tracks[4]['name'], 'image': overcome_tracks[4]['album']['images']}
]

results = {
        'empathy': empathy_results,
        'overcome' : overcome_results
    }

print("====== 공감형 트랙 ======")
for i in range(0, 5):
    print(results['empathy'][i]['artist'])
    print(results['empathy'][i]['name'])
    # print(empathy_results[0]['image'])
    print('==============================')

print("====== 제 2 트랙 ======")
for i in range(0, 5):
    print(results['overcome'][i]['artist'])
    print(results['overcome'][i]['name'])
    # print(empathy_results[0]['image'])
    print('==============================')