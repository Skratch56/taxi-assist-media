import 'package:flutter/material.dart';
import 'package:taxi_assist/models/user.dart';
import 'package:taxi_assist/service/firestore_service.dart';

import '../locator.dart';
class Device extends StatefulWidget {
  @override
  DeviceState createState() {
    return new DeviceState();
  }
}
class DeviceState extends State<Device>{
  final FirestoreService _firestoreService = locator<FirestoreService>();
  List<User> _users = new List<User>();
  DeviceState() {
    getTextFromFile().then((val) => setState(() {
      _users = val;
    }));
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 30),
        for (int x = 0; x < _users.length; x++ )
          recent_msg(
              'assets/device.png', _users[x].fullName, _users[x].email, '1 view'),

        // Photo from https://unsplash.com/photos/Q9L-n57IqLw
      ],
    );
  }

  Widget contacts(
    String imageurl,
    String name,
  ) {
    return Padding(
      padding: EdgeInsets.only(left: 14, right: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            radius: 10.0,
            backgroundImage: AssetImage(imageurl),
            backgroundColor: Colors.transparent,
          ),
          SizedBox(height: 20),
          Text(
            name,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget recent_msg(
    String imageurl,
    String name,
    String msg,
    String time,
  ) {
    return Padding(
      padding: EdgeInsets.only(bottom: 30, left: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              CircleAvatar(
                radius: 32.0,
                backgroundImage: AssetImage(imageurl),
                backgroundColor: Colors.transparent,
              ),
              SizedBox(width: 14),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    name,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Container(
                    width: 200,
                    child: Text(
                      msg,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                          fontSize: 16),
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              )
            ],
          ),
          Column(
            children: <Widget>[
              Text(
                time,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                    fontSize: 12),
              ),
              SizedBox(height: 38)
            ],
          )
        ],
      ),
    );
  }
  Future<dynamic> getTextFromFile() async {
    return _firestoreService.getUsers();
  }
}
