import 'package:flutter/material.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:moonpath/widgets/widgetProperties.dart';
import 'package:moonpath/services/services.dart';
import 'package:logger/logger.dart';
import 'package:date_time_picker/date_time_picker.dart';

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
String? paymentMethod;

var _timeController = TextEditingController();
var _dateController = TextEditingController();

TimeOfDay _time = TimeOfDay.now().replacing(minute: 00);
DateTime _date = DateTime.now();
DateTime selectedDate = DateTime.now();

class _BookPageState extends State<BookPage> {
  @override
  void initState() {
    super.initState();
  }

  // @override
  // void dispose() {
  //   _timeController.dispose();
  //   _dateController.dispose();
  //   super.dispose();
  // }

  void onTimeChanged(TimeOfDay newTime) {
    setState(() {
      _time = newTime;
      _timeController.value = _timeController.value.copyWith(
        text: _time.format(context).toString(),
        selection: TextSelection(
            baseOffset: _time.format(context).toString().length,
            extentOffset: _time.toString().length),
        composing: TextRange.empty,
      );
    });
  }

  _buildScheduleDate() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: DateTimePicker(
                type: DateTimePickerType.date,
                //dateMask: 'yyyy/MM/dd',
                controller: _dateController,
                //initialValue: _initialValue,
                firstDate: DateTime(2020),
                lastDate: DateTime(2100),
                icon: Icon(Icons.event),
                dateLabelText: 'Date',
                // locale: Locale('pt', 'BR'),
                selectableDayPredicate: (date) {
                  if (date
                      .isBefore(DateTime.now().subtract(Duration(days: 1)))) {
                    return false;
                  } else {
                    return true;
                  }
                },
                onChanged: (val) => setState(() {
                  _date = DateTime.parse(val);
                }),
                validator: (input) {
                  if (input == null || input == '') {
                    return 'Please choose date';
                  }
                },
                // onSaved: (val) => setState(() {
                //   _date = DateTime.parse(val);
                // }),
              ),
            )),
        Expanded(
          child: TextFormField(
            readOnly: true,
            onTap: () {
              Navigator.of(context).push(
                showPicker(
                  context: context,
                  value: _time,
                  onChange: onTimeChanged,
                ),
              );
            },
            controller: _timeController,
            decoration: InputDecoration(
              labelText: 'Time',
              // icon: IconButton(
              //     padding: EdgeInsets.all(0.0),
              //     color: Colors.deepPurpleAccent[300],
              //     highlightColor: Colors.teal,
              // onPressed: () {
              //   Navigator.of(context).push(
              //     showPicker(
              //       context: context,
              //       value: _time,
              //       onChange: onTimeChanged,
              //     ),
              //   );
              // },
              //     icon: Icon(Icons.access_time_outlined)),
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading == true) {
      return WidgetProperties().loadingProgress(context);
    } else {
      return Scaffold(
        resizeToAvoidBottomInset: false,
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
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(20.0),
            child: SingleChildScrollView(
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
                      } else if (input.contains(new RegExp(r'[A-Z]'))) {
                        return 'Please provide valid amount';
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
                  _buildScheduleDate(),
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
                            value: paymentMethod,
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
                                paymentMethod = value;
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
                      // Apis().getDetails();
                      bookCustomer();
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
    var timeFormat = _time.format(context);
    DateTime today = DateTime.now();
    print(today.year);
    print(today.month);
    print(today.year.toString() +
        today.month.toString() +
        today.day.toString() +
        today.hour.toString() +
        today.second.toString() +
        today.millisecond.toString());

    print('---------------------------$today---------------');
    print('get data: $_date $_timeController $_time');
    print('----------------->$timeFormat $paymentMethod');
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
      // WidgetProperties()
      //     .invalidDialog(context, 'INPUT FIELDS', 'Butangi pud chui');
    }
  }
}
