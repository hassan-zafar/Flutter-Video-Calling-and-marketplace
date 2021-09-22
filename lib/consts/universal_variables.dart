import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';

String appointmentLottie = "assets/lottie/appointment-booking.json";

TextStyle ralewayStyle(double size,
    [Color? color, FontWeight fontWeight = FontWeight.w700]) {
  return GoogleFonts.raleway(
    fontSize: size,
    color: color,
    fontWeight: fontWeight,
  );
}

TextStyle montserratStyle(double size,
    [Color? color, FontWeight fontWeight = FontWeight.w700]) {
  return GoogleFonts.montserrat(
    fontSize: size,
    color: color,
    fontWeight: fontWeight,
  );
}

TextStyle customTextStyle(
    {FontWeight fontWeight = FontWeight.w300,
    double fontSize = 25,
    Color color = Colors.black}) {
  return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: 3);
}

CollectionReference userCollection =
    FirebaseFirestore.instance.collection("users");
