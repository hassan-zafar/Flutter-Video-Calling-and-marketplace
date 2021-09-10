import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';

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

CollectionReference userCollection =
    FirebaseFirestore.instance.collection("users");
