import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/courses.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class Business extends StatefulWidget {
  const Business({super.key});

  @override
  State<Business> createState() => _BusinessState();
}

class _BusinessState extends State<Business> {
  int currentCarouselPageIndex = 0;

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
          SizedBox(
            height: 40,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.1),
              child: AnimatedTextKit(repeatForever: true, animatedTexts: [
                TyperAnimatedText("Support",
                    textAlign: TextAlign.center,
                    textStyle: GoogleFonts.raleway(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff243b55)),
                    speed: const Duration(milliseconds: 70)),
                FadeAnimatedText(
                  "A DREAM",

                  textAlign: TextAlign.center,
                  textStyle: GoogleFonts.raleway(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff243b55)),
                  // speed: const Duration(milliseconds: 70)
                ),
                TyperAnimatedText("not a BUSINESS",
                    textAlign: TextAlign.center,
                    textStyle: GoogleFonts.raleway(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff243b55)),
                    speed: const Duration(milliseconds: 70))
              ]),
            ),
          ),
          SizedBox(
            height: height * 0.03,
          ),
          CarouselSlider(
              items: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/images/promo1.png',
                    fit: BoxFit.cover,
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/images/promo2.png',
                    fit: BoxFit.cover,
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/images/promo3.png',
                    fit: BoxFit.cover,
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/images/promo4.png',
                    fit: BoxFit.cover,
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/images/promo5.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
              options: CarouselOptions(
                  onPageChanged: (index, carouselPageChangedReason) {
                    setState(() {
                      currentCarouselPageIndex = index;
                    });
                  },
                  autoPlay: true,
                  autoPlayAnimationDuration: Duration(seconds: 1),
                  autoPlayCurve: Curves.decelerate,
                  enableInfiniteScroll: true,
                  viewportFraction: 1,
                  enlargeCenterPage: true,
                  enlargeStrategy: CenterPageEnlargeStrategy.scale)),
          SizedBox(
            height: height * 0.02,
          ),
          DotsIndicator(
            dotsCount: 7,
            position: double.parse(currentCarouselPageIndex.toString()),
            decorator: DotsDecorator(
                color: Colors.grey,
                activeColor: Color(0xff243b55),
                spacing: EdgeInsets.all(3),
                activeSize: Size.square(height * 0.01),
                size: Size.square(height * 0.008)),
          ),
          // Flexible(
          //   child: Carousel(
          //     images: [
          //       Image.asset(
          //         'assets/images/prom1.jpg',
          //         fit: BoxFit.cover,
          //       ),
          //       Image.asset(
          //         'assets/images/prom2.jpg',
          //         fit: BoxFit.cover,
          //       ),
          //       Image.asset(
          //         'assets/images/prom3.jpg',
          //         fit: BoxFit.cover,
          //       ),
          //       Image.asset(
          //         'assets/images/prom4.jpg',
          //         fit: BoxFit.cover,
          //       ),
          //       Image.asset(
          //         'assets/images/prom5.jpg',
          //         fit: BoxFit.cover,
          //       ),
          //       Image.asset(
          //         'assets/images/prom6.jpg',
          //         fit: BoxFit.cover,
          //       ),
          //       Image.asset(
          //         'assets/images/prom7.jpg',
          //         fit: BoxFit.cover,
          //       )
          //     ],
          //   ),
          // ),
          SizedBox(
            height: height * 0.03,
          ),
          for (var promotion in promotions) ...[
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: height * 0.02, horizontal: width * 0.02),
              child: Card(
                elevation: 1,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(color: Color(0xff243b55))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SizedBox(height: height * 0.01),
                      Text(
                        "${promotion['user_name']}",
                        style: GoogleFonts.raleway(
                            fontWeight: FontWeight.bold,
                            fontSize: 35,
                            color: Color(0xff243b55)),
                      ),
                      Text(
                        "${promotion['location']}",
                        style: GoogleFonts.raleway(
                            fontSize: 13, color: Color(0xff243b55)),
                      ),
                      SizedBox(height: height * 0.02),
                      Text(
                        "${promotion['contact_number']}",
                        style: GoogleFonts.raleway(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Color(0xff243b55)),
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
                        height: height * 0.03,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: width * 0.015),
                        child: Text(
                          "${promotion['description']}",
                          textAlign: TextAlign.justify,
                          style: GoogleFonts.raleway(color: Color(0xff243b55)),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.01,
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
