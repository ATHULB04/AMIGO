import firebase_admin
from firebase_admin import credentials,firestore
import json
import os
from langchain.prompts import PromptTemplate
from langchain.llms import OpenAI
from langchain.chains import LLMChain
os.environ["OPENAI_API_KEY"] = os.environ.get('OPENAI_API_KEY')

cred = credentials.Certificate("serviceAccount.json")
firebase_admin.initialize_app(cred) 
db=firestore.client()



def importing(subject):
    print(subject)
    list=db.collection("Notes").document(subject).get()
    if list.exists:  
        list=db.collection("Notes").document(subject).get()
        data=list.to_dict()
        print("done")
        return (data.get('summary', '').strip())
    else:
        return ("there was no period today")


def chat(res,time,subject):
    data2={"message":res,"isSender":False,"time":time}
    list=db.collection("chatroom").document(subject).collection("chats").document().get()
    if list.exists:  
        db.collection("chatroom").document(subject).collection("chats").document().update(data2)
    else:
        db.collection("chatroom").document(subject).collection("chats").document().set(data2)




