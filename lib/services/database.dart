import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notes/models/note.dart';

class Database {

  final String uid;
  Database({this.uid});

  final CollectionReference noteCollection =
      Firestore.instance.collection("notes");

  Future addNote(String title, String body) async {
    return await noteCollection.document(title).setData({
      "uid": uid,
      "title": title,
      "body": body,
    });
  }

  // TODO: REPLACE ABOVE WITH THIS !!!!!!!! ---->>
  Future newNote(String title, String body) async {
    return await noteCollection.add({
      "uid": uid,
      "title": title,
      "body": body,
    });
  }

  Future deleteNote(String title) async {
    return await noteCollection.document(title).delete();
  }

  List<Note> _noteListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return doc.data["uid"] == uid.toString()
          ? Note(
              uid: doc.data["uid"],
              title: doc.data["title"] ?? "",
              body: doc.data["body"] ?? "",
            )
          : null;
    }).toList();
  }

  Stream<List<Note>> get notes {
    print(noteCollection.snapshots().map(_noteListFromSnapshot));
    return noteCollection.snapshots().map(_noteListFromSnapshot);
  }
}
