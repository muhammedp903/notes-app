import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  // fillColor: Colors.white,
  // filled: true,
  floatingLabelBehavior: FloatingLabelBehavior.auto,
  enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey, width: 0.5)),
  focusedBorder:
      OutlineInputBorder(borderSide: BorderSide(color: Colors.blue, width: 1)),
);
