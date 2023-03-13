import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  Future<void> _launchUrl(_url) async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: width,
            height: height * 0.05,
          ),
          Text(
            "OUR VISION",
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
            padding: EdgeInsets.only(top: height * 0.03),
            child: Text(
              "\"ENDING POVERTY'S VICIOUS CYCLE\"",
              style: GoogleFonts.raleway(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  letterSpacing: 2),
            ),
          ),
          Image.asset(
            "assets/images/community_growth.jpg",
            height: height * 0.4,
          ),
          Padding(
            padding: EdgeInsets.all(width * 0.06),
            child: RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(
                    text: "At ",
                    style:
                        GoogleFonts.raleway(color: Colors.black, fontSize: 16),
                    children: const <TextSpan>[
                      TextSpan(
                          text: "ImpactME",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(
                          text:
                              ", we envision a world where no individual is deprived"
                              " of access to education and the opportunity to earn a "
                              "livelihood. We believe that education is the most powerful "
                              "tool that can be used to break the cycle of poverty, and "
                              "our mission is to make it accessible to all, regardless of"
                              " their socio-economic background.")
                    ])),
          ),
          Image.asset(
            "assets/images/community_learn.jpg",
            height: height * 0.4,
          ),
          Padding(
            padding: EdgeInsets.all(width * 0.06),
            child: RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(
                    text:
                        "With our cutting-edge app, we aim to provide a gateway to ",
                    style:
                        GoogleFonts.raleway(color: Colors.black, fontSize: 16),
                    children: const <TextSpan>[
                      TextSpan(
                          text: "vocational courses",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(
                          text: " for the underprivileged residing in cities, "
                              "remote areas, and slums. We understand that the"
                              " lack of access to quality education and "
                              "skill-building opportunities often leads to "
                              "unemployment, poverty, and social exclusion. "
                              "Hence, we have developed a platform that connects"
                              " volunteers possessing various skills to work in"
                              " different regions, teaching different skills for"
                              " varying durations throughout the year.")
                    ])),
          ),
          Image.asset(
            "assets/images/community_earn.jpg",
            height: height * 0.4,
          ),
          Padding(
            padding: EdgeInsets.all(width * 0.06),
            child: RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(
                    text:
                        "In addition to providing vocational courses, we also "
                        "aim to offer other essential resources such as ",
                    style:
                        GoogleFonts.raleway(color: Colors.black, fontSize: 16),
                    children: const <TextSpan>[
                      TextSpan(
                          text: "donated books, food, and other necessities",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(
                          text: " to individuals in need. We envision a world "
                              "where every individual has access to quality "
                              "vocational education and the opportunity to pursue "
                              "their dreams. Join us in making a positive impact "
                              "and realizing our shared vision through the "),
                      TextSpan(
                          text: "ImpactME app",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: ".")
                    ])),
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            "OUR TEAM",
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
                  width: 60,
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
                  width: 60,
                  color: const Color(0xff243b55),
                )
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: CircleAvatar(
              radius: 70,
              backgroundImage: AssetImage(
                'https://firebasestorage.googleapis.com/v0/b/gsc2k23.appspot.com/o/Course%20Images%2FProfile%20Pictures%2FAnurag.jpg?alt=media&token=79074c83-d864-4d20-bf84-d029e0917c05',
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  final Uri url =
                      Uri.parse("https://www.instagram.com/_lmao._.ded_/");
                  _launchUrl(url);
                },
                child: Image.asset(
                  "assets/images/instagram.png",
                  height: 35,
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              GestureDetector(
                onTap: () {
                  final Uri url = Uri.parse(
                      "https://www.linkedin.com/in/anurag-tripathi-7422291b4/");
                  _launchUrl(url);
                },
                child: Image.asset(
                  "assets/images/linkedin.png",
                  height: 35,
                ),
              )
            ],
          ),
          const SizedBox(height: 15),
          Text(
            "ANURAG TRIPATHI",
            style: GoogleFonts.raleway(fontSize: 18),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: CircleAvatar(
              radius: 70,
              backgroundImage: AssetImage(
                'https://firebasestorage.googleapis.com/v0/b/gsc2k23.appspot.com/o/Course%20Images%2FProfile%20Pictures%2FAdithya.png?alt=media&token=9c794b7b-fd16-48ac-91e9-d885fc70e36e',
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  final Uri url =
                      Uri.parse("https://www.instagram.com/adi_._cted01/");
                  _launchUrl(url);
                },
                child: Image.asset(
                  "assets/images/instagram.png",
                  height: 35,
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              GestureDetector(
                onTap: () {
                  final Uri url = Uri.parse(
                      "https://www.linkedin.com/in/adithya-srivastava-a945531b2/");
                  _launchUrl(url);
                },
                child: Image.asset(
                  "assets/images/linkedin.png",
                  height: 35,
                ),
              )
            ],
          ),
          const SizedBox(height: 15),
          Text(
            "ADITHYA SRIVASTAVA",
            style: GoogleFonts.raleway(fontSize: 18),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: CircleAvatar(
              radius: 70,
              backgroundImage: AssetImage(
                'https://firebasestorage.googleapis.com/v0/b/gsc2k23.appspot.com/o/Course%20Images%2FProfile%20Pictures%2FAnusha.jpeg?alt=media&token=37c8608a-ba8a-4068-841f-3517f3dc98bc',
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  final Uri url =
                      Uri.parse("https://www.instagram.com/as_anushasharma/");
                  _launchUrl(url);
                },
                child: Image.asset(
                  "assets/images/instagram.png",
                  height: 35,
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              GestureDetector(
                onTap: () {
                  final Uri url = Uri.parse(
                      "https://www.linkedin.com/in/anusha-sharma-b3512a229/");
                  _launchUrl(url);
                },
                child: Image.asset(
                  "assets/images/linkedin.png",
                  height: 35,
                ),
              )
            ],
          ),
          const SizedBox(height: 15),
          Text(
            "ANUSHA SHARMA",
            style: GoogleFonts.raleway(fontSize: 18),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: CircleAvatar(
              radius: 70,
              backgroundImage: AssetImage(
                'https://firebasestorage.googleapis.com/v0/b/gsc2k23.appspot.com/o/Course%20Images%2FProfile%20Pictures%2FTanisha.png?alt=media&token=60a3f3e4-36cf-419f-9492-72b526b790e4',
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  final Uri url =
                      Uri.parse("https://www.instagram.com/_.tan.ishaa._/");
                  _launchUrl(url);
                },
                child: Image.asset(
                  "assets/images/instagram.png",
                  height: 35,
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              GestureDetector(
                onTap: () {
                  final Uri url = Uri.parse(
                      "https://www.linkedin.com/in/tanisha-sharma-45a70b230/");
                  _launchUrl(url);
                },
                child: Image.asset(
                  "assets/images/linkedin.png",
                  height: 35,
                ),
              )
            ],
          ),
          const SizedBox(height: 15),
          Text(
            "TANISHA SHARMA",
            style: GoogleFonts.raleway(fontSize: 18),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 3,
                  width: 60,
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
                  width: 60,
                  color: const Color(0xff243b55),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
