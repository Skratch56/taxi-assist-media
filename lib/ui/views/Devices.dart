import 'package:flutter/material.dart';
import 'package:taxi_assist/service/authentication_service.dart';
import 'package:taxi_assist/widgets/devices.dart';

import '../../locator.dart';

class DevicesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DevicesPageState();
  }
}

class DevicesPageState extends State<DevicesPage> {
  final AuthenticationService _authenticationService =
  locator<AuthenticationService>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text('Devices'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {_authenticationService.handleSignOut();},
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: ListView(
          children: <Widget>[
            SizedBox(height: 10),
            Device(),
            SizedBox(height: 100),
          ],
        ));
  }
}
