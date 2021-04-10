import 'package:flutter/material.dart';
import 'package:notes/models/note.dart';
import 'package:notes/services/database.dart';

import 'edit_note.dart';

class NoteTile extends StatelessWidget {
  final Note note;

  NoteTile({this.note});

  showDetails(BuildContext context){
    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text(note.title,),
        content: Text(note.body),
        contentPadding: EdgeInsets.fromLTRB(24, 20, 24, 16),
        actions: [
          TextButton.icon(
            icon: Icon(Icons.delete),
            label: Text("Delete"),
            onPressed: () {
              Database(uid: note.uid).deleteNote(note.docId);
              Navigator.pop(context);
            }
          ),
          TextButton.icon(
              label: Text("Edit"),
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context)=> EditNote(note: note,)));
              }),
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Close", style: TextStyle(color: Theme.of(context).textTheme.bodyText1.color),)),
        ],
      );
    });
  }

  //create the tile for a single note, with Icon, Title/Text, and Delete button
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 4),
        child: Column(
          children: [
            ListTile(
              onTap: (){
                showDetails(context);
              },
              title: Text(
                note.title,
                style: TextStyle(fontWeight: FontWeight.bold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(
                note.body,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    visualDensity: VisualDensity(horizontal: -1, vertical: 0),
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context)=> EditNote(note: note,))),
                  ),
                ],
              ),
            ),
            Divider(
              height: 4,
              indent: 10,
              endIndent: 10,
            ),
          ],
        ));
  }
}
