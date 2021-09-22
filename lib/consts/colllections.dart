import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
// import 'package:the_learning_castle_v2/models/users.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
// firebase_storage.FirebaseStorage storageRef =
//     firebase_storage.FirebaseStorage.instance;
final userRef = FirebaseFirestore.instance.collection('users');
final Reference storageRef = FirebaseStorage.instance.ref();
final calenderRef = FirebaseFirestore.instance.collection('calenderMeetings');
final appointmentsRef = FirebaseFirestore.instance.collection('appointments');
final commentsRef = FirebaseFirestore.instance.collection('comments');
final announcementsRef = FirebaseFirestore.instance.collection('announcements');

final feeRef = FirebaseFirestore.instance.collection('feeRef');

// AppUserModel? currentUser;
bool? isAdmin;
bool? isTeacher;

String dateTimeScript =
    "${DateTime.now().day} : ${DateTime.now().month} : ${DateTime.now().year}";
