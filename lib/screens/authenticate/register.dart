import 'package:flutter/material.dart';
import 'package:notes/models/constants.dart';
import 'package:notes/services/auth.dart';
import 'package:notes/screens/loading.dart';

class Register extends StatefulWidget {
  final Function toggleView;

  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email;
  String password;
  String error = "";
  bool loading = false;
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
    return loading
        ? Loading()
        : Scaffold(
            // backgroundColor: Colors.white,
            appBar: AppBar(
              elevation: 0.0,
              title: Text("Register"),
              actions: <Widget>[
                TextButton.icon(
                    onPressed: () {
                      widget.toggleView();
                    },
                    icon: Icon(Icons.person),
                    label: Text("Sign In"))
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(labelText: "Email"),
                      validator: (val) => val.isEmpty ? "Enter an email" : null,
                      onEditingComplete: () => myFocusNode.requestFocus(),
                      onChanged: (val) {
                        setState(() {
                          email = val;
                        });
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      focusNode: myFocusNode,
                      decoration: textInputDecoration.copyWith(
                          labelText: "Create password"),
                      validator: (val) => val.length < 6
                          ? "Password must be at least 6 characters long"
                          : null,
                      obscureText: true,
                      onChanged: (val) {
                        setState(() {
                          password = val;
                        });
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextButton(
                      child: Text(
                        "Create Account",
                        style: TextStyle( fontSize: 20),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() {
                            loading = true;
                          });
                          dynamic result =
                              await _auth.register(email, password);
                          if (result == null) {
                            setState(() {
                              error = "Error registering";
                              loading = false;
                            });
                          }
                        }
                      },
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      error,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 14,
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
