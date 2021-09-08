import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class FaqPage extends StatelessWidget {
  FaqPage({Key? key}) : super(key: key);

  TextStyle textStyle = TextStyle(
    fontSize: 15.0,
    fontStyle: FontStyle.italic,
    color: Colors.black87,
  );

  TextStyle titleFontStyle = TextStyle(
    fontSize: 15.0,
    fontWeight: FontWeight.bold,
    decorationStyle: TextDecorationStyle.wavy,
  );

  @override
  Widget build(BuildContext context) {
    final screen_size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('FAQ'),
      ),
      body: displayDetails(screen_size),
    );
  }

  displayDetails(screen_size) {
    return SingleChildScrollView(
        child: Center(
      child: Container(
        width: screen_size.width * 0.95,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    const ListTile(
                        title: Text(
                            'I can’t upload my CV to my file. What’s wrong?',
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              decorationStyle: TextDecorationStyle.wavy,
                            )),
                        subtitle: Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: ReadMoreText(
                            'The database will only accept WORD, PDF, or JPG files less than 1MB in size. Usually, if you are having trouble uploading a file, it is because it is too large. Try resizing your photo as a JPG and then re-pasting it to your CV. If you don’t know how to do this, give us a call or send us an email, and we will help.',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Colors.black87,
                                fontStyle: FontStyle.italic),
                            trimLines: 3,
                            colorClickableText: Colors.teal,
                            trimMode: TrimMode.Line,
                            trimCollapsedText: 'Show more',
                            trimExpandedText: 'Show less',
                            moreStyle:
                                TextStyle(fontSize: 14, color: Colors.teal),
                          ),
                        )),
                    SizedBox(
                      height: 30,
                    ),
                    const ListTile(
                        title: Text(
                            'I only have paper copies of my certificates. How can I add them to my file?',
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              decorationStyle: TextDecorationStyle.wavy,
                            )),
                        subtitle: Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: ReadMoreText(
                            'You will need to scan your certificates into WORD, PDF, or JPG files in order to upload them. If you are unable to do this, bring the copies to your interview, and a crew agent will help you.',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Colors.black87,
                                fontStyle: FontStyle.italic),
                            trimLines: 3,
                            colorClickableText: Colors.teal,
                            trimMode: TrimMode.Line,
                            trimCollapsedText: 'Show more',
                            trimExpandedText: 'Show less',
                            moreStyle:
                                TextStyle(fontSize: 14, color: Colors.teal),
                          ),
                        )),
                    SizedBox(
                      height: 30,
                    ),
                    const ListTile(
                        title: Text(
                            'I am planning on taking some courses and will be available next year. When should I register?',
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              decorationStyle: TextDecorationStyle.wavy,
                            )),
                        subtitle: Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: ReadMoreText(
                            'You can register at any time, but it is best to contact us no more than 2 to 4 weeks before you are available to start work. The positions that we have are generally for an immediate start, so it is best for you to interview when the positions will be relevant.',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Colors.black87,
                                fontStyle: FontStyle.italic),
                            trimLines: 3,
                            colorClickableText: Colors.teal,
                            trimMode: TrimMode.Line,
                            trimCollapsedText: 'Show more',
                            trimExpandedText: 'Show less',
                            moreStyle:
                                TextStyle(fontSize: 14, color: Colors.teal),
                          ),
                        )),
                    SizedBox(
                      height: 30,
                    ),
                    const ListTile(
                        title: Text('How long will my registration last?',
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              decorationStyle: TextDecorationStyle.wavy,
                            )),
                        subtitle: Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: ReadMoreText(
                            'Your file will remain on our system as long as you want it to. When you get a job, we will deactivate your file. This will also happen automatically if you stop checking in. As soon as you tell us you are looking for work again, we will reactivate your file and start looking out for you immediately',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Colors.black87,
                                fontStyle: FontStyle.italic),
                            trimLines: 3,
                            colorClickableText: Colors.teal,
                            trimMode: TrimMode.Line,
                            trimCollapsedText: 'Show more',
                            trimExpandedText: 'Show less',
                            moreStyle:
                                TextStyle(fontSize: 14, color: Colors.teal),
                          ),
                        )),
                    SizedBox(
                      height: 30,
                    ),
                    const ListTile(
                        title: Text(
                            'I am unable to come to Cannes. Do you interview in other Camper and Nicholsons offices?',
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              decorationStyle: TextDecorationStyle.wavy,
                            )),
                        subtitle: Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: ReadMoreText(
                            'No. Unfortunately, we only conduct interviews in Cannes. However, during the Caribbean season and in certain other cases, we will schedule telephone interviews.',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Colors.black87,
                                fontStyle: FontStyle.italic),
                            trimLines: 3,
                            colorClickableText: Colors.teal,
                            trimMode: TrimMode.Line,
                            trimCollapsedText: 'Show more',
                            trimExpandedText: 'Show less',
                            moreStyle:
                                TextStyle(fontSize: 14, color: Colors.teal),
                          ),
                        )),
                    SizedBox(
                      height: 30,
                    ),
                    const ListTile(
                        title: Text(
                            'Do I need to make an appointment for an interview?',
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              decorationStyle: TextDecorationStyle.wavy,
                            )),
                        subtitle: Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: ReadMoreText(
                            'It is important to us that we interview every candidate personally, and we want to see as many people as possible each day. This is why we do not schedule interviews. Our doors are open to crew from Monday to Thursday, 9:30am to noon. Please stop by during those hours and we will be happy to meet with you to discuss what you are looking for. Please make sure that at this time that your file is up to date and your CV is current. Beware that during the busy seasons, the waiting room fills up fast!',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Colors.black87,
                                fontStyle: FontStyle.italic),
                            trimLines: 3,
                            colorClickableText: Colors.teal,
                            trimMode: TrimMode.Line,
                            trimCollapsedText: 'Show more',
                            trimExpandedText: 'Show less',
                            moreStyle:
                                TextStyle(fontSize: 14, color: Colors.teal),
                          ),
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
