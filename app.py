import os
from model.chatbot.kobert import chatbot as ch_kobert
from util.emotion import Emotion
from util.depression import Depression
from flask import Flask, request, jsonify
from werkzeug.exceptions import BadRequest

app = Flask(__name__)
Emotion = Emotion()
Depression = Depression()


@app.route('/')
def isRunning():
    return "server is running"


@app.route('/chatbot/bert')
def reactKobertChatBot():
    sentence = request.args.get("s")
    if sentence is None or len(sentence) == 0 or sentence == '\n':
        return jsonify({
            "answer": "듣고 있어요. 더 말씀해주세요~"
        })

    answer, category, desc, softmax = ch_kobert.chat(sentence)
    return jsonify({
        "answer": answer,
        "category": category,
        "category_info": desc
    })


if __name__ == '__main__':
    app.run(host="0.0.0.0", port=int(os.environ.get("PORT", 5000)))
