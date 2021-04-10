import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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

  FocusNode myFocusNode;

  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("New Note"),
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.close),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                await Database(uid: user.uid).newNote(
                  _currentTitle ?? "",
                  _currentBody,
                );
                Navigator.pop(context);
              }
            },
            child: Text(
              "Save",
            ),
          ),
        ],
      ),
      body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 25, 0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    initialValue: "",
                    maxLines: 1,
                    autofocus: true,
                    textCapitalization: TextCapitalization.sentences,
                    style: TextStyle(fontSize: 24),
                    decoration: InputDecoration(
                        hintText: "Title",
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none),
                    validator: (val) =>
                        val.isEmpty ? "Please enter a title" : null,
                    onChanged: (val) => setState(() => _currentTitle = val),
                    onEditingComplete: () => myFocusNode.requestFocus(),
                  ),
                  TextFormField(
                    initialValue: "",
                    focusNode: myFocusNode,
                    textCapitalization: TextCapitalization.sentences,
                    style: TextStyle(fontSize: 19),
                    decoration: InputDecoration(
                        hintText: "Note",
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none),
                    maxLines: 10,
                    minLines: 1,
                    validator: (val) =>
                        val.isEmpty ? "Please enter some text" : null,
                    onChanged: (val) => setState(() => _currentBody = val),
                  ),
                ]),
          )),
    );
  }
}
