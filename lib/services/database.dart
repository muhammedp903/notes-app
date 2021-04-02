import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notes/models/note.dart';

class Database {

  final String uid;
  Database({this.uid});

  final CollectionReference noteCollection =
      Firestore.instance.collection("users");


  Future newNote(String title, String body) async {
    return await noteCollection.document(uid).collection("notes").add({
      "uid": uid,
      "title": title,
      "body": body,
    });
  }

  Future deleteNote(String id) async {
    return await noteCollection.document(uid).collection("notes").document(id).delete();
  }

  Future editNote(String id, String title, String body)async{
    return await noteCollection.document(uid).collection("notes").document(id).updateData({
      "title": title,
      "body": body,
    });
  }

  List<Note> _noteListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Note(
              uid: doc.data["uid"],
              docId: doc.documentID,
              title: doc.data["title"] ?? "",
              body: doc.data["body"] ?? "",
            );
    }).toList();
  }

  Stream<List<Note>> get notes {
    print(noteCollection.document(uid).collection("notes").snapshots().map(_noteListFromSnapshot));
    return noteCollection.document(uid).collection("notes").snapshots().map(_noteListFromSnapshot);
  }
}
