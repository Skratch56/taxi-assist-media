import 'dart:io';
import 'dart:typed_data';

import 'package:taxi_assist/models/post.dart';
import 'package:taxi_assist/service/authentication_service.dart';
import 'package:taxi_assist/ui/shared/ui_helpers.dart';
import 'package:taxi_assist/widgets/input_field.dart';
import 'package:taxi_assist/viewmodels//create_post_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';
import '../../locator.dart';

class CreatePostVideoView extends StatelessWidget {
  final titleController = TextEditingController();
  final Post edittingPost;


  CreatePostVideoView({Key key, this.edittingPost}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthenticationService _authenticationService =
        locator<AuthenticationService>();
    return ViewModelProvider<CreatePostViewModel>.withConsumer(
      viewModel: CreatePostViewModel(),
      onModelReady: (model) {
        // update the text in the controller
        titleController.text = edittingPost?.title ?? '';

        model.setEdittingPost(edittingPost);
      },
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
          floatingActionButton: FloatingActionButton(
            child: !model.busy
                ? Icon(Icons.file_upload)
                : CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                  ),
            onPressed: () {
              if (!model.busy) {
                model.addPost(title: titleController.text);
              }
            },
            backgroundColor:
                !model.busy ? Theme.of(context).primaryColor : Colors.grey[600],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                verticalSpace(40),
                Text(
                  'Create Post',
                  style: TextStyle(fontSize: 26),
                ),
                verticalSpaceMedium,
                InputField(
                  placeholder: 'Title',
                  controller: titleController,
                ),
                verticalSpaceMedium,
                Text('Post Video'),
                verticalSpaceSmall,
                GestureDetector(
                  // When we tap we call selectImage
                  onTap: () => model.selectVideo(),
                  child: Container(
                    height: 250,
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10)),
                    alignment: Alignment.center,
                    // If the selected image is null we show "Tap to add post image"

                    child: model.selectedVideo == null
                        ? Text(
                            'Tap to add post video',
                            style: TextStyle(color: Colors.grey[400]),
                          )
                        // If we have a selected image we want to show it
                        : Image.file(model.videoThumb, fit: BoxFit.cover,),
                  ),
                )
              ],
            ),
          )),
    );
  }


}
