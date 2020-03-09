import 'package:flutter/material.dart';
import 'package:taxi_assist/service/firestore_service.dart';
import 'package:taxi_assist/viewmodels/base_model.dart';
import '../locator.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() {
    return new HomeState();
  }
}

class HomeState extends State<Home> {
  final FirestoreService _firestoreService = locator<FirestoreService>();
  var totalDevices;
  String _totalAds = "";
  String _totalDevices = "";

  HomeState() {
    getTextFromFile().then((val) => setState(() {
          _totalDevices = val;
        }));
    getTextFromFile2().then((val) => setState(() {
      _totalAds = val;
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              home_widget(
                  'assets/tablet.jpg',
                  'Devices',
                  '\$1,145,126',
                  _totalDevices + ' Devices',
                  'assets/device.png',
                  'Pool',
                  'assets/pool.png',
                  'Wi-Fi',
                  'assets/wifi.jpg'),
              // House Photo from https://unsplash.com/photos/XtnNrQYC7ts
              home_widget(
                  'assets/advert.jpg',
                  'Adverts',
                  '\$500',
                  _totalAds + ' Media',
                  'assets/media.png',
                  'TV',
                  'assets/tv.png',
                  'Animals allowed',
                  'assets/animal.png'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              home_widget2(
                  'assets/location.jpg',
                  'Location',
                  '\$640',
                  '3 locations',
                  'assets/location.png',
                  'Pool',
                  'assets/kc.png',
                  'Wi-Fi',
                  'assets/wifi.jpg'),
              home_widget2(
                  'assets/playback.jpg',
                  'Playback',
                  '\$12,800,000',
                  '4 Plays',
                  'assets/play.png',
                  'Wi-Fi',
                  'assets/play.png',
                  'Garage',
                  'assets/garage.png'),
            ],
          ),
        ],
      ),
    );
  }

  Widget home_widget(
    String imageurl,
    String place,
    String price,
    String no1,
    String no1Url,
    String no2,
    String no2Url,
    String no3,
    String no3Url,
  ) {
    return Padding(
      padding: EdgeInsets.only(top: 20, bottom: 20),
      child: Container(
        height: 320 / 2,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.0)),
              elevation: 4.0,
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        height: 200 / 2,
                        width: 350 / 2,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(6),
                            topRight: Radius.circular(6),
                          ),
                          child: Image.asset(
                            imageurl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 8.0,
                        right: 6.0,
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(3.0)),
                          child: Padding(
                            padding: EdgeInsets.all(5.0),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 8.0,
                        left: 6.0,
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(3.0)),
                          child: Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text(
                              place,
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xff1089ff),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 7.0),
                  Padding(
                    padding: EdgeInsets.only(top: 10, left: 12, right: 12),
                    child: Container(
                        width: 300 / 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(
                                  no1,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Image.asset(
                                  no1Url,
                                  fit: BoxFit.contain,
                                  height: 45.0 / 2,
                                  width: 45.0 / 2,
                                ),
                              ],
                            ),
                          ],
                        )),
                  ),
                  SizedBox(height: 10.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget home_widget2(
    String imageurl,
    String place,
    String price,
    String no1,
    String no1Url,
    String no2,
    String no2Url,
    String no3,
    String no3Url,
  ) {
    return Padding(
      padding: EdgeInsets.only(top: 20, bottom: 20),
      child: Container(
        height: 320 / 2,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.0)),
              elevation: 4.0,
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        height: 200 / 2,
                        width: 350 / 2,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(6),
                            topRight: Radius.circular(6),
                          ),
                          child: Image.asset(
                            imageurl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 8.0,
                        right: 6.0,
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(3.0)),
                          child: Padding(
                            padding: EdgeInsets.all(5.0),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 8.0,
                        left: 6.0,
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(3.0)),
                          child: Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text(
                              place,
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xff1089ff),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 7.0),
                  Padding(
                    padding: EdgeInsets.only(top: 10, left: 12, right: 12),
                    child: Container(
                        width: 300 / 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(
                                  no1,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Image.asset(
                                  no1Url,
                                  fit: BoxFit.contain,
                                  height: 45.0 / 2,
                                  width: 45.0 / 2,
                                ),
                              ],
                            ),
                          ],
                        )),
                  ),
                  SizedBox(height: 10.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<String> getTextFromFile() async {
    return _firestoreService.getDevices();
  }
  Future<String> getTextFromFile2() async {
    return _firestoreService.getAds();
  }
}
