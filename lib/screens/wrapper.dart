import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'home/home.dart';
import 'package:notes/screens/authenticate/authenticate.dart';
import 'package:provider/provider.dart';


class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<FirebaseUser>(context);
// return page depending on login status
    return user != null? SafeArea(child: Home()): SafeArea(child: Authenticate());
  }
}
