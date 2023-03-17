import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CourseDescriptionPage extends StatelessWidget {
  Map<String, dynamic> course;
  CourseDescriptionPage({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    //     statusBarColor: Colors.white,
    //     statusBarIconBrightness: Brightness.dark));

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              height: height * 0.1,
            ),
            CircleAvatar(
              radius: height * 0.1,
              backgroundColor: Color(0xff243b55),
              child: Hero(
                tag: "${course['course_id']}",
                child: Image.asset(
                  "${course['image_path']}",
                  height: height * 0.09,
                ),
              ),
            ),
            SizedBox(
              height: height * 0.03,
            ),
            Text(
              "${course['course_name']}".toUpperCase(),
              textAlign: TextAlign.center,
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.05),
              child: RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                      style: GoogleFonts.raleway(
                          color: Colors.black, fontSize: 16),
                      children: <TextSpan>[
                        TextSpan(
                            text: "\nDESCRIPTION\n\n",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(
                          text: "${course['description']}",
                        ),
                        TextSpan(
                            text: "\n\nWHAT YOU WILL LEARN\n\n",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        for (var content in course['course_content'])
                          TextSpan(
                            text: "  ⚈   $content\n",
                          ),
                        TextSpan(
                            text: "\nPERKS\n\n",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        for (var perk in course['perks'])
                          TextSpan(
                            text: "  ⚈   $perk\n",
                          ),
                      ])),
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
              height: height * 0.02,
            )
          ],
        ),
      ),
    );
  }
}
