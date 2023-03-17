import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VolunteerApproval extends StatefulWidget {
  const VolunteerApproval({super.key});

  @override
  State<VolunteerApproval> createState() => _VolunteerApprovalState();
}

class _VolunteerApprovalState extends State<VolunteerApproval> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    var white;
    RichText text;
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
            "Congratulations",
            style: GoogleFonts.raleway(
                color: const Color(0xff243b55),
                fontWeight: FontWeight.bold,
                fontSize: 35,
                letterSpacing: 3),
          ),
          SizedBox(
            height: height * 0.04,
            width: width,
          ),
          text = RichText(
            text: TextSpan(
              style: const TextStyle(
                fontSize: 18.0,
                color: const Color(0xff243b55),
              ),
            children: <TextSpan>[
              TextSpan(text: 'You Are Now '),
              TextSpan(text: 'ImpactMe Volunteer!', style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
            ),
          ),
          SizedBox(
            height: height * 0.08,
            width: width,
          ),
          Container(
            child: Align (
              alignment: Alignment.center,
              child: Text(
                "CONTINUE",
              style: GoogleFonts.raleway(
                  color: Color.fromRGBO(255, 255, 255, 1),
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
              ),
            ),),
            margin: const EdgeInsets.all(10),
            width: width * 0.2,
            height: height * 0.05,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: const Color(0xff243b55)),
          ),
        ]),
      ),
    );
  }
}
