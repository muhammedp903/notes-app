import 'package:flutter/material.dart';
import 'package:notes/models/constants.dart';
import 'package:notes/services/auth.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _formKey = GlobalKey<FormState>();
  String email;
  String error = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reset Password", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),),
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
                validator: (val) =>
                val.isEmpty ? "Please enter an email" : null,
                onChanged: (val) {
                  setState(() {
                    email = val;
                  });
                },
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                error,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14,
                ),
              ),
              TextButton(
                child: Text(
                  "Reset Password",
                  style: TextStyle( fontSize: 20),
                ),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    await AuthService().resetPassword(email).then((value) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Email sent")));
                    }, onError: (e){
                      String errorText;
                      switch (e.code) {
                        case "ERROR_USER_NOT_FOUND":
                          errorText = "User doesn't exist";
                          break;
                        case "ERROR_INVALID_EMAIL":
                          errorText = "Invalid email";
                          break;

                        default: errorText = "Error sending reset email";
                      }
                      setState(() {
                        error = errorText;
                      });
                    });
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
