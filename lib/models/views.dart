import 'package:flutter/foundation.dart';

class View {
  final String longitude;
  final String latitude;
  final String postId;
  final String documentId;

  View({
    @required this.postId,
    @required this.longitude,
    @required this.latitude,
    this.documentId,
  });

  Map<String, dynamic> toMap() {
    return {
      'postId': postId,
      'longitude': longitude,
      'latitude': latitude,
    };
  }

  static View fromMap(Map<String, dynamic> map, String documentId) {
    if (map == null) return null;

    return View(
      longitude: map['longitude'],
      latitude: map['latitude'],
      postId: map['postId'],
      documentId: documentId,
    );
  }
}
