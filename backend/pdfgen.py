from gtts import gTTS
import tempfile
import pyrebase
config ={
 "apiKey": "AIzaSyAvXSSHSTbm7vXR_0mySUwOPJWlvZ1E480",
  "authDomain": "studiesy.firebaseapp.com",
  "databaseURL": "https://studiesy-default-rtdb.firebaseio.com",
  "projectId": "studiesy",
  "storageBucket": "studiesy.appspot.com",
  "messagingSenderId": "1070198266308",
  "appId": "1:1070198266308:web:ee0546f9c31da90d256c91",
  "measurementId": "G-SPW2YS1XML"
}

## Initialize Firebase
def voice(sentence,subject):
  firebase = pyrebase.initialize_app(config)

  # The text that you want to convert to audio
  mytext = sentence

  # Language in which you want to convert
  language = 'en'

  # Create a gTTS object
  myobj = gTTS(text=mytext, lang=language, slow=False)

  # Create a temporary file to store the audio
  with tempfile.NamedTemporaryFile(suffix=".mp3", delete=False) as temp_audio:
      myobj.save(temp_audio.name)

  # Define the cloud storage path
  cloudpath = f"test/{subject}.mp3"

  # Upload the temporary file to Firebase storage
  try:
      firebase.storage().child(cloudpath).put(temp_audio.name)
      print("Audio file uploaded to Firebase storage.")
  except Exception as e:
      print(f"Error uploading the file to Firebase storage: {str(e)}")

  # Clean up: Remove the temporary file
  temp_audio.close()
  return "done"
