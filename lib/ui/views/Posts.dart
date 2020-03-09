import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:taxi_assist/models/post.dart';
import 'package:taxi_assist/service/authentication_service.dart';
import 'package:taxi_assist/service/firestore_service.dart';
import 'package:taxi_assist/utils/SharedObjects.dart';
import 'package:taxi_assist/widgets/chewie_list_item.dart';
import 'package:video_player/video_player.dart';

import '../../locator.dart';

class MediaPage extends StatefulWidget {
  Color _iconColor = Colors.white;

  @override
  State<StatefulWidget> createState() {
    return MediaPageState();
  }
}

class MediaPageState extends State<MediaPage> {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  ChewieController _chewieController;
  final FirestoreService _firestoreService = locator<FirestoreService>();
  List<Post> _posts = new List<Post>();
  var totalImageAds;
  var totalVideoAds;
  List<Post> _imagePosts, _videoPosts;
  List<File> _videoFiles;
  MediaPageState() {
    getTextFromFile().then((val) => setState(() {
          _posts = val;
          _imagePosts = new List<Post>();
          _videoPosts = new List<Post>();
          _videoFiles = new List<File>();
          if (_posts != null) {
            for (int x = 0; x < _posts.length; x++) {
              _posts[x].type == 'Image'
                  ? _imagePosts.add(_posts[x])
                  : _videoPosts.add(_posts[x]);
            }
          }
        }));
    getImageAds().then((val) => setState(() {
          totalImageAds = val;
        }));
    getVideoAds().then((val) => setState(() {
          totalVideoAds = val;
        }));

  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text('Media'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                _authenticationService.handleSignOut();
              },
            )
          ],
          bottom: TabBar(
            tabs: [
              Tab(text: totalImageAds.toString(), icon: Icon(Icons.image)),
              Tab(text: totalVideoAds.toString(), icon: Icon(Icons.videocam)),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        body: TabBarView(
          children: [
            Tab(
              child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemCount: _imagePosts.length,
                  itemBuilder: (BuildContext context, int index) {
                    Post _postNow = _imagePosts[index];
                    return Container(
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: <Widget>[
                          FadeInImage.assetNetwork(
                            image: _postNow.imageUrl.toString(),
                            placeholder: 'assets/media.png',
                            fit: BoxFit.cover,
                            width: 200,
                            height: 200,
                          )
                        ],
                      ),
                    );
                  }),
            ),
            Tab(child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: _videoPosts.length,
                itemBuilder: (BuildContext context, int index) {
                  Post _postNow = _videoPosts[index];
                  return Container(
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: <Widget>[
                        ChewieListItem(
                          videoPlayerController: VideoPlayerController.network(
                            _postNow.imageUrl.toString(),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> getTextFromFile() async {
    return _firestoreService.getPostsOnceOff();
  }

  Future<String> getImageAds() async {
    return _firestoreService.getImageAds();
  }

  Future<String> getVideoAds() async {
    return _firestoreService.getVideoAds();
  }

  Future<File> getFutureData(String videoUrl, String filename) async {
    return await SharedObjects.getThumbnail2(videoUrl, filename);
  }
}
