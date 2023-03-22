import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/providers/user_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../providers/courses_provider.dart';

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

  final db = FirebaseFirestore.instance;

  bool isLoading = true;
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

  final courses = [];

  @override
  void initState() {
    setState(() {
      isVolunteer =
          Provider.of<UserIdProvider>(context, listen: false).isVolunteer;
      db
          .collection("users")
          .doc(Provider.of<UserIdProvider>(context, listen: false).userId)
          .get()
          .then((value) {
        print("============== VALUE ================");
        print(value.data());
        userEmailAddressController.text = value.data()!['email_address'];
        userQualificationController.text = value.data()!['qualification'];
        userOrganizationController.text = value.data()!['organization'];
        nameController.text = value.data()!['name'];
        mobileNumberController.text = value.data()!['phone_number'];
        // dobDatePicker = DateRangePickerController();
        userCityController.text = value.data()!['city'];
        userStateController.text = value.data()!['state'];
        userCountryController.text = value.data()!['country'];
        userPincodeController.text = value.data()!['pincode'];
        genderController.text = value.data()!['gender'];
        userSkills.addAll(value.data()!['skills']);
        userLanguages.addAll(value.data()!['languages']);
      });
      for (var course
          in Provider.of<CourseProvider>(context, listen: false).courses) {
        skillsSelected.add(userSkills.contains(course));
        courses.add(course);
      }

      for (var language in totalLanguages) {
        languageSelected.add(userLanguages.contains(language));
      }
      isLoading = false;
    });
    print("============== USER SKILLS ==============");
    print(userSkills);
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
                      child: CircleAvatar(
                        radius: height * 0.1,
                        backgroundColor: Color(0xff243b55),
                        backgroundImage: AssetImage("assets/images/man.png"),
                      ),
                    ),
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
                              onPressed: () {},
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
                              onPressed: () {},
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
                        onPressed: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => VolunteerApproval()));
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff243b55)),
                        child: Text(
                          "SAVE",
                          style: GoogleFonts.raleway(color: Colors.white),
                        )),
                    SizedBox(height: height * 0.025),
                  ],
                ),
              ));
  }
}
