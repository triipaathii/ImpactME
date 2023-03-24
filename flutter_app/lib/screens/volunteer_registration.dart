import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/providers/courses_provider.dart';
import 'package:flutter_app/screens/volunteer_approval.dart';
import 'package:flutter_app/widgets/snackbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VolunteerRegistration extends StatefulWidget {
  final courses;
  VolunteerRegistration({super.key, this.courses});

  @override
  State<VolunteerRegistration> createState() => _VolunteerRegistrationState();
}

class _VolunteerRegistrationState extends State<VolunteerRegistration> {
  final db = FirebaseFirestore.instance;
  List<XFile>? userImage;
  String? _retrieveDataError;

  final ImagePicker _picker = ImagePicker();

  void _setImageFileListFromFile(XFile? value) {
    userImage = value == null ? null : <XFile>[value];
  }

  dynamic _pickImageError;

  Future<void> _getPhoto(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
      );
      setState(() {
        _setImageFileListFromFile(pickedFile);
      });
    } catch (e) {
      setState(() {
        _pickImageError = e;
      });
    }
  }

  Text? _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError!);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await _picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        if (response.files == null) {
          _setImageFileListFromFile(response.file);
        } else {
          userImage = response.files;
        }
      });
    } else {
      _retrieveDataError = response.exception!.code;
    }
  }

  final userEmailAddressController = TextEditingController();
  final userQualificationController = TextEditingController();
  final userOrganizationController = TextEditingController();

  List<Map<String, dynamic>> userSkills = [];
  List<String> userLanguages = [];

  String? userId;
  bool? isVolunteer;

  final totalLanguages = [
    "Assamese",
    "Bangla",
    "Bodo",
    "Dogri",
    "English",
    "Gujarati",
    "Hindi",
    "Kashmiri",
    "Kannada",
    "Konkani",
    "Maithili",
    "Malayalam",
    "Manipuri",
    "Marathi",
    "Nepali",
    "Oriya",
    "Punjabi",
    "Tamil",
    "Telugu",
    "Santali",
    "Sindhi",
    "Urdu"
  ];

  late List<bool> skillsSelected = [];
  List<bool> languageSelected = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];

  bool isLoading = false;

  Widget _previewImages() {
    final Text? retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (userImage != null) {
      return Semantics(
        label: 'image_picker_example_picked_images',
        child: ListView.builder(
          key: UniqueKey(),
          itemBuilder: (BuildContext context, int index) {
            // Why network for web?
            // See https://pub.dev/packages/image_picker#getting-ready-for-the-web-platform
            return Semantics(
              label: 'image_picker_example_picked_image',
              child: Image.file(File(userImage![index].path)),
            );
          },
          itemCount: userImage!.length,
        ),
      );
    } else if (_pickImageError != null) {
      return Text(
        'Pick image error: $_pickImageError',
        textAlign: TextAlign.center,
      );
    } else {
      return const Text(
        'You have not yet picked an image.',
        textAlign: TextAlign.center,
      );
    }
  }

  Future<void> _loadUserId() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = (prefs.getString('userId') ?? null);
      isVolunteer = (prefs.getBool('isVolunteer') ?? null);
    });
  }

  Future<void> _updateVolunteerStatus(bool status) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isVolunteer', status);
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
    final courses = Provider.of<CourseProvider>(context, listen: false).courses;

    for (var course in courses) {
      skillsSelected.add(false);
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(
                  color: Color(0xff243b55),
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: height * 0.1,
                      width: width,
                    ),
                    Center(
                      child: CircleAvatar(
                          radius: height * 0.1,
                          backgroundColor: Color(0xff243b55),
                          backgroundImage: AssetImage("assets/images/man.png")),
                    ),
                    // if (userImage != null) Image.file(File(userImage!.path)),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    if (userImage == null) _previewImages(),
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
                                _getPhoto(ImageSource.camera);
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
                                _getPhoto(ImageSource.gallery);
                              },
                              icon: Icon(
                                Icons.image_rounded,
                                color: Colors.white,
                              )),
                        )
                      ],
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    Text(
                      "BASIC DETAILS",
                      style: GoogleFonts.raleway(
                          color: const Color(0xff243b55),
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
                            color: const Color(0xff243b55),
                          ),
                          const Text(
                            "   X   ",
                            style: TextStyle(
                              color: Color(0xff243b55),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            height: 3,
                            width: width * 0.175,
                            color: const Color(0xff243b55),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      width: width * 0.8,
                      child: TextFormField(
                        controller: userEmailAddressController,
                        style: GoogleFonts.raleway(fontSize: 18),
                        keyboardType: TextInputType.emailAddress,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                            labelText: "Email Address",
                            labelStyle: GoogleFonts.raleway(fontSize: 17),
                            floatingLabelStyle:
                                GoogleFonts.raleway(color: Color(0xff243b55)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.grey, width: 2)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color(0xff243b55), width: 2))),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      width: width * 0.8,
                      child: TextFormField(
                        controller: userQualificationController,
                        style: GoogleFonts.raleway(fontSize: 18),
                        keyboardType: TextInputType.text,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                            labelText: "Qualification",
                            labelStyle: GoogleFonts.raleway(fontSize: 17),
                            floatingLabelStyle:
                                GoogleFonts.raleway(color: Color(0xff243b55)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.grey, width: 2)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color(0xff243b55), width: 2))),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      width: width * 0.8,
                      child: TextFormField(
                        controller: userOrganizationController,
                        style: GoogleFonts.raleway(fontSize: 18),
                        keyboardType: TextInputType.text,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                            labelText: "Organization",
                            labelStyle: GoogleFonts.raleway(fontSize: 17),
                            floatingLabelStyle:
                                GoogleFonts.raleway(color: Color(0xff243b55)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.grey, width: 2)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color(0xff243b55), width: 2))),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Text(
                      "SKILLS",
                      style: GoogleFonts.raleway(
                          color: const Color(0xff243b55),
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
                            color: const Color(0xff243b55),
                          ),
                          const Text(
                            "   X   ",
                            style: TextStyle(
                              color: Color(0xff243b55),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            height: 3,
                            width: width * 0.175,
                            color: const Color(0xff243b55),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Text(
                      "Tap on the skills you know or have interest",
                      style: GoogleFonts.raleway(fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: width * 0.1, vertical: height * 0.03),
                      child: GridView.count(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        childAspectRatio: 2.5,
                        padding: EdgeInsets.zero,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: height * 0.01,
                        children: [
                          for (int i = 0; i < courses.length; i++) ...[
                            InkWell(
                              onTap: () {
                                setState(() {
                                  skillsSelected[i] = !skillsSelected[i];
                                  if (skillsSelected[i]) {
                                    userSkills.add({
                                      'course_id': courses[i]['course_id'],
                                      'course_name': courses[i]['course_name']
                                    });
                                  } else {
                                    userSkills.removeWhere((element) =>
                                        element['course_id'] ==
                                        courses[i]['course_id']);
                                  }
                                  print(userSkills);
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: skillsSelected[i]
                                        ? Color(0xff243b55)
                                        : Colors.white,
                                    border: Border.all(
                                        color: Color(0xff243b55), width: 2),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Center(
                                  child: Text(
                                    "${courses[i]['course_name']}",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.raleway(
                                        color: !skillsSelected[i]
                                            ? Color(0xff243b55)
                                            : Colors.white),
                                  ),
                                ),
                              ),
                            )
                          ]
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Text(
                      "LANGUAGES",
                      style: GoogleFonts.raleway(
                          color: const Color(0xff243b55),
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
                            color: const Color(0xff243b55),
                          ),
                          const Text(
                            "   X   ",
                            style: TextStyle(
                              color: Color(0xff243b55),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            height: 3,
                            width: width * 0.175,
                            color: const Color(0xff243b55),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                      child: Text(
                        "Tap on the language in which you can communicate",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.raleway(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: width * 0.1, vertical: height * 0.03),
                      child: GridView.count(
                        padding: EdgeInsets.zero,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        childAspectRatio: 2.5,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: height * 0.01,
                        children: [
                          for (int i = 0; i < totalLanguages.length; i++) ...[
                            InkWell(
                              onTap: () {
                                setState(() {
                                  languageSelected[i] = !languageSelected[i];
                                  if (languageSelected[i]) {
                                    userLanguages.add(totalLanguages[i]);
                                  } else {
                                    userLanguages.remove(totalLanguages[i]);
                                  }
                                });
                                print(userLanguages);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: languageSelected[i]
                                        ? Color(0xff243b55)
                                        : Colors.white,
                                    border: Border.all(
                                        color: Color(0xff243b55), width: 2),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Center(
                                  child: Text(
                                    totalLanguages[i],
                                    style: GoogleFonts.raleway(
                                        color: languageSelected[i]
                                            ? Colors.white
                                            : Color(0xff243b55)),
                                  ),
                                ),
                              ),
                            )
                          ]
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (userEmailAddressController.text.isEmpty) {
                            showSnackBar("Enter email address", context,
                                Colors.redAccent.shade700);
                          } else if (userQualificationController.text.isEmpty) {
                            showSnackBar("Enter your qualification", context,
                                Colors.redAccent.shade700);
                          } else if (userOrganizationController.text.isEmpty) {
                            showSnackBar("Enter your organization", context,
                                Colors.redAccent.shade700);
                          } else if (userSkills.length == 0) {
                            showSnackBar("Select atleast one skill", context,
                                Colors.redAccent.shade700);
                          } else if (userSkills.length > 3) {
                            showSnackBar("Select only 3 skills", context,
                                Colors.redAccent.shade700);
                          } else if (userLanguages.length == 0) {
                            showSnackBar("Select the language/s you know",
                                context, Colors.redAccent.shade700);
                          } else {
                            setState(() {
                              isLoading = true;
                            });
                            db.collection("users").doc(userId).update({
                              "isVolunteer": true,
                              "email_address": userEmailAddressController.text,
                              "organization": userOrganizationController.text,
                              "qualification": userQualificationController.text,
                              "skills": userSkills,
                              "languages": userLanguages
                            }).then((_) {
                              _updateVolunteerStatus(true);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          VolunteerApproval()));
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff243b55)),
                        child: Text(
                          "SUBMIT",
                          style: GoogleFonts.raleway(color: Colors.white),
                        )),
                    SizedBox(height: height * 0.025),
                  ],
                ),
              ));
  }
}
