import os
import ast
import excel
from langchain.prompts import PromptTemplate
from langchain.llms import OpenAI
from langchain.chains import LLMChain
from langchain.schema import HumanMessage
from langchain.chat_models import ChatOpenAI

os.environ["OPENAI_API_KEY"] = os.environ.get('OPENAI_API_KEY')
import firebase_admin
from firebase_admin import credentials,firestore

cred = credentials.Certificate("serviceAccount.json")
firebase_admin.initialize_app(cred) 
db=firestore.client()

response_cache = {}
def promptmaker(transcribed_txt):
    instructions = """You are a chatbot who helps students learn. You make a summary based on the teacher's words.
    Only use words that the teacher told. Don't tell anything more or less than what the teacher told.
    Make sure the summary is not too long or too short.
    Make sure the summary is easy to understand.
    Make sure the summary only contains the contents told by the teacher.
    answer as a third person and remember you follow the format of a summary.
    """

    data = str(transcribed_txt)
    question = f"give me a summary of {transcribed_txt}"  # Corrected the variable name
    prompt = instructions + data + question
    return askgpt(prompt)

def askgpt(prompt):
    
    chat_model = ChatOpenAI(temperature=0.1, model='gpt-3.5-turbo', openai_api_key=os.environ.get("OPENAI_API_KEY"), max_tokens=250, stop=["\n"])
    
    if prompt in response_cache:
        return response_cache[prompt]

    output = chat_model([HumanMessage(content=prompt)])
    response = output.content
    response_cache[prompt] = response
    return response
def attendencepromptmaker(transcribed_txt):
    instructions = """You are a teacher's assistant.You help teacher's take attendance.
    You only return the absentees rollno from the text given.
    You should only return the rollno of the absentees.
    only integers should be returned.
    expected output is a list of integers.
        example:
            [1,2,3,4,5,6,7,8,9,10]
    """

    data = str(transcribed_txt)
    question = f"what is roll number's of absentees mentioned in the text :{transcribed_txt}"  # Corrected the variable name
    prompt = instructions + data + question
    return attendenceaskgpt(prompt)

def attendenceaskgpt(prompt):
    
    chat_model = ChatOpenAI(temperature=0.1, model='gpt-3.5-turbo', openai_api_key=os.environ.get("OPENAI_API_KEY"), max_tokens=250, stop=["\n"])   
    output = chat_model([HumanMessage(content=prompt)])
    response = output.content
    real_list = ast.literal_eval(response)
    return real_list

def attendencecheckpromptmaker(transcribed_txt):
    instructions = f"""
    You return 1 if {transcribed_txt} contain word 'absentees'.
    You return 1 if {transcribed_txt} contain word 'absence'.
    Don't return anything else other than integers

    """
    data = str(transcribed_txt)
    
    

    prompt = (data + instructions)
    return attendencecheckaskgpt(prompt)

def attendencecheckaskgpt(prompt):
    
    chat_model = ChatOpenAI(temperature=0.1, model='gpt-3.5-turbo', openai_api_key=os.environ.get("OPENAI_API_KEY"), max_tokens=250)   
    output = chat_model([HumanMessage(content=prompt)])
    response = output.content
    return int(response)

def attendenceremoverpromptmaker(transcribed_txt):
    instructions = f"""
    Remove contents related to absentees from the text:'{transcribed_txt}'
    Don't add or remove anything else.
    """
    data = str(transcribed_txt)
    
    

    prompt = (data + instructions)
    return attendenceremoveraskgpt(prompt)

def attendenceremoveraskgpt(prompt):
    
    chat_model = ChatOpenAI(temperature=0.1, model='gpt-3.5-turbo', openai_api_key=os.environ.get("OPENAI_API_KEY"), max_tokens=250, stop=["\n"])   
    output = chat_model([HumanMessage(content=prompt)])
    response = output.content
    return response




def details(subject):
    list=db.collection("Notes").document(subject).get()
    if list.exists:  
        list=db.collection("Notes").document(subject).get()
        data=list.to_dict()
        sentence=data.get('transcribe', '').strip()
        print(sentence)
    else:
        print("does not exist")
    check= attendencecheckpromptmaker(sentence)
    if (check==1):
        absentees = attendencepromptmaker(sentence)
        removed_txt = attendenceremoverpromptmaker(sentence)
        summary = promptmaker(removed_txt)
        print(summary)
        print(absentees)
        excel.call1(absentees)
        absent(absentees)
    else:
        summary = promptmaker(sentence)
        print(summary)
        print("No data")
    print(3)
    db.collection("Notes").document(subject).update({"summary":summary})
    return "done"

def absent(id):
    list=db.collection("students").document("ECB").get()
    if list.exists:  
        list=db.collection("students").document("ECB").get()
        data=list.to_dict()
    else:
        print("does not exist")
    for i in range(1,7):
        data[str(i)]['absent'] = False
    db.collection("students").document("ECB").update(data)
    for i in range(len(id)):
        data[str(id[i])]['absent'] = True
    db.collection("students").document("ECB").update(data)









