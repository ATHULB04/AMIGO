from flask import *
import pdfgen,firebase
app=Flask(__name__)

@app.route("/voice",methods=['POST'])
def index():
    user_question=request.json['sentence']
    subject=request.json['subject']
    r=pdfgen.voice(user_question,subject)
    return({"result":r})


@app.route('/summary', methods=['POST'])
def get_latest_transcribe():
    subject=request.json['subject']
    firebase.details(subject)
    return jsonify({'latest_transcribe_data':"done"})

if __name__=="__main__":
    app.run(debug=True,port=6000)
