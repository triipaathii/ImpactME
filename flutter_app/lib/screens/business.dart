import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/courses.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:badges/badges.dart' as badges;
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:carousel_pro/carousel_pro.dart';

class Business extends StatefulWidget {
  const Business({super.key});

  @override
  State<Business> createState() => _BusinessState();
}

class _BusinessState extends State<Business> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: height * 0.03,
          ),
          Align(
            alignment: Alignment.center,
            child: AnimatedTextKit(animatedTexts: [
              TyperAnimatedText("  Support a dream not a business  ",
              textStyle: GoogleFonts.raleway(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color(0xff243b55)
              ))
            ])
          ),
          SizedBox(
            height: height*0.03,
          ),
          Center(
            child: ListView(
              children: [
                SizedBox(
                  height: 200.0,
                  width: double.infinity,
                  child: Carousel(
                    images: [Image.asset('assets/images/prom1.jpg', fit: BoxFit.cover,),
                    Image.asset('assets/images/prom2.jpg', fit: BoxFit.cover,),
                    Image.asset('assets/images/prom3.jpg', fit: BoxFit.cover,),
                    Image.asset('assets/images/prom4.jpg', fit: BoxFit.cover,),
                    Image.asset('assets/images/prom5.jpg', fit: BoxFit.cover,),
                    Image.asset('assets/images/prom6.jpg', fit: BoxFit.cover,),
                    Image.asset('assets/images/prom7.jpg', fit: BoxFit.cover,)],
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: height*0.03,
          ),
          for (var promotion in promotions) ...[
            Padding(
              padding: EdgeInsets.symmetric(vertical: height * 0.02, horizontal: width*0.02),
              child: Card(
                elevation: 1,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(color: Color(0xff243b55))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: width*0.03,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${promotion['user_name']}",
                                    style: GoogleFonts.raleway(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 40,
                                        color: Color(0xff243b55)),
                                  ),
                                  Text(
                                    "${promotion['location']}",
                                    style: GoogleFonts.raleway(fontSize: 13, color: Color(0xff243b55)),
                                  )
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          "${promotion['image_path']}",
                          height: height * 0.4,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        height: height*0.03,
                        width: width,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: width * 0.015),
                        child: Text(
                          "${promotion['description']}",
                          style: GoogleFonts.raleway(
                            color: Color(0xff243b55)
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Center(
                        child: Text(
                          "${promotion['timestamp']}",
                          style: GoogleFonts.raleway(
                              fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xff243b55)),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
          SizedBox(
            height: height * 0.03,
          )
        ],
      ),
    );
  }
}

