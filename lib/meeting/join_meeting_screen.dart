import "package:flutter/material.dart";
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:jitsi_meet/feature_flag/feature_flag.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'package:beloved_care/consts/colors.dart';
import 'package:beloved_care/consts/universal_variables.dart';
import 'package:uuid/uuid.dart';

// ignore: must_be_immutable
class JoinMeetingScreen extends StatefulWidget {
  bool? isJoinMeeting;
  JoinMeetingScreen({
    this.isJoinMeeting,
  });
  @override
  _JoinMeetingScreenState createState() => _JoinMeetingScreenState();
}

class _JoinMeetingScreenState extends State<JoinMeetingScreen> {
  TextEditingController _controller = TextEditingController();
  TextEditingController roomController = TextEditingController();
  bool isVideoOff = true;
  bool isAudioMuted = true;
  String name = "";
  bool isData = false;
  String code = "";

  @override
  void initState() {
    super.initState();
    getData();
  }

  generateMeetingCode() {
    setState(() {
      code = Uuid().v1().substring(0, 6);
    });
  }

  getData() async {
    var uid = FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot data = await userCollection.doc(uid).get();
    setState(() {
      name = data["name"];
      isData = true;
    });
  }

  _joinMeeting() async {
    try {
      widget.isJoinMeeting! ? null : generateMeetingCode();
      FeatureFlag featureFlag = FeatureFlag();
      featureFlag.welcomePageEnabled = false;
      featureFlag.resolution = FeatureFlagVideoResolution
          .HD_RESOLUTION; // Limit video resolution to 360p

      var options = JitsiMeetingOptions(
              room: widget.isJoinMeeting! ? roomController.text : code)
            // Required, spaces will be trimmed
            // ..serverURL = "https://someHost.com"
            // ..subject = "Meeting with Gunschu"
            ..userDisplayName = _controller.text
            // ..userEmail = "myemail@email.com"
            // ..userAvatarURL = us // or .png
            ..audioOnly = true
            ..audioMuted = true
            ..videoMuted = true
          // ..featureFlag = featureFlag
          ;

      await JitsiMeet.joinMeeting(options);
    } catch (error) {
      debugPrint("error: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: backgroundColorBoxDecoration(),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 24,
                  ),
                  widget.isJoinMeeting!
                      ? Text(
                          "Room Code",
                          style: ralewayStyle(20),
                        )
                      : Container(),
                  widget.isJoinMeeting!
                      ? SizedBox(
                          height: 20,
                        )
                      : Container(),
                  widget.isJoinMeeting!
                      ? PinCodeTextField(
                          controller: roomController,
                          backgroundColor: Colors.transparent,
                          appContext: context,
                          autoDisposeControllers: false,
                          length: 6,
                          onChanged: (value) {},
                          animationType: AnimationType.fade,
                          pinTheme:
                              PinTheme(shape: PinCodeFieldShape.underline),
                          animationDuration: Duration(microseconds: 300),
                        )
                      : Container(),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _controller,
                    style: montserratStyle(20),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText:
                          "Username(this will be visible in the meeting)",
                      labelStyle: ralewayStyle(15),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  CheckboxListTile(
                    value: isVideoOff,
                    onChanged: (val) {
                      setState(() {
                        isVideoOff = val!;
                      });
                    },
                    title: Text(
                      "Video Off",
                      style: ralewayStyle(18, Colors.black),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  CheckboxListTile(
                    value: isAudioMuted,
                    onChanged: (val) {
                      setState(() {
                        isAudioMuted = val!;
                      });
                    },
                    title: Text(
                      "Audio Muted",
                      style: ralewayStyle(18, Colors.black),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "You can change these settings in your meeting when you join",
                    style: ralewayStyle(15),
                    textAlign: TextAlign.center,
                  ),
                  Divider(
                    height: 48,
                    thickness: 2.0,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    onTap: _joinMeeting,
                    child: Container(
                      width: double.maxFinite,
                      height: 64,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                          colors: GradientColors.amour,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          widget.isJoinMeeting!
                              ? "Join Meeting"
                              : "Create Meeting",
                          style: montserratStyle(20, Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
