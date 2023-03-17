import 'package:flutter/material.dart';
import 'package:flutter_app/screens/homepage.dart';
import 'package:google_fonts/google_fonts.dart';

class VolunteerApproval extends StatelessWidget {
  const VolunteerApproval({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            height: height * 0.18,
            width: width,
          ),
          Center(
            child: Image.asset(
              "Course_Images/Congratulations.png",
              height: height * 0.4,
              width: width,
            ),
          ),
          SizedBox(
            height: height * 0.04,
            width: width,
          ),
          Text(
            "Congratulations".toUpperCase(),
            style: GoogleFonts.raleway(
                color: const Color(0xff243b55),
                fontWeight: FontWeight.bold,
                fontSize: 21),
          ),
          SizedBox(
            height: height * 0.02,
          ),
          RichText(
            text: TextSpan(
              style: GoogleFonts.raleway(
                  color: const Color(0xff243b55), fontSize: 16),
              children: <TextSpan>[
                TextSpan(text: 'You Are Now '),
                TextSpan(
                    text: 'ImpactMe Volunteer!',
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          SizedBox(
            height: height * 0.08,
            width: width,
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UserHomePage(isVolunteer: true,)));
              },
              style:
                  ElevatedButton.styleFrom(backgroundColor: Color(0xff243b55)),
              child: Text(
                "CONTINUE",
                style: GoogleFonts.raleway(color: Colors.white),
              )),
        ]),
      ),
    );
  }
}
