import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:task/model/notes_model.dart';

class FirestoreService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
    FirebaseAuth auth = FirebaseAuth.instance;

  Reference storage = FirebaseStorage.instance.ref();
  addProduct(NotesModel notes, String title, String uid) async {
    try {
     firestore .collection("user")
          .doc(auth.currentUser!.uid)
          .collection('notes')
          .doc(title)
          .set(notes.toJson());
    } catch (e) {
      throw Exception(e);
    }
  }
}
