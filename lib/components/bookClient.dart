import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moonpath/api/apiProvider.dart';
import 'package:moonpath/widgets/widgetProperties.dart';
import 'package:moonpath/services/services.dart';
import 'package:date_time_picker/date_time_picker.dart';

class BookPage extends StatefulWidget {
  const BookPage({Key? key}) : super(key: key);

  @override
  _BookPageState createState() => _BookPageState();
}

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

bool? isLoading = false;
bool? getCurr = false;

String? email;
String? contactNumber;
String? name;
String? getMonth, dateFormatter;
String? description;
String? paymentMethod = null;
String? amount = '25000';

DateTime? dateMatchedToday;

var schedList = [];

var _timeController = TextEditingController();
var _dateController = TextEditingController();

TimeOfDay _time = TimeOfDay.now().replacing(minute: 00);
DateTime selectedDate = DateTime.now();

class _BookPageState extends State<BookPage> {
  @override
  void initState() {
    super.initState();
    print('CALL A FUNCTION!');
    ApiProvider().getSchedules().then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        // debugPrint('GET SCHEDULE');
        setState(() {
          schedList.add(doc['schedule'].toDate());
        });
      });
    });
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
    bool? verifierDateToday = false;
    getCurr = false;
    int? length = schedList.length - 1;
    DateTime? dateToday = DateTime.now();
    // print('------DATE TODAY: $dateToday');
    // print('------Length TODAY: $length ------------------');
    if (length <= 0) {
      return Container();
    } else {
      return DateTimePicker(
        type: DateTimePickerType.date,
        //dateMask: 'yyyy/MM/dd',
        controller: _dateController,
        firstDate: DateTime(2020),
        lastDate: DateTime(2100),
        icon: Icon(Icons.event),
        dateLabelText: 'Date',
        // locale: Locale('en', 'US'),
        selectableDayPredicate: (date) {
          for (var i = 0; i <= length; i++) {
            // temp = date.month == schedList[i].month &&
            //     date.year == schedList[i].year &&
            //     date.day == schedList[i].day;

            if (getCurr == false) {
              getCurr = schedList[i].year == dateToday.year &&
                  schedList[i].month == dateToday.month &&
                  schedList[i].day == dateToday.day;
              verifierDateToday = true;

              dateMatchedToday = schedList[i];
            }
            // bool? temp2 = getCurr != true;
            // print('---------Generated sched: $temp');
            // print('---------CONDITIONAL get curr: $getCurr');
            if (date.month == schedList[i].month &&
                date.year == schedList[i].year &&
                date.day == schedList[i].day &&
                getCurr != true) {
              return false;
            }
            getCurr = false;
          }
          if (date.month == schedList[1].month &&
              date.day == schedList[1].day) {
            return false;
          }
          // print('--------------CURR DATE IS TRUE: $getCurr ------------------');

          if (verifierDateToday == true) {
            dateFormatter = dateToday.year.toString() +
                '-' +
                dateToday.month.toString() +
                '-' +
                dateToday.day.toString();

            print('DATE FORMATTER FOR TODAY: $dateFormatter');
          }

          if (date.isBefore(DateTime.now().subtract(Duration(days: 1)))) {
            return false;
          } else {
            return true;
          }
        },
        onChanged: (val) => setState(() {
          selectedDate = DateTime.parse(val);
        }),
        validator: (input) {
          if (input == null || input == '') {
            return 'Please choose date';
          } else if (input == dateFormatter) {
            return 'Date not allowed';
          }
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading == true) {
      return WidgetProperties().loadingProgress(context);
    } else {
      return Scaffold(
        // resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Book now'),
          centerTitle: true,
        ),
        body: _userInputDetailsForm(context),
      );
    }
  }

  Widget _userInputDetailsForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            // reverse: true,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  onSaved: (String? input) {
                    setState(() {
                      email = input;
                    });
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
                    setState(() {
                      contactNumber = input;
                    });
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
                    setState(() {
                      name = input;
                    });
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
                    setState(() {
                      amount = input;
                    });
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
                    setState(() {
                      description = input;
                    });
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
                            'BPI',
                            'Union Bank',
                            'RCBC',
                            'Credit/Debit',
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
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      bookCustomer();
                    }
                  },
                  child: Text('BOOK NOW'),
                ),
                SizedBox(
                  height: 150,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> bookCustomer() async {
    // DateTime selectedDate =
    //     DateTime(_date.year, _date.month, _date.day, _time.hour, _time.minute);
    // print('Selected date: $selectedDate');
    DateTime? utcDate = selectedDate.toUtc();
    DateTime? localDate = selectedDate.toLocal();
    String? channel, _instructions = '';
    print('utcDate DATE: $utcDate');
    print('localDate DATE: $localDate');
    print('PaymentMEthod: $paymentMethod');
    print(name);
    print(email);
    print(description);
    // name = "Wawangski Malakas";
    // _instructions =
    //     'This is a sample description! hahahahah. The quick brown fox jumps over the lazy dog. why am I having a hard time using flutter. perhaps its because of the major change implemented by google developers to resolve the null issues that persist in most mobile applications for android and IOS. thanks you.';
    // selectedDate = DateTime.now();
    // email = 'testemail@yahoo.com';
    // amount = '40000';
    // paymentMethod = 'Gcash';
    // contactNumber = '09301325498';
    // description = 'birthday party me yowwww';
    // WidgetProperties().displayAnimatedDialog(
    //     context,
    //     name,
    //     selectedDate,
    //     description,
    //     email,
    //     contactNumber,
    //     amount,
    //     _instructions,
    //     paymentMethod);
    if (paymentMethod == 'BPI') {
      setState(() {
        channel = 'BPIA';
        _instructions =
            "You will be redirected to the chosen bank's webpage. Login to your Online Banking Account,You will receive a One-Time PIN (OTP) to your registered mobile number. Authorize the payment";
      });
    } else if (paymentMethod == 'Union Bank') {
      setState(() {
        channel = 'UBPB';
        _instructions =
            "You will be redirected to the chosen bank's webpage. Login to your Online Banking Account,You will receive a One-Time PIN (OTP) to your registered mobile number. Authorize the payment";
      });
    } else if (paymentMethod == 'RCBC') {
      setState(() {
        channel = 'RCBC';
        _instructions =
            "You will be redirected to the chosen bank's webpage. Login to your Online Banking Account,You will receive a One-Time PIN (OTP) to your registered mobile number. Authorize the payment";
      });
    } else if (paymentMethod == 'Gcash') {
      setState(() {
        channel = 'gcash';
        _instructions =
            "You will be redirected to the chosen bank's webpage Login to your GCash Account,You will receive a One-Time PIN (OTP) to your registered mobile number. Authorize the payment";
      });
    } else if (paymentMethod == 'Credit/Debit') {
      setState(() {
        channel = 'visamc';
        _instructions =
            "You will be redirected to the Xendit webpage, You will be prompted to enter your Card DetailsYou will receive a One-Time PIN (OTP) to your registered mobile number, Authorize the payment";
      });
    }
    var timeFormat = _time.format(context);
    DateTime today = DateTime.now();
    // print(today.year);
    // print(today.month);
    String? requestID = 'req_' +
        today.year.toString() +
        today.month.toString() +
        today.day.toString() +
        today.hour.toString() +
        today.second.toString() +
        today.millisecond.toString();
    // print(requestID);

    // print('---------------------------$today---------------');
    // print('get data: $_date $_timeController $_time');
    // print('----------------->$timeFormat $paymentMethod');

    try {
      print('------PAYMENT paymentMethod-----------');
      print(paymentMethod);
      if (paymentMethod != null) {
        // setState(() {
        //   isLoading = true;
        // });
        // Apis()
        //     .buxBookRequest(requestID, amount, localDate, description, channel,
        //         email, contactNumber, name, _instructions, paymentMethod)
        //     .then((value) {
        //   print('------PAYMENT URL DUY-----------');
        //   String? paymentUrl = value.data['payment_url'];
        //   print('------$paymentUrl-----------');
        //   setState(() {
        //     isLoading = false;
        //   });
        //   if (value != false) {
        //     WidgetProperties().displayAnimatedDialog(
        //         context,
        //         name,
        //         selectedDate,
        //         description,
        //         email,
        //         contactNumber,
        //         amount,
        //         _instructions,
        //         paymentMethod,
        //         paymentUrl);
        //   } else {
        //     WidgetProperties().invalidDialog(
        //         context,
        //         'Error Processing Request',
        //         'Please check your Internet connection');
        //   }
        // });
      } else {
        print('should display dialog!================+++++');
        WidgetProperties()
            .invalidDialog(
                context, 'Choose Payment', 'Please choose your payment method')
            .then((value) {
          setState(() {
            isLoading = false;
          });
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      WidgetProperties()
          .invalidDialog(context, 'ERROR CREDS', 'Basin wrong chui');
    }
    // setState(() {
    //    = ;
}
