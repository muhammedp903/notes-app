import 'package:flutter/material.dart';
import 'package:notes/models/note.dart';
import 'package:notes/services/database.dart';

class EditNote extends StatefulWidget {
  final Note note;
  EditNote({this.note});

  @override
  _EditNoteState createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Note"),
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
                await Database(uid: widget.note.uid).editNote(
                  widget.note.docId,
                  _currentTitle ?? widget.note.title,
                  _currentBody ?? widget.note.body,
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
                    initialValue: widget.note.title,
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
                    initialValue: widget.note.body,
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
