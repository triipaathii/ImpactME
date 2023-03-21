import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/course_page.dart';
import 'package:flutter_app/screens/volunteer_registration.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../providers/courses_provider.dart';

class Home extends StatefulWidget {
  bool isVolunteer;
  Home({super.key, required this.isVolunteer});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool booked = false;
  bool isLoading = true;
  List<Map<String, dynamic>> courses = [];
  List<Map<String, dynamic>> course_names = [];

  final db = FirebaseFirestore.instance;

  Future<void> _loadCourses() async {
    await db.collection("courses").get().then((event) {
      for (var doc in event.docs) {
        context.read<CourseProvider>().addCourses(doc.data());
        setState(() {
          courses.add(doc.data());
          course_names.add({
            'course_id': doc.data()['course_id'],
            'course_name': doc.data()['course_name'],
          });
        });
      }
    });
    setState(() {
      isLoading = false;
    });
    print("=================== COURSE PROVIDER =================");
    print(Provider.of<CourseProvider>(context, listen: false).courses);
  }

  final months = [
    "JAN",
    "FEB",
    "MAR",
    "APR",
    "MAY",
    "JUN",
    "JUL",
    "AUG",
    "SEP",
    "OCT",
    "NOV",
    "DEC"
  ];

  @override
  void initState() {
    _loadCourses();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return isLoading
        ? Center(
            child: CircularProgressIndicator(
              color: Color(0xff243b55),
            ),
          )
        : SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: height * 0.04,
                ),
                if (!widget.isVolunteer)
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(width * 0.055),
                        decoration: BoxDecoration(
                            color: const Color(0xff243b55),
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          children: [
                            Text(
                              "Want to become a Volunteer?",
                              style: GoogleFonts.raleway(
                                  color: Colors.white, fontSize: 20),
                            ),
                            SizedBox(
                              height: height * 0.03,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  showModalBottomSheet<void>(
                                      useSafeArea: true,
                                      backgroundColor: Color(0xff243b55),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20))),
                                      context: context,
                                      builder: (BuildContext context) {
                                        int currentPageIndex = 0;
                                        return StatefulBuilder(
                                          builder: (context, setState) =>
                                              Column(
                                            children: [
                                              CarouselSlider(
                                                  items: [
                                                    Column(
                                                      children: [
                                                        SizedBox(
                                                          height: height * 0.05,
                                                        ),
                                                        Text(
                                                          "AGE DOES NOT MATTER",
                                                          style: GoogleFonts
                                                              .raleway(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 18,
                                                                  letterSpacing:
                                                                      5),
                                                        ),
                                                        SizedBox(
                                                          height: height * 0.05,
                                                        ),
                                                        Image.asset(
                                                          "assets/images/age_volunteer.png",
                                                          height: height * 0.25,
                                                        )
                                                      ],
                                                    ),
                                                    Column(
                                                      children: [
                                                        SizedBox(
                                                          height: height * 0.05,
                                                        ),
                                                        Text(
                                                          "GET CERTIFIED",
                                                          style: GoogleFonts
                                                              .raleway(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 18,
                                                                  letterSpacing:
                                                                      5),
                                                        ),
                                                        SizedBox(
                                                          height: height * 0.05,
                                                        ),
                                                        Image.asset(
                                                          "assets/images/certified_volunteer.png",
                                                          height: height * 0.25,
                                                        )
                                                      ],
                                                    ),
                                                    Column(
                                                      children: [
                                                        SizedBox(
                                                          height: height * 0.05,
                                                        ),
                                                        Text(
                                                          "UPGRADE THE SOCIETY",
                                                          style: GoogleFonts
                                                              .raleway(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 18,
                                                                  letterSpacing:
                                                                      5),
                                                        ),
                                                        SizedBox(
                                                          height: height * 0.05,
                                                        ),
                                                        Image.asset(
                                                          "assets/images/upgrade_volunteer.png",
                                                          height: height * 0.25,
                                                        )
                                                      ],
                                                    ),
                                                    Column(
                                                      children: [
                                                        SizedBox(
                                                          height: height * 0.05,
                                                        ),
                                                        Image.asset(
                                                          "assets/images/happy_community.png",
                                                          height: height * 0.25,
                                                        ),
                                                        SizedBox(
                                                          height: height * 0.05,
                                                        ),
                                                        ElevatedButton(
                                                            onPressed: () {
                                                              Navigator.pushReplacement(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) => VolunteerRegistration(
                                                                            courses:
                                                                                course_names,
                                                                          )));
                                                            },
                                                            style: ElevatedButton
                                                                .styleFrom(
                                                                    backgroundColor:
                                                                        Colors
                                                                            .white),
                                                            child: Text(
                                                              "APPLY NOW",
                                                              style: GoogleFonts
                                                                  .raleway(
                                                                      color: const Color(
                                                                          0xff243b55)),
                                                            ))
                                                      ],
                                                    ),
                                                  ],
                                                  options: CarouselOptions(
                                                      height: height * 0.5,
                                                      autoPlayCurve:
                                                          Curves.decelerate,
                                                      viewportFraction: 1,
                                                      enlargeCenterPage: true,
                                                      animateToClosest: false,
                                                      enableInfiniteScroll:
                                                          false,
                                                      disableCenter: false,
                                                      enlargeStrategy:
                                                          CenterPageEnlargeStrategy
                                                              .scale,
                                                      onPageChanged:
                                                          (index, _) {
                                                        print(index);
                                                        setState(() {
                                                          currentPageIndex =
                                                              index;
                                                        });
                                                      })),
                                              DotsIndicator(
                                                dotsCount: 4,
                                                position: double.parse(
                                                    currentPageIndex
                                                        .toString()),
                                                decorator: DotsDecorator(
                                                    color: Colors.grey.shade600,
                                                    activeColor: Colors.white,
                                                    spacing: EdgeInsets.all(3),
                                                    activeSize: Size.square(
                                                        height * 0.01),
                                                    size: Size.square(
                                                        height * 0.008)),
                                              )
                                            ],
                                          ),
                                        );
                                      });
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white),
                                child: Text(
                                  "EXPLORE NOW",
                                  style: GoogleFonts.raleway(
                                      color: const Color(0xff243b55)),
                                ))
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                    ],
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
                  height: height * 0.01,
                ),
                Text(
                  "Tap on any to know more",
                  style: GoogleFonts.raleway(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (var course in courses)
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: width * 0.05),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          CourseDescriptionPage(
                                              course: course)));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color(0xff243b55),
                                  width: 3,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: EdgeInsets.all(10),
                              height: height * 0.25,
                              width: width * 0.5,
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 0,
                                    bottom: 0,
                                    child: Hero(
                                      tag: "${course['course_id']}",
                                      child: Image.asset(
                                        "${course['image_path']}",
                                        height: height * 0.13,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: width * 0.02,
                                    top: width * 0.02,
                                    child: SizedBox(
                                      width: width * 0.3,
                                      child: Text(
                                        "${course['course_name']}"
                                            .toUpperCase(),
                                        textAlign: TextAlign.end,
                                        style: GoogleFonts.raleway(
                                          color: const Color(0xff243b55),
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                if (courses.length > 0)
                  Column(
                    children: [
                      Text(
                        "CALENDAR",
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
                        height: height * 0.015,
                      ),
                      GridView.count(
                        crossAxisCount: 3,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                        childAspectRatio: 1,
                        crossAxisSpacing: width * 0.03,
                        mainAxisSpacing: width * 0.03,
                        children: [
                          for (int i = 0; i < 12; i++) ...[
                            Container(
                              decoration: BoxDecoration(
                                color: Color(0xff243b55),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Color(0xff243b55)),
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 2),
                                    child: Text(
                                      months[i],
                                      style: GoogleFonts.raleway(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Flexible(
                                    fit: FlexFit.tight,
                                    child: Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 2),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Center(
                                        child: Text(
                                          "${courses[i]['course_name']}",
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.raleway(),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ]
                        ],
                      ),
                    ],
                  ),
                SizedBox(
                  height: height * 0.05,
                ),
                Column(
                  children: [
                    Text(
                      "REGISTER NOW",
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
                      "Upcoming vocational course registration",
                      style: GoogleFonts.raleway(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          color: Color(0xff243b55),
                        ),
                        Text(
                          "Kanpur, Uttar Pradesh",
                          style: GoogleFonts.raleway(
                              color: Color(0xff243b55),
                              decoration: TextDecoration.underline),
                        )
                      ],
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xff243b55),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      margin: EdgeInsets.symmetric(horizontal: width * 0.05),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: Text(
                              "APRIL",
                              style: GoogleFonts.raleway(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 18,
                                  letterSpacing: 3),
                            ),
                          ),
                          Image.asset(
                            "assets/images/fishing.jpg",
                            width: double.infinity,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Text(
                              "FISHING",
                              style: GoogleFonts.raleway(
                                color: Colors.white,
                                fontSize: 17,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    ElevatedButton(
                        onPressed: booked
                            ? null
                            : () {
                                setState(() {
                                  booked = true;
                                });
                                showModalBottomSheet<void>(
                                    useSafeArea: true,
                                    backgroundColor: Color(0xff243b55),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20))),
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Column(
                                        children: [
                                          SizedBox(
                                            height: height * 0.1,
                                          ),
                                          CircleAvatar(
                                            backgroundImage: AssetImage(
                                              "Course_Images/Congratulations.png",
                                            ),
                                            radius: height * 0.1,
                                          ),
                                          SizedBox(
                                            height: height * 0.05,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: width * 0.05),
                                            child: Text(
                                              "Yor are now registered to teach FISHING in KANPUR, UTTAR PRADESH",
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.raleway(
                                                  color: Colors.white,
                                                  fontSize: 20),
                                            ),
                                          ),
                                        ],
                                      );
                                    });
                              },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff243b55)),
                        child: Text(
                          booked ? "REGISTERED" : "REGISTER",
                          style: GoogleFonts.raleway(color: Colors.white),
                        )),
                    SizedBox(
                      height: height * 0.05,
                    ),
                  ],
                )
              ],
            ),
          );
  }
}
