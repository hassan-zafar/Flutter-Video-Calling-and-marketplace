
import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentsModel {
  final String? appointmentId;
  final String? appointmentTitle;
  final String? description;
  final Timestamp? startingTime;
  final Timestamp? endingTime;
  final Timestamp? appointmentDate;

  AppointmentsModel({
    this.appointmentId,
    this.appointmentTitle,
    this.description,
    this.startingTime,
    this.endingTime,
    this.appointmentDate,
  });



  factory AppointmentsModel.fromDocument(doc) {
    return AppointmentsModel(
      appointmentId: doc.data()["appointmentId"],
      appointmentTitle: doc.data()["appointmentTitle"],
      startingTime: doc.data()["startingTime"],
      endingTime: doc.data()["endingTime"],
      appointmentDate: doc.data()["appointmentDate"],
      description: doc.data()["description"],
    );
  }

  AppointmentsModel copyWith({
    String? appointmentId,
    String? appointmentTitle,
    String? description,
    Timestamp? startingTime,
    Timestamp? endingTime,
    Timestamp? appointmentDate,
  }) {
    return AppointmentsModel(
      appointmentId: appointmentId ?? this.appointmentId,
      appointmentTitle: appointmentTitle ?? this.appointmentTitle,
      description: description ?? this.description,
      startingTime: startingTime ?? this.startingTime,
      endingTime: endingTime ?? this.endingTime,
      appointmentDate: appointmentDate ?? this.appointmentDate,
    );
  }



  @override
  String toString() {
    return 'AppointmentsModel(appointmentId: $appointmentId, appointmentTitle: $appointmentTitle, description: $description, startingTime: $startingTime, endingTime: $endingTime, appointmentDate: $appointmentDate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is AppointmentsModel &&
      other.appointmentId == appointmentId &&
      other.appointmentTitle == appointmentTitle &&
      other.description == description &&
      other.startingTime == startingTime &&
      other.endingTime == endingTime &&
      other.appointmentDate == appointmentDate;
  }

  @override
  int get hashCode {
    return appointmentId.hashCode ^
      appointmentTitle.hashCode ^
      description.hashCode ^
      startingTime.hashCode ^
      endingTime.hashCode ^
      appointmentDate.hashCode;
  }
}
