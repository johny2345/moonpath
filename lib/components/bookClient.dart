import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:moonpath/widgets/widgetProperties.dart';
import 'package:moonpath/services/services.dart';
import 'package:logger/logger.dart';
import 'package:moonpath/model/fetchDetails/buxFetchDetails.dart';
import 'package:moonpath/services/services.dart';

class BookPage extends StatefulWidget {
  const BookPage({Key? key}) : super(key: key);

  @override
  _BookPageState createState() => _BookPageState();
}

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

bool? isLoading = false;

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
                    maxLength: 50,
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
                    maxLength: 15,
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
                    maxLength: 30,
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
                    maxLength: 6,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        counterText: '',
                        labelText: 'Enter amount',
                        icon: new Icon(Icons.money)),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    maxLines: 5,
                    onSaved: (String? input) {
                      description = input;
                    },
                    validator: (input) {
                      if (input == null || input.isEmpty) {
                        return 'Please provide description';
                      }
                    },
                    maxLength: 130,
                    decoration: InputDecoration(
                      counterText: '',
                      labelText: 'Description...',
                      icon: new Icon(Icons.description),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 2.0),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
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
                            underline: Container(
                              height: 0,
                              color: Colors.red,
                            ),
                            value: _chosenValue,
                            dropdownColor: Colors.grey[200],
                            elevation: 10,
                            isExpanded: true,
                            icon: Icon(Icons.arrow_downward),
                            items: <String>[
                              'Gcash',
                              'Paymaya',
                              'USSC',
                              '7-eleven'
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
                      Apis().getDetails();
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

  Future<void> bookCustomer() async {
    setState(() {
      isLoading = true;
    });
    final formState = _formKey.currentState;
    if (formState!.validate()) {
      formState.save();
      try {} catch (e) {
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


// try {
//       print('-----------GET RESPONSE---------------');
//       Dio dio;
//       Response response = await Dio(BaseOptions(headers: {
//         "Content-Type": "application/json",
//         'x-api-key': '04e2f5c9afdf4df8a6b119f1b3267b8ed'
//       })).get(
//           'https://api.bux.ph/v1/api/sandbox/check_code?req_id=TEST1234&client_id=0000018c46&mode=API');
//       print('-----------GET RESPONSE 2---------------');
//       print(response);
//       // print(response.data['status']);
//       // print(response.data['image_url']);
//       print(response.statusCode);
//     } 