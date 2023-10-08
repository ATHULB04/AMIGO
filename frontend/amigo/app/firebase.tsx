// Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app";
import { getFirestore } from "firebase/firestore";
// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
// For Firebase JS SDK v7.20.0 and later, measurementId is optional
// Your web app's Firebase configuration
const firebaseConfig = {
  apiKey: "AIzaSyAvXSSHSTbm7vXR_0mySUwOPJWlvZ1E480",
  authDomain: "studiesy.firebaseapp.com",
  databaseURL: "https://studiesy-default-rtdb.firebaseio.com",
  projectId: "studiesy",
  storageBucket: "studiesy.appspot.com",
  messagingSenderId: "1070198266308",
  appId: "1:1070198266308:web:ee0546f9c31da90d256c91",
  measurementId: "G-SPW2YS1XML"
};

// Initialize Firebase
// Initialize Firebase
const app = initializeApp(firebaseConfig);
const db = getFirestore(app);

export default db
