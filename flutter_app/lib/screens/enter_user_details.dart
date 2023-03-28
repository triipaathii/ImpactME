import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_state_city_pro/country_state_city_pro.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/screens/homepage.dart';
import 'package:flutter_app/widgets/snackbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:badges/badges.dart' as badges;

class EnterUserBasicDetails extends StatefulWidget {
  var phone_number;
  EnterUserBasicDetails({super.key, required this.phone_number});

  @override
  State<EnterUserBasicDetails> createState() => _EnterUserBasicDetailsState();
}

class _EnterUserBasicDetailsState extends State<EnterUserBasicDetails> {
  final nameController = TextEditingController();
  final dobDatePicker = DateRangePickerController();
  final userCityController = TextEditingController();
  final userStateController = TextEditingController();
  final userCountryController = TextEditingController();
  final userPincodeController = TextEditingController();
  String _selectedGender = 'male';

  final db = FirebaseFirestore.instance;

  bool isLoading = false;

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

  Future<void> _uploadProfilePhoto() async {
    final storage =
        FirebaseStorage.instance.ref("profile photo/${widget.phone_number}");
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
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Color(0xff243b55),
    ));

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff243b55),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: double.infinity,
                      height: 50,
                    ),
                    Image.asset(
                      "assets/images/logo.png",
                      color: Colors.white,
                      height: 100,
                    ),
                    Text(
                      "IMPACT ME",
                      style: GoogleFonts.raleway(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          letterSpacing: 7),
                    ),
                    SizedBox(height: height * 0.05),
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
                        backgroundColor: Colors.white,
                        backgroundImage: userImage == null
                            ? AssetImage("assets/images/man.png")
                            : FileImage(File(userImage!.path)) as ImageProvider,
                      ),
                    )),
                    // if (userImage != null) Image.file(File(userImage!.path)),

                    SizedBox(
                      height: height * 0.03,
                    ),

                    Center(
                      child: Text(
                        "SELECT FROM",
                        style: GoogleFonts.raleway(color: Colors.white),
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
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5)),
                          child: IconButton(
                              onPressed: () {
                                _getImage(ImageSource.camera);
                              },
                              icon: Icon(
                                Icons.camera_alt_rounded,
                                color: Color(0xff243b55),
                              )),
                        ),
                        SizedBox(
                          width: width * 0.02,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5)),
                          child: IconButton(
                              onPressed: () {
                                _getImage(ImageSource.gallery);
                              },
                              icon: Icon(
                                Icons.image_rounded,
                                color: Color(0xff243b55),
                              )),
                        )
                      ],
                    ),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    Text(
                      "ENTER YOUR NAME",
                      style: GoogleFonts.raleway(
                          color: Colors.white, fontSize: 19),
                    ),
                    const SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: TextFormField(
                        controller: nameController,
                        keyboardType: TextInputType.name,
                        cursorColor: const Color(0xff0ccda3),
                        textAlign: TextAlign.center,
                        cursorHeight: 30,
                        decoration: const InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xff0ccda3))),
                          disabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xff243b55))),
                        ),
                        style: GoogleFonts.raleway(
                            color: Colors.white,
                            fontSize: 20,
                            letterSpacing: 2),
                      ),
                    ),
                    const SizedBox(height: 50),
                    Text(
                      "SELECT YOUR DOB",
                      style: GoogleFonts.raleway(
                          color: Colors.white, fontSize: 19),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40.0),
                        child: SfDateRangePicker(
                          selectionMode: DateRangePickerSelectionMode.single,
                          controller: dobDatePicker,
                          rangeTextStyle: GoogleFonts.raleway(),
                          todayHighlightColor: const Color(0xff0ccda3),
                          monthCellStyle: DateRangePickerMonthCellStyle(
                              textStyle: GoogleFonts.raleway(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                              disabledDatesTextStyle: GoogleFonts.raleway(),
                              leadingDatesTextStyle: GoogleFonts.raleway(),
                              todayTextStyle: GoogleFonts.raleway(),
                              trailingDatesTextStyle: GoogleFonts.raleway(),
                              blackoutDateTextStyle: GoogleFonts.raleway(),
                              weekendTextStyle: GoogleFonts.raleway(),
                              todayCellDecoration: BoxDecoration(
                                  border: Border.all(
                                    color: const Color(0xff0ccda3),
                                  ),
                                  shape: BoxShape.circle)),
                          headerStyle: DateRangePickerHeaderStyle(
                              textAlign: TextAlign.center,
                              textStyle: GoogleFonts.raleway(
                                  color: const Color(0xff0ccda3),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold)),
                          selectionTextStyle: GoogleFonts.raleway(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                          selectionColor: const Color(0xff0ccda3),
                          yearCellStyle: DateRangePickerYearCellStyle(
                            textStyle: GoogleFonts.raleway(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                        )),
                    const SizedBox(height: 20),
                    Text(
                      "SELECT YOUR GENDER",
                      style: GoogleFonts.raleway(
                          color: Colors.white, fontSize: 19),
                    ),
                    const SizedBox(height: 5),
                    ListTile(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 100),
                      leading: Radio<String>(
                        activeColor: Color(0xff0ccda3),
                        value: 'male',
                        groupValue: _selectedGender,
                        onChanged: (value) {
                          setState(() {
                            _selectedGender = value!;
                          });
                        },
                      ),
                      title: Text(
                        'Male',
                        style: GoogleFonts.raleway(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    ListTile(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 100),
                      leading: Radio<String>(
                        activeColor: Color(0xff0ccda3),
                        value: 'female',
                        groupValue: _selectedGender,
                        onChanged: (value) {
                          setState(() {
                            _selectedGender = value!;
                          });
                        },
                      ),
                      title: Text('Female',
                          style: GoogleFonts.raleway(
                            color: Colors.white,
                            fontSize: 15,
                          )),
                    ),
                    ListTile(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 100),
                      leading: Radio<String>(
                        value: 'other',
                        activeColor: Color(0xff0ccda3),
                        groupValue: _selectedGender,
                        onChanged: (value) {
                          setState(() {
                            _selectedGender = value!;
                          });
                        },
                      ),
                      title: Text(
                        'Other',
                        style: GoogleFonts.raleway(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      "LOCATION",
                      style: GoogleFonts.raleway(
                          color: Colors.white, fontSize: 19),
                    ),
                    const SizedBox(height: 10),
                    CountryStateCityPicker(
                      country: userCountryController,
                      state: userStateController,
                      city: userCityController,
                      textFieldInputBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color(0xff243b55), width: 2)),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      "ENTER YOUR PINCODE",
                      style: GoogleFonts.raleway(
                          color: Colors.white, fontSize: 19),
                    ),
                    const SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: TextFormField(
                        controller: userPincodeController,
                        keyboardType: TextInputType.number,
                        cursorColor: const Color(0xff0ccda3),
                        textAlign: TextAlign.center,
                        cursorHeight: 30,
                        decoration: const InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xff0ccda3))),
                          disabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xff243b55))),
                        ),
                        style: GoogleFonts.raleway(
                            color: Colors.white,
                            fontSize: 20,
                            letterSpacing: 2),
                      ),
                    ),
                    const SizedBox(height: 50),
                    ElevatedButton(
                        onPressed: () async {
                          if (nameController.text.isEmpty) {
                            showSnackBar("Enter your name", context,
                                Colors.redAccent.shade700);
                          } else if (dobDatePicker.selectedDate == null) {
                            showSnackBar("Select your DOB", context,
                                Colors.redAccent.shade700);
                          } else if (userCityController.text.isEmpty) {
                            showSnackBar("Enter your city", context,
                                Colors.redAccent.shade700);
                          } else if (userPincodeController.text.isEmpty) {
                            showSnackBar("Enter your pincode", context,
                                Colors.redAccent.shade700);
                          } else {
                            setState(() {
                              isLoading = true;
                            });
                            if (userImage == null) {
                              await db.collection("users").add({
                                'phone_number': widget.phone_number,
                                'name': nameController.text,
                                'dob': {
                                  'date': dobDatePicker.selectedDate?.day,
                                  'month': dobDatePicker.selectedDate?.month,
                                  'year': dobDatePicker.selectedDate?.year
                                },
                                'gender': _selectedGender.toString(),
                                'country': userCountryController.text,
                                'city': userCityController.text,
                                'state': userStateController.text,
                                'pincode': userPincodeController.text,
                                'isVolunteer': false,
                                'profile_picture_path': profilePhotoPath
                              }).then((DocumentReference doc) async {
                                print(
                                    'DocumentSnapshot added with ID: ${doc.id}');
                                final prefs =
                                    await SharedPreferences.getInstance();
                                await prefs.setString('userId', doc.id);
                                await prefs.setBool('isVolunteer', false);
                                // Provider.of<UserIdProvider>(context,
                                //         listen: false)
                                //     .addUserId(doc.id);
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => UserHomePage()));
                                setState(() {
                                  isLoading = true;
                                });
                              });
                            } else {
                              _uploadProfilePhoto().then((_) async {
                                await db.collection("users").add({
                                  'phone_number': widget.phone_number,
                                  'name': nameController.text,
                                  'dob': {
                                    'date': dobDatePicker.selectedDate?.day,
                                    'month': dobDatePicker.selectedDate?.month,
                                    'year': dobDatePicker.selectedDate?.year
                                  },
                                  'gender': _selectedGender.toString(),
                                  'country': userCountryController.text,
                                  'city': userCityController.text,
                                  'state': userStateController.text,
                                  'pincode': userPincodeController.text,
                                  'isVolunteer': false,
                                  'profile_picture_path': profilePhotoPath
                                }).then((DocumentReference doc) async {
                                  print(
                                      'DocumentSnapshot added with ID: ${doc.id}');
                                  final prefs =
                                      await SharedPreferences.getInstance();
                                  await prefs.setString('userId', doc.id);
                                  await prefs.setBool('isVolunteer', false);
                                  // Provider.of<UserIdProvider>(context,
                                  //         listen: false)
                                  //     .addUserId(doc.id);
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              UserHomePage()));
                                  setState(() {
                                    isLoading = true;
                                  });
                                });
                              });
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: const Color(0xff0ccda3)),
                        child: Text(
                          "NEXT",
                          style: GoogleFonts.raleway(
                              color: const Color(0xff243b55),
                              fontSize: 15,
                              letterSpacing: 2),
                        )),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
