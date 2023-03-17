import 'package:country_state_city_pro/country_state_city_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/courses.dart';
import 'package:flutter_app/screens/volunteer_approval.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class VolunteerRegistration extends StatefulWidget {
  const VolunteerRegistration({super.key});

  @override
  State<VolunteerRegistration> createState() => _VolunteerRegistrationState();
}

class _VolunteerRegistrationState extends State<VolunteerRegistration> {
  late final XFile? userImage;

  _getPhoto(String medium) {
    setState(() async {
      userImage = await ImagePicker().pickImage(
          source:
              medium == "gallery" ? ImageSource.gallery : ImageSource.camera);
    });
  }

  final userEmailAddressController = TextEditingController();
  final userQualificationController = TextEditingController();
  final userOrganizationController = TextEditingController();

  List<String> userSkills = [];
  List<String> userLanguages = [];

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

  @override
  void initState() {
    for (var course in courses) {
      skillsSelected.add(false);
    }

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
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
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 2)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color(0xff243b55), width: 2))),
                ),
              ),
              
              // Container(
              //   margin: const EdgeInsets.all(10),
              //   width: width * 0.8,
              //   child: TextFormField(
              //     controller: userPincodeController,
              //     style: GoogleFonts.raleway(fontSize: 18),
              //     keyboardType: TextInputType.number,
              //     textAlign: TextAlign.center,
              //     decoration: InputDecoration(
              //         labelText: "Pincode",
              //         labelStyle: GoogleFonts.raleway(fontSize: 17),
              //         floatingLabelStyle:
              //             GoogleFonts.raleway(color: Color(0xff243b55)),
              //         enabledBorder: OutlineInputBorder(
              //             borderSide:
              //                 const BorderSide(color: Colors.grey, width: 2)),
              //         focusedBorder: OutlineInputBorder(
              //             borderSide: const BorderSide(
              //                 color: Color(0xff243b55), width: 2))),
              //   ),
              // ),
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
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 2)),
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
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 2)),
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
              // Container(
              //   padding: EdgeInsets.symmetric(horizontal: width * 0.1),
              //   child: GridView.builder(
              //       shrinkWrap: true,
              //       physics: NeverScrollableScrollPhysics(),
              //       itemCount: courses.length,
              //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //           crossAxisCount: 2,
              //           crossAxisSpacing: 10,
              //           mainAxisSpacing: height * 0.01,
              //           childAspectRatio: 2.5),
              //       itemBuilder: (context, index) {
              //         bool selected = false;
              //         return InkWell(
              //           onTap: () {
              //             setState(() {
              //               selected = !selected;
              //             });
              //           },
              //           child: Container(
              //             decoration: BoxDecoration(
              //                 color:
              //                     selected ? Color(0xff243b55) : Colors.white,
              //                 border: Border.all(
              //                     color: Color(0xff243b55), width: 2),
              //                 borderRadius: BorderRadius.circular(20)),
              //             child: Center(
              //               child: Text(
              //                 "${courses[index]['course_name']}",
              //                 style:
              //                     GoogleFonts.raleway(color: Color(0xff243b55)),
              //               ),
              //             ),
              //           ),
              //         );
              //       }),
              // ),
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
                          });
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => VolunteerApproval()));
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
