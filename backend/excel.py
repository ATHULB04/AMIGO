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
import openpyxl 

def call1(abs):
    wb = openpyxl.load_workbook("test.xlsx") 
    firebase = pyrebase.initialize_app(config)
    sheet = wb.active 
    cloudpath = "test/test.xlsx"
    for i in range (2,7):
        c=sheet[f"B{i}"]
        c.value="present"
    for i in range(len(abs)):
        id=1
        id+=abs[i]
        c = sheet[f'B{id}'] 
        c.value = "absent"

    wb.save("test.xlsx")
    firebase.storage().child(cloudpath).put("test.xlsx")
    return "done" 


