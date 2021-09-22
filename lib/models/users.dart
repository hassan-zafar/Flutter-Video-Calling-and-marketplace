import 'dart:convert';

class AppUserModel {
  final String? id;
  final String? name;
  final String? phoneNumber;
  final String? password;
  final String? joinedAt;
  final bool? isAdmin;
  final String? email;
  final String? imageUrl;
  final String? androidNotificationToken;

  // final Map? sectionsAppointed;
  AppUserModel(
      {this.id,
      this.name,
      this.phoneNumber,
      this.password,
      this.joinedAt,
      this.isAdmin,
      this.email,
      this.imageUrl,
      this.androidNotificationToken});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userName': name,
      'phoneNo': phoneNumber,
      'password': password,
      'timestamp': joinedAt,
      'isAdmin': isAdmin,
      'email': email,
      'photoUrl': imageUrl,
      'androidNotificationToken': androidNotificationToken,
    };
  }

  factory AppUserModel.fromMap(Map<String, dynamic> map) {
    return AppUserModel(
      id: map['id'],
      name: map['userName'],
      phoneNumber: map['phoneNo'],
      password: map['password'],
      joinedAt: map['timestamp'],
      isAdmin: map['isAdmin'],
      email: map['email'],
      imageUrl: map['photoUrl'],
      androidNotificationToken: map['androidNotificationToken'],
    );
  }

  factory AppUserModel.fromDocument(doc) {
    return AppUserModel(
      id: doc.data()["id"],
      password: doc.data()["password"],
      name: doc.data()["name"],
      joinedAt: doc.data()["joinedAt"],
      email: doc.data()["email"],
      isAdmin: doc.data()["isAdmin"],
      phoneNumber: doc.data()["phoneNumber"],
      imageUrl: doc.data()["imageUrl"],
      androidNotificationToken: doc.data()["androidNotificationToken"],
    );
  }

  String toJson() => json.encode(toMap());

  factory AppUserModel.fromJson(String source) =>
      AppUserModel.fromMap(json.decode(source));
}
