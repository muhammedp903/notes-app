import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes/services/database.dart';
import 'package:provider/provider.dart';
import '../../services/auth.dart';
import 'package:notes/models/note.dart';
import 'new_note.dart';
import 'note_list.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);

    return StreamProvider<List<Note>>.value(
      value: Database(uid: user.uid).notes,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Notes"),
          elevation: 0.0,
          actions: <Widget>[
            TextButton.icon(
              icon: Icon(Icons.person),
              onPressed: () async {
                await _auth.signOut();
              },
              label: Text("Logout"),
            ),
          ],
        ),
        body: Scaffold(
          body: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 18, 20, 0),
                child: Text(
                  "NOTES \u2022 ${user.email.toUpperCase()}",
                  style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12, letterSpacing: 0.3),
                ),
              ),
              Divider(
                height: 30,
                color: Colors.grey[600],
              ),
              NoteList(),
              SizedBox(height: 60,)
            ],
          ),

          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            child: Icon(Icons.add),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>NewNote())),
          ),
        ),
      ),
    );
  }
}
