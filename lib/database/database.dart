import 'package:beloved_care/consts/colllections.dart';
import 'package:beloved_care/models/announcementsModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DatabaseMethods {
  // Future<Stream<QuerySnapshot>> getproductData() async {
  //   return FirebaseFirestore.instance.collection(productCollection).snapshots();
  // }

  addAnnouncements(
      {required final String postId,
      required final String announcementTitle,
      required final String imageUrl,
      required final String eachUserId,
      required String eachUserToken,
      required final String description}) async {
    FirebaseFirestore.instance.collection("announcements").doc(postId).set({
      "announcementId": postId,
      "announcementTitle": announcementTitle,
      "description": description,
      "timestamp": DateTime.now(),
      "token": eachUserToken,
      "imageUrl": imageUrl,
    });
  }
  Future fetchAppointmentDataFromFirebase({@required String? uid}) async {
    final QuerySnapshot allAppointmentsSnapshots =
        await appointmentsRef.doc(uid).collection("userAppointments").get();

    return allAppointmentsSnapshots;
  }
  Future getAnnouncements() async {
    List<AnnouncementsModel> tempAllAnnouncements = [];
    QuerySnapshot tempAnnouncementsSnapshot =
        await FirebaseFirestore.instance.collection('announcements').get();
    tempAnnouncementsSnapshot.docs.forEach((element) {
      tempAllAnnouncements.add(AnnouncementsModel.fromDocument(element));
    });
    return tempAllAnnouncements;
  }
}
