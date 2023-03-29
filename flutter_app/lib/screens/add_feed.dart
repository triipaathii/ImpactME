import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:badges/badges.dart' as badges;

import '../widgets/snackbar.dart';

class AddFeed extends StatefulWidget {
  const AddFeed({super.key});

  @override
  State<AddFeed> createState() => _AddFeedState();
}

class _AddFeedState extends State<AddFeed> {
  XFile? userImage;
  String? profilePhotoPath;
  final ImagePicker _picker = ImagePicker();

  Future<void> _getImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
      );
      if (pickedFile != null) {
        setState(() {
          userImage = pickedFile;
        });
      }
    } catch (e) {
      showSnackBar(e.toString(), context, Colors.redAccent.shade400);
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff243b55),
        body: Column(
          children: [
            SizedBox(
              height: height * 0.075,
              width: width,
            ),
            Text(
              "ADD A NEW FEED",
              style: GoogleFonts.raleway(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  letterSpacing: 5),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 3,
                    width: width * 0.175,
                    color: Colors.white,
                  ),
                  const Text(
                    "   X   ",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    height: 3,
                    width: width * 0.175,
                    color: Colors.white,
                  )
                ],
              ),
            ),
            SizedBox(
              height: height * 0.05,
            ),
            badges.Badge(
              showBadge:
                  userImage == null && profilePhotoPath == null ? false : true,
              badgeStyle: badges.BadgeStyle(
                badgeColor: Colors.redAccent.shade400,
                padding: EdgeInsets.all(2),
              ),
              badgeContent: Icon(
                Icons.cancel_outlined,
                color: Colors.white,
              ),
              position: badges.BadgePosition.topEnd(end: 0),
              onTap: () {
                setState(() {
                  userImage = null;
                });
              },
              child: Container(
                  height: height * 0.3,
                  width: width * 0.9,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.grey.shade600,
                        width: 5,
                      )),
                  child: userImage == null
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Text(
                                "SELECT FROM",
                                style: GoogleFonts.raleway(),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.015,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: Color(0xff243b55),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: IconButton(
                                      onPressed: () {
                                        _getImage(ImageSource.camera);
                                      },
                                      icon: Icon(
                                        Icons.camera_alt_rounded,
                                        color: Colors.white,
                                      )),
                                ),
                                SizedBox(
                                  width: width * 0.02,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Color(0xff243b55),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: IconButton(
                                      onPressed: () {
                                        _getImage(ImageSource.gallery);
                                      },
                                      icon: Icon(
                                        Icons.image_rounded,
                                        color: Colors.white,
                                      )),
                                )
                              ],
                            ),
                          ],
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.file(
                            File(userImage!.path),
                            fit: BoxFit.cover,
                            height: height * 0.3 - 10,
                            width: width * 0.9 - 10,
                          ),
                        )),
            )
          ],
        ),
      ),
    );
  }
}
