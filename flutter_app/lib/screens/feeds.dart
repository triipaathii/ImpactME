import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Feeds extends StatefulWidget {
  const Feeds({super.key});

  @override
  State<Feeds> createState() => _FeedsState();
}

class _FeedsState extends State<Feeds> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: height * 0.02,
          ),
          for (int i = 0; i < 5; i++) ...[
            Padding(
              padding: EdgeInsets.symmetric(vertical: height * 0.01),
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
                              CircleAvatar(
                                backgroundImage: AssetImage(
                                  "assets/images/anurag.jpg",
                                ),
                                radius: height * 0.03,
                              ),
                              SizedBox(
                                width: width * 0.02,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Anurag Tripathi",
                                    style: GoogleFonts.raleway(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "Kanpur, Uttar Pradesh",
                                    style: GoogleFonts.raleway(fontSize: 13),
                                  )
                                ],
                              )
                            ],
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(CupertinoIcons.ellipsis_vertical))
                        ],
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          "assets/images/anurag.jpg",
                          height: height * 0.3,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: Icon(CupertinoIcons.heart)),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(CupertinoIcons.text_bubble)),
                          Flexible(
                            fit: FlexFit.tight,
                            // child: DotsIndicator(
                            //   dotsCount: 4,
                            //   decorator: DotsDecorator(
                            //       color: Colors.grey.shade600,
                            //       activeColor: Colors.white,
                            //       spacing: EdgeInsets.all(3),
                            //       activeSize: Size.square(height * 0.01),
                            //       size: Size.square(height * 0.008)),
                            // )
                            child: Container(),
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(CupertinoIcons.bookmark)),
                          IconButton(
                              onPressed: () {}, icon: Icon(Icons.share_rounded))
                        ],
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: width * 0.015),
                        child: Text(
                          "How to Add Icon in Flutter App? You can use Icon() widget to add icons to your Flutter App. You have to pass the icon data as an icon to this widget. You can use default available Material icons with Icons class.",
                          style: GoogleFonts.raleway(),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Center(
                        child: Text(
                          "23rd Mar, 2022 | 12:03PM",
                          style: GoogleFonts.raleway(
                              fontWeight: FontWeight.bold, fontSize: 13),
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
