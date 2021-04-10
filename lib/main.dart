import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes/services/auth.dart';
import 'screens/wrapper.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<FirebaseUser>.value(
      value: AuthService().user,
      child: MaterialApp(
        theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.cyan,
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.white,
              elevation: 0.0,
            )
        ),

        darkTheme: ThemeData(
          brightness: Brightness.dark,
          accentColor: Colors.white,
          primarySwatch: Colors.cyan,
          scaffoldBackgroundColor: Colors.black,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.black,
            elevation: 0,
          ),
          dividerColor: Colors.grey
        ),
        home: Wrapper(),
      ),
    );
  }
}
