import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:moonpath/widgets/widgetProperties.dart';

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

  @override
  Widget build(BuildContext context) {
    // ApiProvider().signOut();
    if (isLoading == true) {
      return WidgetProperties().loadingProgress(context);
    } else {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('LOGIN'),
        ),
        body: Builder(
          builder: (BuildContext context) {
            return Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Container(
                  alignment: Alignment.bottomCenter,
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextFormField(
                          onSaved: (String? input) {
                            _email = input;
                          },
                          validator: (input) {
                            if (input == null || input.isEmpty) {
                              return 'Please provide an email';
                            }
                          },
                          decoration: InputDecoration(
                              counterText: '',
                              labelText: 'Enter email',
                              icon: new Icon(Icons.mail)),
                          autofocus: true,
                          keyboardType: TextInputType.emailAddress,
                          maxLength: 30),
                      TextFormField(
                        validator: (input) {
                          if (input == null || input.isEmpty) {
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
                      new ElevatedButton(
                        clipBehavior: Clip.hardEdge,
                        onPressed: () {
                          toSignIn();
                        },
                        child: Text('LOGIN'),
                      ),
                      new Padding(padding: const EdgeInsets.only(top: 20.0)),
                      new Text('Don\'t have an account?'),
                      new InkWell(
                        child: Text(
                          'SIGN UP',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.blue),
                        ),
                        onTap: () {
                          getUser();
                        },
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

  Future getUser() async {
    FirebaseAuth.instance.authStateChanges().listen((User? checkUser) {
      user = checkUser;
      if (user == null) {
        print('----------------------------------------------');
        print('User not logged in!');
      } else {
        print('----------------------------------------------');
        print('User signed in!');
      }
    });
  }

  Future<void> toSignout() async {
    setState(() {
      isLoading = true;
    });
    await FirebaseAuth.instance.signOut();
    print('logged out na chuiii');
    setState(() {
      isLoading = false;
    });
  }

  Future<void> toSignIn() async {
    setState(() {
      isLoading = true;
    });
    final formState = _formKey.currentState;
    if (formState!.validate()) {
      formState.save();
      print('email: ' + _email.toString());
      print('password: ' + _password.toString());
      try {
        UserCredential user = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: _email.toString(), password: _password.toString());
        setState(() {
          isLoading = false;
        });
        WidgetProperties()
            .invalidDialog(context, 'CONGRATS', 'Sulod naka choy');
        print(user);
        print('-------------THE USER $user-----------------------');
      } on FirebaseAuthException catch (e) {
        print('-------------THE USER HAS NOT LOGGED IN-----------------------');
        print(e.code);
        print('-------------THE USER HAS NOT LOGGED IN-----------------------');
        if (e.code == 'user-not-found') {
          print('No user found on that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user');
        } else if (e.code == 'invalid-email') {
          print('Please enter valid email');
        } else if (e.code == 'user-not-found') {
          print('User not found');
        }
        setState(() {
          isLoading = false;
        });
        WidgetProperties()
            .invalidDialog(context, 'ERROR CREDS', 'Basin wrong chui');
      }
      setState(() {
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      WidgetProperties()
          .invalidDialog(context, 'INPUT FIELDS', 'Butangi pud chui');
    }
  }
}
