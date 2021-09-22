import 'dart:io';
import 'package:beloved_care/consts/colors.dart';
import 'package:beloved_care/widget/loading.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:beloved_care/database/database.dart';
import 'package:beloved_care/services/notificationHandler.dart';
import 'package:uuid/uuid.dart';
import 'package:image/image.dart' as Im;
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';

class AddAnnouncements extends StatefulWidget {
  @override
  _AddAnnouncementsState createState() => _AddAnnouncementsState();
}

class _AddAnnouncementsState extends State<AddAnnouncements> {
  final TextEditingController _titleTextController = TextEditingController();
  String postId = Uuid().v4();
  bool isUploading = false;
  final TextEditingController _descriptionTextController =
      TextEditingController();
  File? file;
  bool _isLoading = false;
  final _textFormkey = GlobalKey<FormState>();
  ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: backgroundColorBoxDecoration(),
        child: Stack(
          children: [
            Scaffold(
              appBar: AppBar(
                title: Text("Add Announcements"),
                backgroundColor: Colors.transparent,
                centerTitle: true,
                elevation: 0,
                actions: [
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    // ignore: deprecated_member_use
                    child: RaisedButton.icon(
                      onPressed: () {
                        buildMediaDialog(context);
                      },
                      icon: Icon(
                        Icons.add,
                        size: 20.0,
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0))),
                      label: Text(
                        'Add Media',
                        style: TextStyle(fontSize: 10.0),
                      ),
                    ),
                  )
                ],
              ),
              body: SingleChildScrollView(
                controller: _scrollController,
                child: Form(
                  key: _textFormkey,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GlassContainer(
                            child: TextFormField(
                              controller: _titleTextController,
                              validator: (val) => val!.trim().length < 3
                                  ? 'Announcement Title Too Short'
                                  : null,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Enter title of announcement",
                                  labelText: "Title"),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GlassContainer(
                            child: TextFormField(
                              controller: _descriptionTextController,
                              validator: (val) => val!.trim().length < 3
                                  ? 'Announcement Description Title Too Short'
                                  : null,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Enter Description of announcement",
                                  labelText: "Description"),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25.0,
                        ),
                        GestureDetector(
                          onTap: () => handleSubmit(),
                          child: GlassContainer(
                            child: Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: Row(
                                children: [
                                  Icon(Icons.send_outlined),
                                  Text("Send Announcement"),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            _isLoading ? LoadingIndicator() : Container()
          ],
        ),
      ),
    );
  }

  compressImage() async {
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    Im.Image? imageFile = Im.decodeImage(file!.readAsBytesSync());
    final compressedImageFile = File('$path/img_$postId.jpg')
      ..writeAsBytesSync(Im.encodeJpg(imageFile!, quality: 85));
    setState(() {
      file = compressedImageFile;
    });
  }

  handleImageFromGallery() async {
    Navigator.pop(context);
    var picker = await ImagePicker().getImage(source: ImageSource.gallery);
    File file;
    file = File(picker!.path);
    setState(() {
      this.file = file;
    });
  }

  Future<String> uploadImage(imageFile) async {
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('posts/$postId.jpg');
    UploadTask uploadTask = firebaseStorageRef.putFile(imageFile);
    // storageRef.child("post_$postId.jpg").putFile(imageFile);
    // TaskSnapshot storageSnap = await uploadTask.onComplete;
    // String downloadUrl = await storageSnap.ref.getDownloadURL();
    // return downloadUrl;

    String? downloadUrl;
    await uploadTask.whenComplete(() async {
      downloadUrl = await firebaseStorageRef.getDownloadURL();
    });
    // uploadTask.then((res) async {
    //   downloadUrl = await res.ref.getDownloadURL();
    // });
    return downloadUrl!;
  }

  createPostInFirestore({
    final String? announcementTitle,
    final String? description,
    final String? imageUrl,
    final String? eachUserToken,
    final String? eachUserId,
  }) async {
    return DatabaseMethods().addAnnouncements(
        description: description!,
        imageUrl: imageUrl!,
        eachUserToken: eachUserToken!,
        eachUserId: eachUserId!,
        announcementTitle: announcementTitle!,
        postId: postId);
  }

  handleSubmit() async {
    final _form = _textFormkey.currentState;
    if (_form!.validate()) {
      setState(() {
        isUploading = true;
      });
      _scrollController.animateTo(0.0,
          duration: Duration(milliseconds: 600), curve: Curves.easeOut);
      // ignore: unnecessary_statements
      file != null ? await compressImage() : null;
      String imageUrl = file != null
          ? await uploadImage(file).catchError((onError) {
              isUploading = false;
              BotToast.showText(text: "Couldn't connect to servers!!");
            })
          : "";
      allUsersList.forEach((e) async {
        await createPostInFirestore(
            announcementTitle: _titleTextController.text,
            imageUrl: imageUrl,
            eachUserId: e.id,
            eachUserToken: e.androidNotificationToken,
            description: _descriptionTextController.text);
        sendAndRetrieveMessage(
            token: e.androidNotificationToken!,
            message: _descriptionTextController.text,
            context: context,
            imageUrl: imageUrl,
            title: _titleTextController.text);
      });

      _descriptionTextController.clear();
      _titleTextController.clear();
      setState(() {
        isUploading = false;
        postId = Uuid().v4();
      });

      Navigator.pop(context);
    }
    BotToast.showText(text: "Announcement Added");
  }

  buildMediaDialog(BuildContext parentContext) {
    return showDialog(
        context: parentContext,
        builder: (context) {
          return SimpleDialog(
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  //Navigator.pop(context);
                  handleImageFromGallery();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.image),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Upload Image',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SimpleDialogOption(
                onPressed: () => Navigator.pop(context),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      child: Row(
                    children: [
                      Icon(Icons.exit_to_app),
                      SizedBox(
                        width: 5,
                      ),
                      Text('Cancel'),
                    ],
                  )),
                ),
              )
            ],
          );
        });
  }
}
