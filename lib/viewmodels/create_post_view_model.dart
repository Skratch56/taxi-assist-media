import 'dart:io';
import 'dart:typed_data';

import 'package:taxi_assist/constants/route_names.dart';
import 'package:taxi_assist/locator.dart';
import 'package:taxi_assist/models/post.dart';
import 'package:taxi_assist/service/cloud_storage_service.dart';
import 'package:taxi_assist/service/dialog_service.dart';
import 'package:taxi_assist/service/firestore_service.dart';
import 'package:taxi_assist/service/navigation_service.dart';
import 'package:taxi_assist/utils/SharedObjects.dart';
import 'package:taxi_assist/utils/image_selector.dart';
import 'package:taxi_assist/viewmodels/base_model.dart';
import 'package:flutter/foundation.dart';

class CreatePostViewModel extends BaseModel {
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final ImageSelector _imageSelector = locator<ImageSelector>();
  final CloudStorageService _cloudStorageService =
      locator<CloudStorageService>();

  File _selectedImage;
  File _selectedVideo;
  File videoThumb;

  File get selectedImage => _selectedImage;

  File get selectedVideo => _selectedVideo;

  Post _edittingPost;
  bool isImage = true;

  bool get _editting => _edittingPost != null;

  Future selectImage() async {
    var tempImage = await _imageSelector.selectImage();
    if (tempImage != null) {
      _selectedImage = tempImage;
      isImage = true;
      notifyListeners();
    }
  }

  Future selectVideo() async {
    var tempVideo = await _imageSelector.selectVideo();
    if (tempVideo != null) {
      _selectedVideo = tempVideo;
      isImage = false;
      print(tempVideo.path);
      videoThumb = await SharedObjects.getThumbnail(tempVideo.path);
      notifyListeners();
    }
  }

  Future addPost({@required String title}) async {
    setBusy(true);

    CloudStorageResult storageResult;

    if (!_editting && isImage) {
      storageResult = await _cloudStorageService.uploadImage(
        imageToUpload: _selectedImage,
        title: title,
      );
    } else if (!_editting && !isImage) {
      storageResult = await _cloudStorageService.uploadImage(
        imageToUpload: _selectedVideo,
        title: title,
      );
    }

    var result;

    if (!_editting && isImage) {
      result = await _firestoreService.addPost(Post(
          title: title,
          userId: currentUser.id,
          imageUrl: storageResult.imageUrl,
          imageFileName: storageResult.imageFileName,
          type: 'Image',));
    } else if (!_editting && !isImage) {
      result = await _firestoreService.addPost(Post(
          title: title,
          userId: currentUser.id,
          imageUrl: storageResult.imageUrl,
          imageFileName: storageResult.imageFileName,
          type: 'Video'));
    } else {
      result = await _firestoreService.updatePost(Post(
          title: title,
          userId: _edittingPost.userId,
          documentId: _edittingPost.documentId,
          imageUrl: _edittingPost.imageUrl,
          imageFileName: _edittingPost.imageFileName,
          type: 'Image',));
    }

    setBusy(false);

    if (result is String) {
      await _dialogService.showDialog(
        title: 'Cound not create post',
        description: result,
      );
    } else {
      await _dialogService.showDialog(
        title: 'Post successfully Added',
        description: 'Your post has been created',
      );
    }
    _navigationService.pop();
    _navigationService.navigateTo(ActivityViewRoute);
  }

  void setEdittingPost(Post edittingPost) {
    _edittingPost = edittingPost;
  }
}
