import 'package:flutter/material.dart';
import 'screens/register.dart';
import 'package:http/http.dart' show get;
import 'dart:convert';



void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sun Authen',
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final formKey = GlobalKey<FormState>();
  String emailString, passwordString;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
          key: formKey,
          child: ListView(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
//            color: Colors.yellow,
                margin: EdgeInsets.only(top: 100.0),
                child: logoShow(),
              ),
              Container(
                alignment: Alignment.center,
                child: titleApp(),
              ),
              Container(
                margin: EdgeInsets.only(left: 30.0, right: 30.0),
                child: emailTextField(),
              ),
              Container(
                margin: EdgeInsets.only(left: 30.0, right: 30.0, bottom: 15.0),
                child: passwordTextField(),
              ),
              Container(
                margin: EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.all(5.0),
                        child: SignInButton(context),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.all(5.0),
                        child: SignUpButton(context),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  Widget testText() {
    return Text('This is testText');
  }

  Widget logoShow() {
    return Image.asset('images/logo_sun.png');
  }

  Widget titleApp() {
    return Text(
      'SUN AUTHEN',
      style: TextStyle(
          color: Colors.red,
          fontSize: 30.0,
          fontFamily: 'Sriracha-Regular',
          fontWeight: FontWeight.bold),
    );
  }

  Widget emailTextField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Email Address : ', hintText: 'you@email.com'),
      validator: (String emailValue) {
        if (!emailValue.contains('@')) {
          return 'Email false format';
        }
      },
      onSaved: (String value) {
        emailString = value;
      },
    );
  }

  Widget passwordTextField() {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
          labelText: 'Password : ', hintText: 'more 5 charactors'),
      validator: (String passwordValue) {
        if (passwordValue.length <= 5) {
          return 'Password must more than 5 charactors';
        }
      },onSaved: (String value) {
      passwordString = value;
    },
    );
  }

  Widget SignInButton(BuildContext context) {
    return RaisedButton(
      color: Colors.blue[400],
      child: Text(
        'SignIn',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        print('You click SignIn');
//        print(formKey.currentState.validate());
        if (formKey.currentState.validate()) {
          formKey.currentState.save();
          checkEmailAndPass(context,emailString,passwordString);
        }
      },
    );
  }


  void checkEmailAndPass(BuildContext context, String email, String password) async {
    print('email ==> $email, password ==> $password');

    String url = 'http://www.androidthai.in.th/sun/getUserWhereUserJochi.php?isAdd=true&User=$email';
    var response = await get(url);
    var result = json.decode(response.body);
    print('This is result => $result');
    if(result.toString() == 'null'){

    }else{

    }
  }

  void showSnackBar(String messageString) {
    
  }

  Widget SignUpButton(BuildContext context) {
    return RaisedButton(
      color: Colors.blue[300],
      child: Text(
        'SignUp',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        print('You click Signup');
        var myRounte = MaterialPageRoute(
            builder: (BuildContext context) => RegisterPage());
        Navigator.of(context).push(myRounte);
      },
    );
  }
} //End of _HomePagestate
