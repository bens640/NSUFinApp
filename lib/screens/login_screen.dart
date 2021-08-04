import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:nsu_financial_app/providers/providers.dart';
import 'package:nsu_financial_app/screens/home_screen.dart';
import 'package:nsu_financial_app/widgets/appBar_widget.dart';
import '../main.dart';
import 'dart:convert' show json, base64, ascii;

import '../network_requests.dart';

class LoginPage extends ConsumerWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void displayDialog(context, title, text) => showDialog(
    context: context,
    builder: (context) =>
        AlertDialog(
            title: Text(title),
            content: Text(text)
        ),
  );


  @override
  Widget build(BuildContext context, ScopedReader watch) {

    var loggedIn = watch(loggedInProvider);
    return Scaffold(
        appBar: BaseAppBar(),
        // resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                    labelText: 'Username'
                ),
              ),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    labelText: 'Password'
                ),
              ),
              ElevatedButton(
                  onPressed: () async {
                    var username = _usernameController.text;
                    var password = _passwordController.text;
                    var jwt = await attemptLogIn(username, password);
                    if(jwt != null) {
                      Map token = json.decode(jwt);

                      String tk = token['token'];

                      String id = token['id'].toString();
                      storage.write(key: "jwt", value: tk);
                      storage.write(key: 'id', value: id.toString());
                      loggedIn.flip();

                      Navigator.of(context).pushNamed('/');

                    } else {
                      displayDialog(context, "An Error Occurred", "No account was found matching that username and password");

                    }
                  },
                  child: Text("Log In")
              ),
              ElevatedButton(
                  onPressed: () async {
                    var username = _usernameController.text;
                    var password = _passwordController.text;

                    if(username.length < 1)
                      displayDialog(context, "Invalid Username", "The username should be at least 4 characters long");
                    else if(password.length < 1)
                      displayDialog(context, "Invalid Password", "The password should be at least 4 characters long");
                    else{
                      var res = await attemptSignUp(username, password);
                      if(res == 201)
                        displayDialog(context, "Success", "The user was created. Log in now.");
                      else if(res == 409)
                        displayDialog(context, "That username is already registered", "Please try to sign up using another username or log in if you already have an account.");
                      else {
                        displayDialog(context, "Error", "An unknown error occurred.");
                      }
                    }
                  },
                  child: Text("Sign Up")
              )
            ],
          ),
        )
    );
  }
}