import 'package:cloud_firestore/cloud_firestore.dart';

class AnnouncementsModel {
  final String? userId;
  final String? announcementId;
  final String? announcementTitle;
  final String? description;
  final Timestamp? timestamp;
  final String? token;
  final String? imageUrl;

  AnnouncementsModel({
    this.userId,
    this.announcementId,
    this.announcementTitle,
    this.description,
    this.timestamp,
    this.token,
    this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {};
  }

  factory AnnouncementsModel.fromDocument(doc) {
    return AnnouncementsModel(
      userId: doc.data()["userId"],
      announcementId: doc.data()["announcementId"],
      announcementTitle: doc.data()["announcementTitle"],
      description: doc.data()["description"],
      timestamp: doc.data()["timestamp"],
      token: doc.data()["token"],
      imageUrl: doc.data()["imageUrl"],
    );
  }
}
