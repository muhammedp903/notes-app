import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes/services/database.dart';
import 'package:provider/provider.dart';
import '../../services/auth.dart';
import 'new_note_unused.dart';
import 'package:notes/models/note.dart';
import 'new_note_page.dart';
import 'note_list.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);
    final height = (MediaQuery.of(context).size.height * 0.9);
    //open the new note page
    void showNewNote() {
      showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (context) {
            return Container(
              height: height,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16)),
                  ),
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 0),
              child: NewNotePage(),
            );
          });
    }

    return StreamProvider<List<Note>>.value(
      value: Database(uid: user.uid).notes,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Notes"),
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              onPressed: () async {
                await _auth.signOut();
              },
              label: Text("Logout"),
            ),
          ],
        ),
        body: Scaffold(
          // backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                NoteList(),
                Text(
                  "Note titles must be unique\nSigned in as ${user.email}",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.all(10.0),
            child: FloatingActionButton(
              backgroundColor: Colors.blue,
              // foregroundColor: Colors.white,
              child: Icon(Icons.add),
              onPressed: () => showNewNote(),
            ),
          ),
        ),
      ),
    );
  }
}
