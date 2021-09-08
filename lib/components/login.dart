import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:farmtor/components/signUp.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool _obscureText = true;
  var _iconVisible = Icon(Icons.visibility);
  String? _email, _password;
  var userId;
  User? user;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future getUser() async {
    FirebaseAuth.instance.authStateChanges().listen((User? checkUser) {
      user = checkUser;
      if (user == null) {
        print('User not logged in!');
      } else {
        print('User signed out!');
      }
    });
  }

  @override
  void initState() {
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    // ApiProvider().signOut();
    if (isLoading == true) {
      return Material(
          child: Center(
        child: Image.asset(
          'assets/images/unnamed.gif',
          height: 70,
        ),
      ));
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('FarmTor'),
        ),
        body: Builder(
          builder: (BuildContext context) {
            return Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Container(
                  alignment: Alignment.bottomCenter,
                  padding: const EdgeInsets.all(40.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextFormField(
                          validator: (input) {
                            if (input!.isEmpty) {
                              return 'Please provide an email';
                            }
                          },
                          onSaved: (String? input) => _email = input,
                          decoration: InputDecoration(
                              counterText: '',
                              labelText: 'Enter email',
                              icon: new Icon(Icons.mail)),
                          keyboardType: TextInputType.emailAddress,
                          maxLength: 30),
                      TextFormField(
                        validator: (input) {
                          if (input!.isEmpty) {
                            return 'Input password';
                          }
                        },
                        onSaved: (input) => _password = input,
                        decoration: InputDecoration(
                          counterText: '',
                          labelText: 'Password',
                          icon: new Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: _iconVisible,
                            onPressed: () {
                              if (_obscureText == true) {
                                setState(() {
                                  _obscureText = false;
                                  _iconVisible = Icon(Icons.visibility_off);
                                });
                              } else {
                                setState(() {
                                  _iconVisible = Icon(Icons.visibility);
                                  _obscureText = true;
                                });
                              }
                            },
                          ),
                        ),
                        obscureText: _obscureText,
                        maxLength: 30,
                      ),
                      new Padding(
                        padding: const EdgeInsets.only(top: 40.0),
                      ),
                      new OutlineButton(
                        // highlightedBorderColor: Colors.deepOrange,
                        borderSide: BorderSide(color: Colors.blue),
                        onPressed: () {
                          toSignIn();
                        },
                        padding: EdgeInsets.fromLTRB(100.0, 20.0, 100.0, 20.0),
                        child: Text('LOGIN'),
                        splashColor: Colors.deepOrange,
                      ),
                      new Padding(padding: const EdgeInsets.only(top: 20.0)),
                      new Text('Don\'t have an account?'),
                      new InkWell(
                        child: Text(
                          'SIGN UP',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.blue),
                        ),
                        // onTap: () {
                        // },
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
    }
  }

  Future<void> toSignIn() async {
    print('email: ' + _email.toString());
    print('password: ' + _password.toString());
    final formState = _formKey.currentState;
    if (formState!.validate()) {
      formState.save();
      setState(() {
        isLoading = true;
      });
      try {
        UserCredential user = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: _email.toString(), password: _password.toString());
        setState(() {
          isLoading = false;
        });
        print('-------------THE USER HAS LOGGED IN-----------------------');
      } catch (signUpError) {
        setState(() {
          isLoading = false;
        });
      }
      setState(() {
        isLoading = false;
      });
    }
  }
}
