import 'package:flutter/material.dart';
import 'package:flutter_app/screens/course_page.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/courses.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: double.infinity,
            height: height * 0.04,
          ),
          Container(
            padding: EdgeInsets.all(width * 0.055),
            decoration: BoxDecoration(
                color: const Color(0xff243b55),
                borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: [
                Text(
                  "Want to become a Volunteer?",
                  style: GoogleFonts.raleway(color: Colors.white, fontSize: 20),
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                ElevatedButton(
                    onPressed: () {},
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.white),
                    child: Text(
                      "EXPLORE NOW",
                      style:
                          GoogleFonts.raleway(color: const Color(0xff243b55)),
                    ))
              ],
            ),
          ),
          SizedBox(
            height: height * 0.07,
          ),
          Text(
            "COURSES WE OFFER",
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
            height: height * 0.0275,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          CourseDescriptionPage(course: courses[0])));
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.redAccent.shade400,
              ),
              padding: EdgeInsets.all(10),
              height: height * 0.2,
              width: width * 0.7,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    bottom: 0,
                    child: Hero(
                      tag: "${courses[0]['course_id']}",
                      child: Image.asset(
                        "${courses[0]['image_path']}",
                        height: height * 0.15,
                      ),
                    ),
                  ),
                  Positioned(
                    right: width * 0.02,
                    top: width * 0.02,
                    child: Text(
                      "${courses[0]['course_name']}".toUpperCase(),
                      style: GoogleFonts.raleway(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
