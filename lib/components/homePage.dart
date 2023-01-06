import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:readmore/readmore.dart';
import 'package:moonpath/widgets/calendar.dart';
import 'package:moonpath/widgets/image_carousel.dart';
import 'package:moonpath/widgets/video_background.dart';
import 'package:moonpath/components/faq.dart';
import 'package:moonpath/components/login.dart';
import 'package:moonpath/components/bookClient.dart';
import 'package:moonpath/widgets/widgetProperties.dart';
import 'package:moonpath/components/admin/homePage.dart';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:url_launcher/url_launcher.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

User? user;
bool? isLoading = false;

final String lat = '9.848349546224208';
final String long = '126.04584151732028';

Future<void> _launchInWebViewOrVC(String url) async {
  if (await canLaunch(url)) {
    await launch(url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': "my_header_value"});
  } else {
    throw 'Could not launch $url';
  }
}

_launchMap() async {
  final String googleMapsUrl = "comgooglemaps://?center=$lat,$long";
  final String appleMapsUrl = "https://maps.apple.com/?q=$lat,$long";

  if (await canLaunch(googleMapsUrl)) {
    await launch(googleMapsUrl);
  }
  if (await canLaunch(appleMapsUrl)) {
    await launch(appleMapsUrl, forceSafariVC: false);
  } else {
    throw "Couldn't launch URL";
  }
}

_launchEmail() async {
  launch("mailto:moonpathtravel@yahoo.com?subject=Moonpath query&body=");
}

class _HomepageState extends State<Homepage> {
  Future getUser() async {
    FirebaseAuth.instance.authStateChanges().listen((User? checkUser) {
      user = checkUser;
      if (user == null) {
        print('User not logged in!');
      } else {
        print('--------------------------
        print('User signed in!');
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => AdminHomePage()),
          (Route<dynamic> route) => false,
        );
      }
    });
  }

  Future<void> initConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      print('-----CONNECTED MOBLE DATA-----');
    } else if (connectivityResult == ConnectivityResult.wifi) {
      print('----------CONNECTED WIFI NETWORK--------');
    } else {}
  }

  @override
  void initState() {
    super.initState();
    initConnectivity();

    isLoading = true;
    getUser();
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading == true) {
      return WidgetProperties().loadingProgress(context);
    } else {
      return displayHomePage(context);
    }
  }

  Widget displayHomePage(BuildContext context) {
    final screen_size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/yacht/images/sailing_boat.jpg'),
                      fit: BoxFit.fill),
                ),
                child: Container(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "Moonpath travel and tours",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: Colors.white),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.info_outline),
                title: const Text('About Us'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              Divider(
                height: 2,
                color: Colors.grey,
              ),
              ListTile(
                leading: Icon(Icons.question_answer),
                title: const Text('FAQ'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => FaqPage()));
                },
              ),
              Divider(
                height: 2,
                color: Colors.grey,
              ),
              ListTile(
                leading: Icon(Icons.contact_phone),
                title: const Text('Book now'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => BookPage()));
                },
              ),
              Divider(
                height: 2,
                color: Colors.grey,
              ),
              ListTile(
                leading: Icon(Icons.calendar_today),
                title: const Text('Calendar'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CalendarScreen()));
                },
              ),
              Divider(
                height: 2,
                color: Colors.grey,
              ),
              ListTile(
                leading: Icon(Icons.login),
                title: const Text('Login'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
              ),
              Divider(
                height: 2,
                color: Colors.grey,
              ),
            ],
          ),
        ),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
                pinned: true,
                snap: false,
                floating: true,
                expandedHeight: 200.0,
                flexibleSpace: const FlexibleSpaceBar(
                  title: Text(
                    "Moonpath travel and tours",
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'LobsterTwo',
                    ),
                  ),
                  background: VideoBackground(),
                )),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 30,
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset("assets/yacht/images/icon-sample.jpg"),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: screen_size.width * 0.85,
                    child: Center(
                      child: Text(
                        "Moonpath is an established name in Philippines yacht sales offering the largest fleet from leading yacht builders in Europe. From ordering to delivery to after sales service, we are committed to making sure you enjoy the yachting lifestyle.",
                        textAlign: TextAlign.center,
                        style: TextStyle(height: 1.5),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ImageCarouselBanner(),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'Moonpath Ph',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 40, fontFamily: 'Pacifico'),
                  ),
                  Container(
                    width: screen_size.width * 0.85,
                    child: Text(
                      "Purok 1 San Jose roxas isabela 3320 philippines Ilagan, Philippines",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontFamily: 'Raleway', fontSize: 15),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'Tel: +6396-7259-9889',
                    textAlign: TextAlign.center,
                    style: TextStyle(letterSpacing: 1, height: 2),
                  ),
                  Text(
                    'Tel: +6391-7657-0045',
                    textAlign: TextAlign.center,
                    style: TextStyle(letterSpacing: 1, height: 2),
                  ),
                  TextButton(
                    child: Text(
                      'Email: moonpathtravel@yahoo.com',
                      textAlign: TextAlign.center,
                      textWidthBasis: TextWidthBasis.longestLine,
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          letterSpacing: 1,
                          fontSize: 13,
                          height: 2),
                    ),
                    onPressed: () {
                      _launchEmail();
                    },
                  ),
                  Container(
                    width: screen_size.width * 0.70,
                    child: OutlinedButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.map_rounded),
                          Text(
                            '  Open Map',
                            style: TextStyle(
                                fontSize: 20.0, color: Colors.black54),
                          )
                        ],
                      ),
                      style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.all(20.0),
                          side: BorderSide(color: Colors.black87),
                          // minimumSize: Size(30, 20),
                          backgroundColor: Colors.white70),
                      onPressed: () {
                        _launchMap();
                      },
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    // mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      IconButton(
                        iconSize: 70.0,
                        color: Colors.blue,
                        icon: Icon(Icons.facebook_sharp),
                        onPressed: () {
                          _launchInWebViewOrVC(
                              'https://www.facebook.com/Moonpath-travel-and-tours-103570147872534');
                        },
                      ),
                      IconButton(
                        iconSize: 70.0,
                        icon: Image.asset('assets/logo/instagram.jpg'),
                        onPressed: () {
                          _launchInWebViewOrVC(
                              'https://www.instagram.com/moonp_ath/');
                        },
                      ),
                      IconButton(
                        iconSize: 60.0,
                        icon: Image.asset('assets/logo/youtube.png'),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                      height: 50,
                      child: Container(
                        width: screen_size.width * 0.80,
                        child: Center(
                          child: Container(
                            child: Text(
                              "Fellow Sailor share their amazing experiences",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0),
                            ),
                          ),
                        ),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    const ListTile(
                      leading: CircleAvatar(
                        radius: 20,
                        backgroundImage:
                            AssetImage('assets/brand/person/person3.jpg'),
                      ),
                      title: Text('John Doe'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 10, right: 15, left: 15),
                      child: ReadMoreText(
                        'This was amazing! The boat was in a perfect condition. Nico is a very nice guy, he helped us so good and made the whole experience better. I definitely recommend doing this. We had some troubles with the weather but Nico helped us trough it.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black87, fontStyle: FontStyle.italic),
                        trimLines: 3,
                        colorClickableText: Colors.teal,
                        trimMode: TrimMode.Line,
                        trimCollapsedText: 'Show more',
                        trimExpandedText: 'Show less',
                        moreStyle: TextStyle(fontSize: 14, color: Colors.teal),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SliverToBoxAdapter(
                // child: SizedBox(
                //   height: 20,
                // ),
                ),
            SliverToBoxAdapter(
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const ListTile(
                      leading: CircleAvatar(
                        radius: 20,
                        backgroundImage:
                            AssetImage('assets/brand/person/person1.jpg'),
                      ),
                      title: Text('Yuni'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 10, right: 15, left: 15),
                      child: ReadMoreText(
                        'Luigi and his partner were awesome hosts. They came to pick us up in Ischia and gave us a special half day tour. His response time is instantaneous - I made a booking literally 2 hours before I arrived in Ischia! He took us to a special underwater cave, a volcanic ocean spa, and even rescued me in a little boat when I had a mini panic attack in the water. Thank you to Luigi for showing us the islands of Napoli from a different perspective.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black87, fontStyle: FontStyle.italic),
                        trimLines: 3,
                        colorClickableText: Colors.teal,
                        trimMode: TrimMode.Line,
                        trimCollapsedText: 'Show more',
                        trimExpandedText: 'Show less',
                        moreStyle: TextStyle(fontSize: 14, color: Colors.teal),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SliverToBoxAdapter(
                // child: SizedBox(
                //   height: 20,
                // ),
                ),
            SliverToBoxAdapter(
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const ListTile(
                      leading: CircleAvatar(
                        radius: 20,
                        backgroundImage:
                            AssetImage('assets/brand/person/person2.jpg'),
                      ),
                      title: Text('Julian'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 10, right: 15, left: 15),
                      child: ReadMoreText(
                        'Great boat, everything worked as installed (bilge pump, safety equipment, shower) or was provided upon request (handheld VHF, children lifejacket). Friendly service, everything was straightforward. Even the ropes were neatly stored. Will repeat.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black87, fontStyle: FontStyle.italic),
                        trimLines: 3,
                        colorClickableText: Colors.teal,
                        trimMode: TrimMode.Line,
                        trimCollapsedText: 'Show more',
                        trimExpandedText: 'Show less',
                        moreStyle: TextStyle(fontSize: 14, color: Colors.teal),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const ListTile(
                      leading: CircleAvatar(
                        radius: 20,
                        backgroundImage:
                            AssetImage('assets/brand/person/person4.jpg'),
                      ),
                      title: Text('Christoph'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 10, right: 15, left: 15),
                      child: ReadMoreText(
                        'Francesco is a great captain and host. Even before our journey started he excelled with his weather insights, recommendations for the best day to travel and he was very flexible to allow us to take off at the best moment: Sun and Wind where ideal for our trip to Favignana and Levanzo. From entering the boat till goodbye the trip was a day to remember. The whole family enjoyed the beautiful places with pristine water francesco took us to and at every place there was a little specialty to experience that Francesco drew our attention to. Franceso provided us with cold drinks, a SUP and snorkeling equiptment to get the best experience on and under the water. We saw many small and medium fish and beautiful seabeds with patches of sand, rocks and seaweeds which gave the water all different shades of blue . For lunch we followed his recommendation for a restaurant on levanzo and had a great meal with vegetables, pasta, shrimp and various kinds of fish including a whole „orata“ which was served freshly grilled and very tasty. The whole lunch we enjoyed the view on the bay of levanzo. After lunch we continued exploring beaches and bays on levanzo and favingana in the setting sun.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black87, fontStyle: FontStyle.italic),
                        trimLines: 3,
                        colorClickableText: Colors.teal,
                        trimMode: TrimMode.Line,
                        trimCollapsedText: 'Show more',
                        trimExpandedText: 'Show less',
                        moreStyle: TextStyle(fontSize: 14, color: Colors.teal),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 20,
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 50,
                child: Center(
                  child: Text('Copyright @2021, All Rights Reserved'),
                ),
              ),
            ),
          ],
        ),
        // bottomNavigationBar: BottomAppBar(
        //   child: Padding(
        //     padding: const EdgeInsets.all(8),
        //     child: OverflowBar(
        //       overflowAlignment: OverflowBarAlignment.center,
        //       children: <Widget>[
        //         Row(
        //           mainAxisSize: MainAxisSize.min,
        //           children: <Widget>[
        //             const Text('pinned'),
        //             Switch(
        //               onChanged: (bool val) {
        //                 setState(() {
        //                   _pinned = val;
        //                 });
        //               },
        //               value: _pinned,
        //             ),
        //           ],
        //         ),
        //         Row(
        //           mainAxisSize: MainAxisSize.min,
        //           children: <Widget>[
        //             const Text('snap'),
        //             Switch(
        //               onChanged: (bool val) {
        //                 setState(() {
        //                   _snap = val;
        //                   _floating = _floating || _snap;
        //                 });
        //               },
        //               value: _snap,
        //             )
        //           ],
        //         ),
        //         Row(
        //           mainAxisSize: MainAxisSize.min,
        //           children: <Widget>[
        //             const Text('floating'),
        //             Switch(
        //               onChanged: (bool val) {
        //                 setState(() {
        //                   _floating = val;
        //                   _snap = _snap && _floating;
        //                 });
        //               },
        //               value: _floating,
        //             ),
        //           ],
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
      ),
    );
  }
}
