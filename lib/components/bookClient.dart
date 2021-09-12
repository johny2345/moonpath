import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:moonpath/widgets/widgetProperties.dart';

class BookPage extends StatefulWidget {
  const BookPage({Key? key}) : super(key: key);

  @override
  _BookPageState createState() => _BookPageState();
}

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

bool? isLoading = false;
String? req_id = 'TEST1234';
String? client_id = "0000018c46";
String? notification_url = '';
int? amount = 25000;
String? channel = 'gcash';
int? expiry = 2;
String? redirect_url =
    'https://www.facebook.com/Moonpath-travel-and-tours-103570147872534';
String? param1 = 'Request received';
String? param2 = 'test param';

String? email;
String? contactNumber;
String? name;
String? description;

String? _chosenValue;

class _BookPageState extends State<BookPage> {
  @override
  Widget build(BuildContext context) {
    if (isLoading == true) {
      return WidgetProperties().loadingProgress(context);
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('Book now'),
          centerTitle: true,
        ),
        body: _userInputDetailsForm(context),
      );
    }
  }

  Widget _userInputDetailsForm(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        return Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    onSaved: (String? input) {
                      email = input;
                    },
                    validator: (input) {
                      if (input == null || input.isEmpty) {
                        return 'Please provide your email';
                      }
                    },
                    decoration: InputDecoration(
                        counterText: '',
                        labelText: 'Enter email',
                        icon: new Icon(Icons.email)),
                  ),
                  TextFormField(
                    onSaved: (String? input) {
                      contactNumber = input;
                    },
                    validator: (input) {
                      if (input == null || input.isEmpty) {
                        return 'Please provide your contact #';
                      }
                    },
                    decoration: InputDecoration(
                        counterText: '',
                        labelText: 'Enter phone number',
                        icon: new Icon(Icons.phone)),
                  ),
                  TextFormField(
                    onSaved: (String? input) {
                      name = input;
                    },
                    validator: (input) {
                      if (input == null || input.isEmpty) {
                        return 'Please provide your name';
                      }
                    },
                    decoration: InputDecoration(
                        counterText: '',
                        labelText: 'Enter your name',
                        icon: new Icon(Icons.person)),
                  ),
                  TextFormField(
                    onSaved: (String? input) {
                      name = input;
                    },
                    validator: (input) {
                      if (input == null || input.isEmpty) {
                        return 'Please provide amount';
                      }
                    },
                    decoration: InputDecoration(
                        counterText: '',
                        labelText: 'Enter amount',
                        icon: new Icon(Icons.money)),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 8.0),
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.grey[200],
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
                          child: DropdownButton<String>(
                            value: _chosenValue,
                            dropdownColor: Colors.grey[200],
                            elevation: 3,
                            isExpanded: true,
                            icon: Icon(Icons.payment),
                            items: <String>[
                              'Gcash',
                              'Paymaya',
                              'Flutter',
                              'Android'
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            hint: Text("Mode of payment",
                                style: TextStyle(
                                  backgroundColor: Colors.grey[200],
                                  color: Colors.black87,
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.start),
                            onChanged: (String? value) {
                              setState(() {
                                _chosenValue = value;
                              });
                            },
                          ),
                        )),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  new ElevatedButton(
                    clipBehavior: Clip.hardEdge,
                    onPressed: () {
                      // toSignIn();
                    },
                    child: Text('BOOK NOW'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
