import 'package:cached_network_image/cached_network_image.dart';
import 'package:story_view/story_view.dart';
import 'package:taxi_assist/models/post.dart';
import 'package:taxi_assist/models/views.dart';
import 'package:taxi_assist/service/authentication_service.dart';
import 'package:taxi_assist/service/firestore_service.dart';
import 'package:taxi_assist/ui/shared/ui_helpers.dart';
import 'package:taxi_assist/widgets/post_item.dart';
import 'package:taxi_assist/viewmodels/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';

import '../../locator.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final storyController = StoryController();
  final FirestoreService _firestoreService = locator<FirestoreService>();
  @override
  void dispose() {
    storyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AuthenticationService _authenticationService =
        locator<AuthenticationService>();
    var count = 0;

    return ViewModelProvider<HomeViewModel>.withConsumer(
        viewModel: HomeViewModel(),
        onModelReady: (model) => model.listenToPosts(),
        builder: (context, model, child) => Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                centerTitle: true,
                title: Text('Home'),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.exit_to_app),
                    onPressed: () {
                      _authenticationService.handleSignOut();
                    },
                  )
                ],
              ),
              backgroundColor: Colors.white,
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    verticalSpace(5),
                    Expanded(
                        child: model.posts != null
                            ? Container(
                                child: StoryView(
                                  [
                                    for (int x = 0; x < model.posts.length; x++)
                                      (model.posts[x].type == 'Image')
                                          ? (StoryItem.pageImage(
                                              NetworkImage(
                                                  model.posts[x].imageUrl),
                                              caption: model.posts[x].title
                                                  .toString(),
                                              shown: true,

                                            ))
                                          : (StoryItem.pageVideo(
                                              model.posts[x].imageUrl,
                                              caption: model.posts[x].title
                                                  .toString(),
                                              controller: storyController,
                                              shown: true,
                                              duration: Duration(seconds: 30)))
                                  ],
                                  onStoryShow: (s) {

                                    print("Showing a story");
                                  },
                                  onComplete: () {
                                    print("Completed a cycle");
                                  },
                                  progressPosition: ProgressPosition.bottom,
                                  repeat: true,
                                  controller: storyController,
                                ),
                              )
                            : Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation(
                                      Theme.of(context).primaryColor),
                                ),
                              ))
                  ],
                ),
              ),
            ));
  }
//  Future addView(View view) async {
//    var result = await _firestoreService.addView(addView(
//      longitude: longitude,
//      latitude: latitude,
//      postId: postId,
//      documentId: documentId,));
//  }
}
