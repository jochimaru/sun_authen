import 'package:flutter/material.dart';
import 'package:http/http.dart' show get;
import 'dart:convert';
import 'package:sun_authen/main.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();
  String nameString = '';
  String emailString = '';
  String passwordString = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Register'),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.cloud_upload),
                tooltip: 'Upload to server',
                onPressed: () {
                  UploadtoServer();
                })
          ],
        ),
        body: Form(
          key: formKey,
          child: ListView(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 50.0, right: 50.0, top: 80.0),
                child: nameText(),
              ),
              Container(
                margin: EdgeInsets.only(left: 50.0, right: 50.0, top: 50.0),
                child: emailText(),
              ),
              Container(
                margin: EdgeInsets.only(left: 50.0, right: 50.0, top: 50.0),
                child: passwordText(),
              )
            ],
          ),
        ));
  }

  UploadtoServer() {
    print('Click Upload');
//    formKey.currentState.reset();
    print(formKey.currentState.validate());
    formKey.currentState.save();
    print(
        'Name = $nameString, Email = $emailString, Password = $passwordString');

    sentNewUserToServer(nameString, emailString, passwordString);
  }

  void sentNewUserToServer(
      String userName, String userEmail, String userPassword) async {

    String url = 'http://www.androidthai.in.th/sun/addUserJoChi.php?isAdd=true&Name=$userName&User=$userEmail&Password=$userPassword';
    var response = await get(url);
    var result = json.decode(response.body);
    print('Result => $result');

    if (result.toString() == 'true') {
      Navigator.pop(context);
    }
  }

  Widget nameText() {
    return TextFormField(
      validator: (String namevalue) {
        if (namevalue.length == 0) {
          return 'Name not to Blank';
        }
      },
      onSaved: (String nameStr) {
        nameString = nameStr;
      },
      decoration: InputDecoration(labelText: 'Name : ', hintText: 'Name..'),
    );
  }

  Widget emailText() {
    return TextFormField(
      validator: (String emailvalue) {
        if (!emailvalue.contains('@')) {
          return 'email is not valid';
        }
      },
      onSaved: (String emailStr) {
        emailString = emailStr;
      },
      decoration: InputDecoration(labelText: 'Email : ', hintText: 'Email..'),
    );
  }

  Widget passwordText() {
    return TextFormField(
      obscureText: false,
      validator: (String pwdvalue) {
        if (pwdvalue.length < 5) {
          return 'password length must be 5 above';
        }
      },
      onSaved: (String pwdStr) {
        passwordString = pwdStr;
      },
      decoration: InputDecoration(
          labelText: 'Password : ', hintText: 'More 5 charactors..'),
    );
  }
}
