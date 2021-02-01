import 'package:flutter/material.dart';
import 'package:notes/models/note.dart';
import 'package:notes/services/database.dart';

class NoteTile extends StatelessWidget {
  final Note note;

  NoteTile({this.note});

  //create the tile for a single note, with Icon, Title/Text, and Delete button
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 8),
        child: Card(

          margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
          child: ListTile(
            // onTap: ,
            // leading: Padding(
            //   padding: const EdgeInsets.fromLTRB(0,1,0,0),
            //   child: Icon(Icons.note, color: Colors.blue,size: 35,),
            // ),
            title: Text(
              note.title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              note.body,
              // style: TextStyle(color: Colors.black),
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              // color: Colors.grey[600],
              onPressed: () => Database().deleteNote(note.title),
            ),
          ),
        ));
  }
}
