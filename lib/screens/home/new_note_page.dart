import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notes/services/database.dart';
import 'package:provider/provider.dart';

class NewNotePage extends StatefulWidget {
  @override
  _NewNotePageState createState() => _NewNotePageState();
}

class _NewNotePageState extends State<NewNotePage> {
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

    return Form(
        key: _formKey,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 25, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.close),
                    ),
                    TextButton(
                      // color: Colors.blue,
                      child: Text(
                        "Save",
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          await Database(uid: user.uid).newNote(
                            _currentTitle ?? "",
                            _currentBody,
                          );
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 30, 25, 0),
                child: TextFormField(
                  initialValue: "",
                  maxLines: 1,
                  autofocus: true,
                  textCapitalization: TextCapitalization.words,
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
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(26, 0, 25, 0),
                child: TextFormField(
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
              ),
            ]));
  }
}
