import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseMethods {
  FirebaseFirestore db = FirebaseFirestore.instance;

  getNotes() async {
    return db.collection('Notes').snapshots();
  }

  updateNotes(String transcribe){

  }
}
