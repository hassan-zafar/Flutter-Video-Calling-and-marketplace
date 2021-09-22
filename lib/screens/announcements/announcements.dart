import 'package:beloved_care/consts/colllections.dart';
import 'package:beloved_care/consts/colors.dart';
import 'package:beloved_care/widget/loading.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:beloved_care/database/database.dart';
import 'package:beloved_care/models/announcementsModel.dart';

import '../../consts/universal_variables.dart';
import 'addAnnouncements.dart';

class Announcements extends StatefulWidget {
  static const routeName = '/Announcements';

  @override
  _AnnouncementsState createState() => _AnnouncementsState();
}

class _AnnouncementsState extends State<Announcements> {
  List<AnnouncementsModel> allAnnouncements = [];
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    getAnnouncements();
  }

  getAnnouncements() async {
    setState(() {
      _isLoading = true;
      this.allAnnouncements = [];
    });
    List<AnnouncementsModel> allAnnouncements =
        await DatabaseMethods().getAnnouncements();
    setState(() {
      this.allAnnouncements = allAnnouncements;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: backgroundColorBoxDecoration(),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddAnnouncements()))
              .then((value) => getAnnouncements()),
          child: Icon(Icons.add),
          tooltip: "Add New Announcement",
        ),
        body: ListView(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          children: [
            Center(
              child: Text(
                "Updates",
                style: ralewayStyle(20),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: GestureDetector(
                    onLongPress: () {
                      return isAdmin!
                          ? deleteNotification(
                              context, allAnnouncements[index].announcementId!)
                          : null;
                    },
                    child: _isLoading
                        ? LoadingIndicator()
                        : GlassContainer(
                            opacity: 0.6,
                            shadowStrength: 16,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment:
                                    allAnnouncements[index].imageUrl != null
                                        ? CrossAxisAlignment.center
                                        : CrossAxisAlignment.start,
                                children: [
                                  allAnnouncements[index].imageUrl != null
                                      ? CachedNetworkImage(
                                          imageUrl:
                                              allAnnouncements[index].imageUrl!)
                                      : Container(),
                                  Text(
                                    allAnnouncements[index].announcementTitle!,
                                    style: customTextStyle(),
                                  ),
                                  Text(
                                    allAnnouncements[index].description!,
                                    style: customTextStyle(fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                          ),
                  ),
                );
              },
              itemCount: allAnnouncements.length,
            ),
          ],
        ),
      ),
    );
  }

  deleteNotification(BuildContext parentContext, String id) {
    return showDialog(
        context: parentContext,
        builder: (context) {
          return SimpleDialog(
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  //TODO:fix this

                  // allUsersList.forEach((e) {
                  //   announcementsRef
                  //       .doc(e.id)
                  //       .collection("userAnnouncements")
                  //       .doc(id)
                  //       .delete();
                  // });
                  getAnnouncements();
                  Navigator.pop(context);
                },
                child: Text(
                  'Delete Announcement',
                ),
              ),
              SimpleDialogOption(
                onPressed: () => Navigator.pop(context),
                child: Text('Cancel'),
              )
            ],
          );
        });
  }
}
