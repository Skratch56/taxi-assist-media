import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taxi_assist/models/post.dart';
import 'package:taxi_assist/models/user.dart';
import 'package:flutter/services.dart';
import 'package:taxi_assist/models/views.dart';

class FirestoreService {
  final CollectionReference _usersCollectionReference =
      Firestore.instance.collection('users');
  final CollectionReference _postsCollectionReference =
      Firestore.instance.collection('posts');
  final CollectionReference _viewsCollectionReference =
      Firestore.instance.collection('views');

  final StreamController<List<Post>> _postsController =
      StreamController<List<Post>>.broadcast();

  Future createUser(User user) async {
    try {
      await _usersCollectionReference.document(user.id).setData(user.toJson());
    } catch (e) {
      // TODO: Find or create a way to repeat error handling without so much repeated code
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }

  Future<String> getDevices() async {
    try {
//      var totalUsers = await _usersCollectionReference.where('userRole', isEqualTo: 'User').getDocuments();
//      return totalUsers.documents.length;
      var respectsQuery =
          _usersCollectionReference.where('userRole', isEqualTo: 'Admin');
      var querySnapshot = await respectsQuery.getDocuments();
      var totalEquals = querySnapshot.documents.length;
      return totalEquals.toString();
    } catch (e) {
      // TODO: Find or create a way to repeat error handling without so much repeated code
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }
  Future<String> getAds() async {
    try {
      var respectsQuery = _postsCollectionReference;
      var querySnapshot = await respectsQuery.getDocuments();
      var totalEquals = querySnapshot.documents.length;
      print('Total ' + totalEquals.toString());
      return totalEquals.toString();
    } catch (e) {
      // TODO: Find or create a way to repeat error handling without so much repeated code
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }
  Future<String> getImageAds() async {
    try {
      var respectsQuery = _postsCollectionReference.where('type', isEqualTo: 'Image');
      var querySnapshot = await respectsQuery.getDocuments();
      var totalEquals = querySnapshot.documents.length;
      print('Total ' + totalEquals.toString());
      return totalEquals.toString();
    } catch (e) {
      // TODO: Find or create a way to repeat error handling without so much repeated code
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }
  Future<String> getVideoAds() async {
    try {
      var respectsQuery = _postsCollectionReference.where('type', isEqualTo: 'Video');
      var querySnapshot = await respectsQuery.getDocuments();
      var totalEquals = querySnapshot.documents.length;
      print('Total ' + totalEquals.toString());
      return totalEquals.toString();
    } catch (e) {
      // TODO: Find or create a way to repeat error handling without so much repeated code
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }

  Future getUser(String uid) async {
    try {
      var userData = await _usersCollectionReference.document(uid).get();
      return User.fromData(userData.data);
    } catch (e) {
      // TODO: Find or create a way to repeat error handling without so much repeated code
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }

  Future getUsers() async {
    try {
      var userDocumentSnapshot = await _usersCollectionReference.getDocuments();
      if (userDocumentSnapshot.documents.isNotEmpty) {
        return userDocumentSnapshot.documents
            .map((snapshot) => User.fromMap(snapshot.data))
            .where((mappedItem) => mappedItem.userRole != null)
            .toList();
      }
    } catch (e) {
      // TODO: Find or create a way to repeat error handling without so much repeated code
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }
  Future addPost(Post post) async {
    try {
      await _postsCollectionReference.add(post.toMap());
    } catch (e) {
      // TODO: Find or create a way to repeat error handling without so much repeated code
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }

  Future addView(View view) async {
    try {
      await _viewsCollectionReference.add(view.toMap());
    } catch (e) {
      // TODO: Find or create a way to repeat error handling without so much repeated code
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }

  Future getPostsOnceOff() async {
    try {
      var postDocumentSnapshot = await _postsCollectionReference.getDocuments();
      if (postDocumentSnapshot.documents.isNotEmpty) {
        return postDocumentSnapshot.documents
            .map((snapshot) => Post.fromMap(snapshot.data, snapshot.documentID))
            .where((mappedItem) => mappedItem.title != null)
            .toList();
      }
    } catch (e) {
      // TODO: Find or create a way to repeat error handling without so much repeated code
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }

  Stream listenToPostsRealTime() {
    // Register the handler for when the posts data changes
    _postsCollectionReference.snapshots().listen((postsSnapshot) {
      if (postsSnapshot.documents.isNotEmpty) {
        var posts = postsSnapshot.documents
            .map((snapshot) => Post.fromMap(snapshot.data, snapshot.documentID))
            .where((mappedItem) => mappedItem.title != null)
            .toList();

        // Add the posts onto the controller
        _postsController.add(posts);
      }
    });

    return _postsController.stream;
  }

  Stream listenToViewsRealTime() {
    // Register the handler for when the views data changes
    _viewsCollectionReference.snapshots().listen((viewsSnapshot) {
      if (viewsSnapshot.documents.isNotEmpty) {
        var views = viewsSnapshot.documents
            .map((snapshot) => Post.fromMap(snapshot.data, snapshot.documentID))
            .where((mappedItem) => mappedItem.title != null)
            .toList();

        // Add the posts onto the controller
        _postsController.add(views);
      }
    });

    return _postsController.stream;
  }

  Future deletePost(String documentId) async {
    await _postsCollectionReference.document(documentId).delete();
  }

  Future updatePost(Post post) async {
    try {
      await _postsCollectionReference
          .document(post.documentId)
          .updateData(post.toMap());
    } catch (e) {
      // TODO: Find or create a way to repeat error handling without so much repeated code
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }
}
