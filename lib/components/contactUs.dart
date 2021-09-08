import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUs extends StatelessWidget {
  ContactUs({Key? key}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    final screen_size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Contact Us'),
      ),
      body: Container(
        child: SingleChildScrollView(
            child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                height: 200,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/brand/highlight/siargao_island.jpg'),
                      fit: BoxFit.fill,
                    ),
                    border: Border.all(color: Colors.black54)),
              ),
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
                style: TextStyle(letterSpacing: 1, fontSize: 18, height: 2),
              ),
              Text(
                'Tel: +6391-7657-0045',
                textAlign: TextAlign.center,
                style: TextStyle(letterSpacing: 1, fontSize: 18, height: 2),
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
                        style: TextStyle(fontSize: 20.0, color: Colors.black54),
                      )
                    ],
                  ),
                  style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.all(20.0),
                      side: BorderSide(color: Colors.blue),
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
              )
            ],
          ),
        )),
      ),
    );
  }
}
