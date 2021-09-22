import 'package:beloved_care/consts/colors.dart';
import 'package:beloved_care/consts/universal_variables.dart';
import "package:flutter/material.dart";
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:uuid/uuid.dart';

class CreateMeeetingScreen extends StatefulWidget {
  @override
  _CreateMeeetingScreenState createState() => _CreateMeeetingScreenState();
}

class _CreateMeeetingScreenState extends State<CreateMeeetingScreen> {
  String code = "";
  var isVis = false;

  generateMeetingCode() {
    setState(() {
      code = Uuid().v1().substring(0, 6);
      isVis = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: backgroundColorBoxDecoration(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Text(
                "Create a code to create a meeting!",
                style: montserratStyle(20),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            isVis == true
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Code: ",
                        style: ralewayStyle(30),
                      ),
                      Text(
                        code,
                        style: montserratStyle(30, Colors.red, FontWeight.w700),
                      ),
                    ],
                  )
                : Container(),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: generateMeetingCode,
              child: Container(
                width: MediaQuery.of(context).size.width / 2,
                height: 50,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: GradientColors.facebookMessenger,
                  ),
                ),
                child: Center(
                  child: Text(
                    "Create Code",
                    style: montserratStyle(20, Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
