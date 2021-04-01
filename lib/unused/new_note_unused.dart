import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes/models/constants.dart';
import 'package:notes/services/database.dart';
import 'package:provider/provider.dart';

class NewNote extends StatefulWidget {
  @override
  _NewNoteState createState() => _NewNoteState();
}

class _NewNoteState extends State<NewNote> {
  final _formKey = GlobalKey<FormState>();

  String _currentTitle;
  String _currentBody;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);

    return Form(
        key: _formKey,
        child: Column(children: <Widget>[
          Text(
            "Create a new note",
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            initialValue: "",
            decoration: textInputDecoration.copyWith(hintText: "Title"),
            validator: (val) => val.isEmpty ? "Please enter a title" : null,
            onChanged: (val) => setState(() => _currentTitle = val),
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            initialValue: "",
            decoration: textInputDecoration.copyWith(hintText: "Text",),
            validator: (val) =>
            val.isEmpty ? "Please enter some text" : null,
            onChanged: (val) => setState(() => _currentBody = val),
          ),
          SizedBox(
            height: 20,
          ),
          RaisedButton(
            color: Colors.lightBlue,
            child: Text(
              "Save note",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () async {
              if (_formKey.currentState.validate()){
                await Database(uid: user.uid).newNote(
                    _currentTitle ?? "",
                    _currentBody ,
                );
                Navigator.pop(context);
              }
            },
          ),
        ]));
  }
}
