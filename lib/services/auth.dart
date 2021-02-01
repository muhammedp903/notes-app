import 'package:firebase_auth/firebase_auth.dart';

import 'database.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<FirebaseUser> get user {
    return _auth.onAuthStateChanged;
  }

//  Future signInAnon() async {
//    try {
//      AuthResult result = await _auth.signInAnonymously();
//      FirebaseUser user = result.user;
//      return user;
//    } catch (e) {
//      print("Error caught:");
//      return null;
//    }
//  }

  Future signIn(String email,String password) async {
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return user;
    }catch(e){

    }
  }

  Future register(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      await Database(uid: user.uid).addNote("My first note", "Welcome to the notes app");
      return user;
    } catch (e) {
      print("Error registering");
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print("Error signing out");
    }
  }

}