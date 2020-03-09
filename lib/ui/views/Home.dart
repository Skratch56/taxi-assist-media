import 'package:flutter/material.dart';
import 'package:taxi_assist/service/authentication_service.dart';
import 'package:taxi_assist/widgets/home.dart';

import '../../locator.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  final AuthenticationService _authenticationService =
  locator<AuthenticationService>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text('Home'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {_authenticationService.handleSignOut();},
            )
          ],
        ),
        body: ListView(
          children: <Widget>[
            SizedBox(height: 0),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Home(),
            ),
            SizedBox(height: 140),
          ],
        ));
  }
}
