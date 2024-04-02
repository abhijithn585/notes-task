import 'package:flutter/material.dart';

import 'package:task/model/notes_model.dart';
import 'package:task/service/firebase_service.dart';

class FirestoreProvider extends ChangeNotifier {
  FirestoreService service = FirestoreService();
  List<NotesModel> notesList = [];
  
  List<NotesModel> fetchNotes() {
    try {
      service.firestore
          .collection('user')
          .doc()
          .collection('notes')
          .snapshots()
          .listen((notes) {
        notesList =
            notes.docs.map((doc) => NotesModel.fromJson(doc.data())).toList();
        notifyListeners();
      });
      return notesList;
    } catch (e) {
      throw Exception(e);
    }
  }

  addNotes(NotesModel notes, String title, String uid) {
    try {
      return service.addProduct(notes, title, uid);
    } catch (e) {
      throw Exception(e);
    }
  }
}
