import 'package:flutter/material.dart';
import 'package:notes/models/note.dart';
import 'package:provider/provider.dart';
import 'note_tile.dart';

class NoteList extends StatefulWidget {
  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  @override
  Widget build(BuildContext context) {
    //get the list of notes and remove null values, putting them into a new list
    final notes = Provider.of<List<Note>>(context) ?? [];
    print(notes);
    notes.removeWhere((value) => value == null);

    //go through the list and create a tile for each note
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: notes.length,
      itemBuilder: (context, index) {
        print(notes[index]);
        return NoteTile(note: notes[index]);
      },
    );
  }
}
