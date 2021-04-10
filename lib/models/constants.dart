import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  floatingLabelBehavior: FloatingLabelBehavior.auto,
  enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey, width: 0.5)),
  focusedBorder:
      OutlineInputBorder(borderSide: BorderSide(color: Colors.cyan, width: 1)),
);

const String greetingNote = """
Tap on a note to see its full contents, edit any part of it, or delete it.
You can also edit a note by tapping the edit button on its tile.""";

const String greetingTitle = "Welcome to the notes app!";