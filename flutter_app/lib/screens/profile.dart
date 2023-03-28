import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:badges/badges.dart' as badges;

import '../providers/courses_provider.dart';
import '../widgets/snackbar.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final userEmailAddressController = TextEditingController();
  final userQualificationController = TextEditingController();
  final userOrganizationController = TextEditingController();
  final nameController = TextEditingController();
  final mobileNumberController = TextEditingController();
  final dobDatePicker = DateRangePickerController();
  final userCityController = TextEditingController();
  final userStateController = TextEditingController();
  final userCountryController = TextEditingController();
  final userPincodeController = TextEditingController();
  final genderController = TextEditingController();

  var userSkills = [];
  var userLanguages = [];
  late List<bool> skillsSelected = [];
  late List<bool> languageSelected = [];

  final db = FirebaseFirestore.instance.collection("users");

  bool isLoading = true;
  bool isUpdating = false;

  String? userId;
  bool? isVolunteer;
  String? profilePhotoPath;

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

  final courses = [];

  Future<void> _fetchUserId() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = (prefs.getString('userId') ?? null);
      isVolunteer = (prefs.getBool('isVolunteer') ?? null);
    });
    print(userId);
    print(isVolunteer);
  }

  Future<void> _fetchUserData() async {
    final sample = await db.doc(userId);
    print(sample.firestore);
    print(sample.snapshots());
    print(sample.parent);
    print(sample.id);
    await db.doc(userId).get().then((value) {
      print("============== VALUE ================");
      print(value);
      print(value.data());
      // print("============== USER SKILLS ================");
      // print(value.data()!['skills']);
      setState(() {
        nameController.text = value.data()!['name'];
        mobileNumberController.text = value.data()!['phone_number'];
        // dobDatePicker = DateRangePickerController();
        userCityController.text = value.data()!['city'];
        userStateController.text = value.data()!['state'];
        userCountryController.text = value.data()!['country'];
        userPincodeController.text = value.data()!['pincode'];
        genderController.text = value.data()!['gender'];
        profilePhotoPath = value.data()!['profile_picture_path'];

        if (isVolunteer!) {
          userEmailAddressController.text = value.data()!['email_address'];
          userQualificationController.text = value.data()!['qualification'];
          userOrganizationController.text = value.data()!['organization'];
          userSkills.addAll(value.data()!['skills']);
          userLanguages.addAll(value.data()!['languages']);
        }
      });
    });

    setState(() {
      isLoading = false;
    });
  }

  XFile? userImage;
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

  Future<void> _uploadProfilePhoto() async {
    late String phoneNumber;
    await db.doc(userId).get().then((value) {
      print(value.data());
      phoneNumber = value.data()!['phone_number'];
    });
    final storage = FirebaseStorage.instance.ref("profile photo/$phoneNumber");
    try {
      await storage.putFile(File(userImage!.path));
      final getUrl = await storage.getDownloadURL();
      setState(() {
        profilePhotoPath = getUrl;
      });
      print(profilePhotoPath);
    } catch (e) {
      showSnackBar(e.toString(), context, Colors.redAccent.shade400);
    }
  }

  @override
  void initState() {
    _fetchUserId();
    _fetchUserData().then((_) {
      for (var course
          in Provider.of<CourseProvider>(context, listen: false).courses) {
        bool haveSkill = false;
        for (var skill in userSkills) {
          if (skill['course_id'] == course['course_id']) {
            haveSkill = true;
          }
        }
        skillsSelected.add(haveSkill);
        courses.add(course);
      }
      print(skillsSelected);

      for (var language in totalLanguages) {
        // languageSelected.add(userLanguages.contains(language));
        bool haveLanguage = false;
        for (var item in userLanguages) {
          if (item == language) {
            haveLanguage = true;
          }
        }
        languageSelected.add(haveLanguage);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

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
                      height: height * 0.05,
                      width: width,
                    ),
                    Center(
                        child: badges.Badge(
                      showBadge: userImage == null && profilePhotoPath == null
                          ? false
                          : true,
                      badgeStyle: badges.BadgeStyle(
                        badgeColor: Colors.redAccent.shade400,
                        padding: EdgeInsets.all(2),
                      ),
                      badgeContent: Icon(
                        Icons.cancel_outlined,
                        color: Colors.white,
                      ),
                      position: badges.BadgePosition.topEnd(end: width * 0.05),
                      onTap: () {
                        setState(() {
                          userImage = null;
                          profilePhotoPath = null;
                        });
                      },
                      child: CircleAvatar(
                        radius: height * 0.1,
                        backgroundColor: Color(0xff243b55),
                        backgroundImage: userImage != null
                            ? FileImage(File(userImage!.path))
                            : profilePhotoPath != null
                                ? NetworkImage(profilePhotoPath!)
                                    as ImageProvider
                                : AssetImage("assets/images/man.png"),
                      ),
                    )),
                    SizedBox(
                      height: height * 0.03,
                    ),
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
                        controller: nameController,
                        style: GoogleFonts.raleway(fontSize: 18),
                        keyboardType: TextInputType.name,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                            labelText: "Name",
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
                        controller: mobileNumberController,
                        style: GoogleFonts.raleway(fontSize: 18),
                        keyboardType: TextInputType.phone,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                            labelText: "Mobile Number",
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
                    if (isVolunteer!)
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
                        controller: genderController,
                        style: GoogleFonts.raleway(fontSize: 18),
                        keyboardType: TextInputType.text,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                            labelText: "Gender",
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
                    if (isVolunteer!)
                      Column(
                        children: [
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
                                  floatingLabelStyle: GoogleFonts.raleway(
                                      color: Color(0xff243b55)),
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
                                  floatingLabelStyle: GoogleFonts.raleway(
                                      color: Color(0xff243b55)),
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
                            style: GoogleFonts.raleway(
                                fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: width * 0.1,
                                vertical: height * 0.03),
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
                                            'course_id': courses[i]
                                                ['course_id'],
                                            'course_name': courses[i]
                                                ['course_name']
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
                                              color: Color(0xff243b55),
                                              width: 2),
                                          borderRadius:
                                              BorderRadius.circular(20)),
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
                            padding:
                                EdgeInsets.symmetric(horizontal: width * 0.1),
                            child: Text(
                              "Tap on the language in which you can communicate",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.raleway(
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: width * 0.1,
                                vertical: height * 0.03),
                            child: GridView.count(
                              padding: EdgeInsets.zero,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              crossAxisCount: 2,
                              childAspectRatio: 2.5,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: height * 0.01,
                              children: [
                                for (int i = 0;
                                    i < totalLanguages.length;
                                    i++) ...[
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        languageSelected[i] =
                                            !languageSelected[i];

                                        if (languageSelected[i]) {
                                          userLanguages.add(totalLanguages[i]);
                                        } else {
                                          userLanguages
                                              .remove(totalLanguages[i]);
                                        }
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: languageSelected[i]
                                              ? Color(0xff243b55)
                                              : Colors.white,
                                          border: Border.all(
                                              color: Color(0xff243b55),
                                              width: 2),
                                          borderRadius:
                                              BorderRadius.circular(20)),
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
                        ],
                      ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    ElevatedButton(
                        onPressed: isUpdating
                            ? null
                            : () async {
                                setState(() {
                                  isUpdating = true;
                                });
                                if (isVolunteer!) {
                                  if (nameController.text.isEmpty) {
                                    showSnackBar("Enter your name", context,
                                        Colors.redAccent.shade700);
                                  } else if (mobileNumberController
                                      .text.isEmpty) {
                                    showSnackBar("Enter your mobile number",
                                        context, Colors.redAccent.shade700);
                                  } else if (userEmailAddressController
                                      .text.isEmpty) {
                                    showSnackBar("Enter email address", context,
                                        Colors.redAccent.shade700);
                                  } else if (genderController.text.isEmpty) {
                                    showSnackBar("Enter your gender", context,
                                        Colors.redAccent.shade700);
                                  } else if (userQualificationController
                                      .text.isEmpty) {
                                    showSnackBar("Enter your qualification",
                                        context, Colors.redAccent.shade700);
                                  } else if (userOrganizationController
                                      .text.isEmpty) {
                                    showSnackBar("Enter your organization",
                                        context, Colors.redAccent.shade700);
                                  } else if (userSkills.length == 0) {
                                    showSnackBar("Select atleast one skill",
                                        context, Colors.redAccent.shade700);
                                  } else if (userSkills.length > 3) {
                                    showSnackBar("Select only 3 skills",
                                        context, Colors.redAccent.shade700);
                                  } else if (userLanguages.length == 0) {
                                    showSnackBar(
                                        "Select the language/s you know",
                                        context,
                                        Colors.redAccent.shade700);
                                  } else {
                                    try {
                                      if (userImage != null) {
                                        await _uploadProfilePhoto()
                                            .then((_) async {
                                          await db.doc(userId).update({
                                            'phone_number':
                                                mobileNumberController.text,
                                            'name': nameController.text,
                                            'gender': genderController.text,
                                            "email_address":
                                                userEmailAddressController.text,
                                            "organization":
                                                userOrganizationController.text,
                                            "qualification":
                                                userQualificationController
                                                    .text,
                                            "skills": userSkills,
                                            "languages": userLanguages,
                                            "profile_picture_path":
                                                profilePhotoPath
                                          }).then((_) {
                                            showSnackBar(
                                                "Profile updated successfully!",
                                                context,
                                                Colors.green.shade900);
                                          });
                                        });
                                      } else {
                                        await db.doc(userId).update({
                                          'phone_number':
                                              mobileNumberController.text,
                                          'name': nameController.text,
                                          'gender': genderController.text,
                                          "email_address":
                                              userEmailAddressController.text,
                                          "organization":
                                              userOrganizationController.text,
                                          "qualification":
                                              userQualificationController.text,
                                          "skills": userSkills,
                                          "languages": userLanguages,
                                          "profile_picture_path":
                                              profilePhotoPath
                                        }).then((_) {
                                          showSnackBar(
                                              "Profile updated successfully!",
                                              context,
                                              Colors.green.shade900);
                                        });
                                      }
                                    } catch (e) {
                                      showSnackBar("Error updating in profile",
                                          context, Colors.redAccent.shade700);
                                    }
                                  }
                                  setState(() {
                                    isUpdating = false;
                                  });
                                } else {
                                  if (nameController.text.isEmpty) {
                                    showSnackBar("Enter your name", context,
                                        Colors.redAccent.shade700);
                                  } else if (mobileNumberController
                                      .text.isEmpty) {
                                    showSnackBar("Enter your mobile number",
                                        context, Colors.redAccent.shade700);
                                  } else if (genderController.text.isEmpty) {
                                    showSnackBar("Enter your gender", context,
                                        Colors.redAccent.shade700);
                                  } else {
                                    try {
                                      if (userImage != null) {
                                        await _uploadProfilePhoto()
                                            .then((_) async {
                                          await db.doc(userId).update({
                                            'phone_number':
                                                mobileNumberController.text,
                                            'name': nameController.text,
                                            'gender': genderController.text,
                                            'profile_picture_path':
                                                profilePhotoPath
                                          }).then((value) {
                                            showSnackBar(
                                                "Profile updated successfully!",
                                                context,
                                                Colors.green.shade900);
                                          });
                                        });
                                      } else {
                                        await db.doc(userId).update({
                                          'phone_number':
                                              mobileNumberController.text,
                                          'name': nameController.text,
                                          'gender': genderController.text,
                                          "profile_picture_path":
                                              profilePhotoPath
                                        }).then((value) {
                                          showSnackBar(
                                              "Profile updated successfully!",
                                              context,
                                              Colors.green.shade900);
                                        });
                                      }
                                    } catch (e) {
                                      showSnackBar("Error updating in profile",
                                          context, Colors.redAccent.shade700);
                                    }
                                  }
                                  setState(() {
                                    isUpdating = false;
                                  });
                                }
                              },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff243b55)),
                        child: isUpdating
                            ? CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                "SAVE",
                                style: GoogleFonts.raleway(color: Colors.white),
                              )),
                    SizedBox(height: height * 0.025),
                  ],
                ),
              ));
  }
}
