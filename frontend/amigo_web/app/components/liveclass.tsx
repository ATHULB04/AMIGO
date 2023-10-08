import { Button } from '@nextui-org/react';
import React, { useState, useEffect } from 'react'
import { VscDebugStart, VscDebugPause } from "react-icons/vsc"
import SpeechRecognition, { useSpeechRecognition } from 'react-speech-recognition';
import { addDoc, collection, doc, updateDoc } from 'firebase/firestore';
import Swal from 'sweetalert2';
import { getDatabase, ref, set } from "firebase/database";
import db from '../firebase';
import axios from 'axios';

const Minutespage = () => {
  const [listening, setListening] = useState(false);
  const {
    resetTranscript,
    browserSupportsSpeechRecognition,
    listening: isListening,
    transcript
  } = useSpeechRecognition();

  useEffect(() => {
    if (!browserSupportsSpeechRecognition) {
      console.log('Browser does not support speech recognition.');
    }
  }, [browserSupportsSpeechRecognition]);

  useEffect(() => {
    if (transcript) {
      // Update Firebase Realtime Database with the latest transcript
      const db = getDatabase();
      set(ref(db, 'teacher'), transcript);
    }
  }, [transcript]);

  const handleStartListening = () => {
    setListening(true);
    resetTranscript();
    SpeechRecognition.startListening();
  };

  const CORS_PROXY = 'https://cors-anywhere.herokuapp.com/';
  const API_URL = 'https://ihrd1-production.up.railway.app/summary';


  const handleStopListening = async () => {
    setListening(false);
    // Add a new document to the "Meeting summary" collection with auto-generated ID
   
    SpeechRecognition.stopListening();
  };

  const handleSubmit = async (e: { preventDefault: () => void; }) => {
    try {
      const physicsDocRef = doc(db, 'Notes', 'English');
      // Data to be updated

      const dataToUpdate = {
        transcribe: transcript,
      };
      await updateDoc(physicsDocRef, dataToUpdate);
      console.log('Document added successfully with ID: ');
      const response = await axios.post(`${CORS_PROXY}${API_URL}`, {
        subject: "English",
      });
      
      console.log('Server Response:', response.data);
    } catch (error) {
      console.error('Error adding document: ', error);
    }
    Swal.fire(
      'Good job!',
      'Successfully summarized!',
      'success'
    )
  };

  return (
    <div className="bg-white-80 flex min-h-screen w-full">
      <div
        className="flex w-full flex-col bg-[#6e54ff]/80 sm:w-64 m-4 rounded-3xl"
        style={{ flex: 3 }}
      >
        <div className="h-full  px-6 py-4 sm:px-6 lg:px-8">
          <div className="h-full w-full flex flex-col bg-[#eef7ff] rounded">
            <div className='h-full p-3 text-xl'>
              {transcript}
            </div>
            <div className=' flex flex-row justify-center'>
              <Button onClick={isListening ? handleStopListening : handleStartListening} className={`bg-blue-400 w-fit border-blue-400 rounded p-3 m-3 gap-3 text-white hover:bg-blue-100 focus:border-white ${isListening ? 'active' : ''}`}>
                {isListening ? "Stop class" : "Start class"}{isListening ? <VscDebugPause /> : <VscDebugStart />}
              </Button>
              <Button onClick={handleSubmit} className='bg-[#6e54ff] ml-3 w-fit rounded p-3 m-3 text-white hover:bg-blue-400'>Submit</Button>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}

export default Minutespage;
