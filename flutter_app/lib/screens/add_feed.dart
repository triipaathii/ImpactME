import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_state_city_pro/country_state_city_pro.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:badges/badges.dart' as badges;
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/snackbar.dart';

class AddFeed extends StatefulWidget {
  const AddFeed({super.key});

  @override
  State<AddFeed> createState() => _AddFeedState();
}

class _AddFeedState extends State<AddFeed> {
  XFile? userImage;
  String? feedImagePath;
  String? userId;
  final ImagePicker _picker = ImagePicker();

  bool isLoading = false;

  final db = FirebaseFirestore.instance;
  final descriptionController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final countryController = TextEditingController();

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

  Future<void> _uploadFeedImage() async {
    final storage = FirebaseStorage.instance.ref("feeds/");
    try {
      await storage.putFile(File(userImage!.path));
      final getUrl = await storage.getDownloadURL();
      setState(() {
        feedImagePath = getUrl;
      });
      print(feedImagePath);
    } catch (e) {
      showSnackBar(e.toString(), context, Colors.redAccent.shade400);
    }
  }

  Future<void> _loadUserId() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = (prefs.getString('userId') ?? null);
    });
  }

  @override
  void initState() {
    super.initState();
    _loadUserId();
    
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff243b55),
        floatingActionButton: FloatingActionButton(
          onPressed: isLoading
              ? null
              : () {
                  if (userImage == null) {
                    showSnackBar(
                        "Select a photo", context, Colors.redAccent.shade400);
                  } else if (descriptionController.text.isEmpty) {
                    showSnackBar("Enter some description", context,
                        Colors.redAccent.shade400);
                  } else if (cityController.text.isEmpty) {
                    showSnackBar(
                        "Select location", context, Colors.redAccent.shade400);
                  } else {
                    setState(() {
                      isLoading = true;
                    });
                    _uploadFeedImage().then((_) async {
                      await db.collection("feeds").add({
                        'userId': userId,
                        'feed_image_path': feedImagePath,
                        'location': {
                          'country': countryController.text,
                          'state': stateController.text,
                          'city': cityController.text
                        },
                        'description': descriptionController.text,
                        // 'timestamp': FieldValue.serverTimestamp()
                      }).then((DocumentReference doc) async {
                        print('DocumentSnapshot added with ID: ${doc.id}');

                        Navigator.pop(context);
                      });
                    });
                  }
                },
          elevation: 10,
          backgroundColor: Colors.grey.withOpacity(0.5),
          child: isLoading
              ? CircularProgressIndicator(
                  color: Color(0xff243b55),
                  backgroundColor: Colors.white,
                )
              : Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(200),
                      border: Border.all(color: Color(0xff243b55), width: 3)),
                  child: Icon(
                    Icons.add,
                    color: Color(0xff243b55),
                    semanticLabel: "Add a new feed",
                  ),
                ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: height * 0.07,
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
                showBadge: userImage == null ? false : true,
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
                                  "CLICK/SELECT IMAGE FROM",
                                  style: GoogleFonts.raleway(),
                                ),
                              ),
                              SizedBox(
                                height: height * 0.03,
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
              ),
              SizedBox(
                height: height * 0.05,
              ),
              Text(
                "ADD DESCRIPTION",
                style: GoogleFonts.raleway(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Container(
                width: width * 0.9,
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.05, vertical: height * 0.005),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.grey.shade600,
                      width: 5,
                    )),
                child: TextFormField(
                  controller: descriptionController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  maxLength: 500,
                  cursorColor: Color(0xff243b55),
                  style: GoogleFonts.raleway(),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter your feed description here...",
                      hintStyle:
                          GoogleFonts.raleway(fontStyle: FontStyle.italic)),
                ),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              Text(
                "CHOOSE LOCATION",
                style: GoogleFonts.raleway(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      useSafeArea: true,
                      backgroundColor: Color(0xff243b55),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                      context: context,
                      builder: (BuildContext context) {
                        return Column(
                          children: [
                            SizedBox(
                              height: height * 0.055,
                            ),
                            Icon(
                              Icons.location_on_rounded,
                              color: Colors.white,
                              size: 50,
                            ),
                            SizedBox(
                              height: height * 0.015,
                            ),
                            Text(
                              "SELECT LOCATION",
                              style: GoogleFonts.raleway(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            CountryStateCityPicker(
                                country: countryController,
                                state: stateController,
                                city: cityController)
                          ],
                        );
                      });
                },
                child: Container(
                    width: width * 0.9,
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.05, vertical: height * 0.0175),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.grey.shade600,
                          width: 5,
                        )),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.location_on_rounded,
                          color: Color(0xff243b55),
                        ),
                        Text(
                          cityController.text.isEmpty
                              ? "Not yet selected"
                              : "  ${cityController.text}, ${stateController.text}, ${countryController.text}",
                          style: GoogleFonts.raleway(),
                        )
                      ],
                    )),
              ),
              SizedBox(
                height: height * 0.02,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
