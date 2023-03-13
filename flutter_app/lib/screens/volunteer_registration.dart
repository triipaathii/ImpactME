import 'package:country_state_city_pro/country_state_city_pro.dart';
import 'package:flutter/material.dart';
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
  final userCityController = TextEditingController();
  final userStateController = TextEditingController();
  final userCountryController = TextEditingController();
  final userPincodeController = TextEditingController();
  List<String> userSkills = [];
  List<String> userLanguages = [];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
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
            height: height * 0.05,
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
          CountryStateCityPicker(
            country: userCountryController,
            state: userStateController,
            city: userCityController,
            textFieldInputBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: Color(0xff243b55), width: 2)),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            width: width * 0.8,
            child: TextFormField(
              controller: userPincodeController,
              style: GoogleFonts.raleway(fontSize: 18),
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                  labelText: "Pincode",
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
            height: height * 0.015,
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => VolunteerRegistration()));
              },
              style:
                  ElevatedButton.styleFrom(backgroundColor: Color(0xff243b55)),
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
