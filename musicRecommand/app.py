import json
import os
from flask import Flask, request, jsonify
from werkzeug.exceptions import BadRequest
from emotion import Emotion
from recomm import recommandMusics

app = Flask(__name__)
emotion = Emotion()

@app.route('/')
def isRunning():
    return "server is running"


@app.route('/music/recommendation')
def recommendMusic():
    # 감정이 상수 혹은 string으로 들어와야 함(emotion.py 참고)
    emotionI = request.args.get("e")

    if emotionI is None:        # 입력 베이스 감정이 없을 때
        return jsonify({
            # 오류처리
            # 오류 아닐 때와 같은 형식으로 반환 처리 할지 여부 결정
            'artist': '알 수 없음', 'name': '알 수 없음', 'image': None
        })
    
    empathy_tracks, overcome_tracks = recommandMusics(emotionI)
    
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

    # 전체 결과 (데이터 전송용)
    results = {
        'empathy': empathy_results,
        'overcome' : overcome_results
    }

    # 데이터 전송 형태 json -> { 키 : 리스트[{ 키 : 밸류 }, ...], 키 : 리스트[{ 키 : 밸류 }, ... ] }
    return json.dumps(results)
    

if __name__ == '__main__':
    app.run(host="0.0.0.0", port=int(os.environ.get("PORT", 5000)))
