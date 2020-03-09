import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:taxi_assist/service/navigation_service.dart';
import 'package:taxi_assist/ui/views/About.dart';
import 'package:taxi_assist/ui/views/create_post_video_view.dart';
import 'package:taxi_assist/ui/views/create_post_view.dart';
import './ui/views/Home.dart';
import './ui/views/Devices.dart';
import './ui/views/Posts.dart';
import './widgets/fab_with_icons.dart';
import './widgets/fab_bottom_app_bar.dart';
import './widgets/layout.dart';
import 'constants/route_names.dart';
import 'locator.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyHomePageState();
  }
}

class MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  final NavigationService _navigationService = locator<NavigationService>();
  int _selectedTab = 0;
  final _pageOptions = [
    HomePage(),
    DevicesPage(),
    MediaPage(),
    AboutPage(),
    CreatePostView(),
    CreatePostVideoView(),
  ];

  void _selectedFab(int index) {
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          _pageOptions[_selectedTab],
          Container(
            child: Align(
              alignment: Alignment(0.0, 1.0),
              child: Padding(
                padding: EdgeInsets.only(bottom: 20, left: 20, right: 20),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30.0),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: FABBottomAppBar(
        centerItemText: 'Upload',
        backgroundColor: Colors.black,
        color: Colors.yellow,
        selectedColor: Colors.grey,
        notchedShape: CircularNotchedRectangle(),
        onTabSelected: (int index) {
          setState(() {
            _selectedTab = index;
          });
        },
        items: [
          FABBottomAppBarItem(iconData: Icons.home, text: 'Home'),
          FABBottomAppBarItem(iconData: Icons.devices, text: 'Devices'),
          FABBottomAppBarItem(iconData: Icons.perm_media, text: 'Media'),
          FABBottomAppBarItem(iconData: Icons.person_outline, text: 'About'),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _buildFab(context),
    );
  }

  Widget _buildFab(BuildContext context) {
    final icons = [Icons.videocam, Icons.photo];
    return AnchoredOverlay(
      showOverlay: true,
      overlayBuilder: (context, offset) {
        return CenterAbout(
          position: Offset(offset.dx, offset.dy - icons.length * 35.0),
          child: FabWithIcons(
            icons: icons,
            onIconTapped: (index) {
              index == 0 ? _selectedFab(5) : _selectedFab(4);
            },
          ),
        );
      },
      child: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Upload',
        backgroundColor: Colors.amber,
        child: Icon(
          Icons.add,
          color: Colors.amber,
        ),
        elevation: 2.0,
      ),
    );
  }
}
