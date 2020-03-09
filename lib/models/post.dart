import 'package:flutter/foundation.dart';

class Post {
  final String title;
  final String imageUrl;
  final String userId;
  final String documentId;
  final String imageFileName;
  final String type;

  Post({
    @required this.userId,
    @required this.title,
    this.documentId,
    this.imageUrl,
    this.imageFileName,
    this.type,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'title': title,
      'imageUrl': imageUrl,
      'imageFileName': imageFileName,
      'type': type,
    };
  }

  static Post fromMap(Map<String, dynamic> map, String documentId) {
    if (map == null) return null;

    return Post(
      title: map['title'],
      imageUrl: map['imageUrl'],
      userId: map['userId'],
      imageFileName: map['imageFileName'],
      type: map['type'],
      documentId: documentId,
    );
  }
}
