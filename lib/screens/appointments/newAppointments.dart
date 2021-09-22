import 'package:beloved_care/consts/colllections.dart';
import 'package:beloved_care/consts/colors.dart';
import 'package:beloved_care/widget/loading.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

import 'package:uuid/uuid.dart';

class NewAppointments extends StatefulWidget {
  @override
  _NewAppointmentsState createState() => _NewAppointmentsState();
}

class _NewAppointmentsState extends State<NewAppointments> {
  final _textFormkey = GlobalKey<FormState>();
  String postId = Uuid().v4();
   DateTime? appointmentDate;
  bool isUploading = false;
   String? postTitle, postDescription, postSubheading, videoLink;
  ScrollController _scrollController = ScrollController();
  TextEditingController _appointmentTitleController = TextEditingController();
  TextEditingController _appointmentDescriptionController =
      TextEditingController();
  // TextEditingController _postSubHeadController = TextEditingController();
   TimeOfDay? startingTime;
   TimeOfDay? endingTime;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: backgroundColorBoxDecoration(),
      child: Scaffold(
        body: WillPopScope(
          onWillPop: _onBackPressed,
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                isUploading ? LoadingIndicator() : Text(""),
                Form(
                    key: _textFormkey,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 25.0,
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 18.0, right: 18.0),
                          child: TextFormField(
                            onSaved: (val) => postTitle = val!,
                            validator: (val) => val!.trim().length < 3
                                ? 'Appointment Title Too Short'
                                : null,
                            controller: _appointmentTitleController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  // borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                  ),
                              labelText: "Appointment Title",
                              hintText: "Min length 3",
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25.0,
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 18.0, right: 18.0),
                          child: TextFormField(
                            onSaved: (val) => postDescription = val!,
                            validator: (val) => val!.trim().length < 1
                                ? 'Please add Appointment description'
                                : null,
                            controller: _appointmentDescriptionController,
                            maxLines: 7,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Appointment Description",
                              hintText: "Add description of this Post",
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25.0,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            DateTime? appointmentDateTemp = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2022, 1, 1, 1));
                            setState(() {
                              this.appointmentDate = appointmentDateTemp!;
                            });
                          },
                          child: Text(
                            appointmentDate == null
                              ? "Select appointment Date"
                              :
                               "${appointmentDate!.day} - ${appointmentDate!.month} - ${appointmentDate!.year}"
                              ""
                               ),
                        ),
                        SizedBox(
                          height: 25.0,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            TimeOfDay? startingTimeTemp = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                                helpText: "Select Appointment Starting Time");
                            setState(() {
                              this.startingTime = startingTimeTemp!;
                            });
                            print(startingTime);
                          },
                          child: Text(startingTime == null
                              ? "Select Appointment Starting Time"
                              : startingTime!.format(context)),
                        ),
                        SizedBox(
                          height: 25.0,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            var endingTimeTemp = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                                helpText: "Select Appointment Ending Time");
                            setState(() {
                              this.endingTime = endingTimeTemp!;
                            });
                          },
                          child: Text(endingTime == null
                              ? "Select Event Ending Time"
                              : endingTime!.format(context)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: ElevatedButton(
                            onPressed:
                                isUploading ? null : () => handleSubmit(),
                            child: Text(
                              'Add Appointment',
                              style: TextStyle(fontSize: 20.0),
                            ),
                          ),
                        )
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  createAppointmentInFirestore({
    String? appointmentTitle,
    String? appointmentId,
    String? description,
    DateTime? timestamp,
    DateTime? startingTime,
    DateTime? endingTime,
  }) {
    timestamp = DateTime.now();
    appointmentsRef
        .doc(currentUser!.id)
        .collection("userAppointments")
        .doc(appointmentId)
        .set({
      "appointmentId": appointmentId,
      "appointmentTitle": appointmentTitle,
      "appointmentDate": appointmentDate,
      "description": description,
      "timestamp": timestamp,
      "startingTime": startingTime,
      "endingTime": endingTime,
    });
  }

  handleSubmit() async {
    final _form = _textFormkey.currentState;
    if (startingTime != null && endingTime != null && appointmentDate != null) {
      if (_form!.validate()) {
        setState(() {
          isUploading = true;
        });
        _scrollController.animateTo(0.0,
            duration: Duration(milliseconds: 600), curve: Curves.easeOut);
        // ignore: unnecessary_statements

        await createAppointmentInFirestore(
          appointmentId: postId,
          appointmentTitle: _appointmentTitleController.text,
          description: _appointmentDescriptionController.text,
          startingTime: DateTime(appointmentDate!.year, appointmentDate!.month,
              appointmentDate!.day, startingTime!.hour, startingTime!.minute, 0),
          endingTime: DateTime(appointmentDate!.year, appointmentDate!.month,
              appointmentDate!.day, endingTime!.hour, endingTime!.minute, 0),
        );
        _appointmentTitleController.clear();
        _appointmentDescriptionController.clear();
        setState(() {
          isUploading = false;
          postId = Uuid().v4();
        });
        Navigator.pop(context);
        BotToast.showText(text: "Appointment Added");
      }
    } else if (appointmentDate == null) {
      BotToast.showText(text: "Appointment Date must be selected");
    } else if (startingTime == null) {
      BotToast.showText(text: "Appointment Starting time must be selected");
    } else if (endingTime == null) {
      BotToast.showText(text: "Appointment Ending time must be selected");
    }
  }

  Future<bool> _onBackPressed() async {
    isUploading
        ? BotToast.showText(
            text: "Sorry can't go back as appointmnet is being added")
        : Navigator.of(context).pop();
     return true;
  }
}
