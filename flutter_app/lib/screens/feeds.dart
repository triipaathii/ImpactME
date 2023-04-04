import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Feeds extends StatefulWidget {
  const Feeds({super.key});

  @override
  State<Feeds> createState() => _FeedsState();
}

class _FeedsState extends State<Feeds> {
  final db = FirebaseFirestore.instance;
  bool isLoading = true;
  bool? isVolunteer;
  String? userId;

  final feeds = [];

  Future<void> _loadFeeds() async {
    await db.collection("feeds").get().then((event) {
      for (var doc in event.docs) {
        setState(() {
          feeds.add(doc.data());
        });
      }
    });
    print("=================== FEEDS =================");
    print(feeds);
    setState(() {
      isLoading = false;
    });
  }

  Future<void> _loadUserBasicDetails() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = (prefs.getString("userId") ?? null);
      isVolunteer = (prefs.getBool('isVolunteer') ?? false);
    });
  }

  @override
  void initState() {
    _loadUserBasicDetails();
    _loadFeeds();
    super.initState();
  }

  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    // final feeds = startAsyncInit();
    return isLoading
        ? Center(
            child: CircularProgressIndicator(
              color: Color(0xff243b55),
            ),
          )
        : feeds.length == 0
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.auto_stories_outlined,
                    color: Colors.grey.shade400,
                    size: 50,
                  ),
                  SizedBox(
                    height: height * 0.02,
                    width: double.infinity,
                  ),
                  Text(
                    "No feeds found...",
                    style: GoogleFonts.raleway(
                        color: Colors.grey.shade400, fontSize: 18),
                  )
                ],
              )
            : ListView.builder(itemBuilder: (context, index) {
                String userName = "";
                String feedUserProfilePhotoUrl = "";
                bool isLoading = true;
                db.collection("users").doc(userId).get().then((value) {
                  setState(() {
                    userName = value.data()!['name'];
                    feedUserProfilePhotoUrl =
                        value.data()!['profile_picture_path'];
                  });
                });
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: height * 0.01),
                  child: Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(color: Color(0xff243b55))),
                    child:isLoading
                    ? Center(
                      child: CircularProgressIndicator(
                        color: Color(0xff243b55),
                      ),
                    ) 
                    :
                    Padding(
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
                                    backgroundImage: feedUserProfilePhotoUrl !=
                                            null
                                        ? NetworkImage(feedUserProfilePhotoUrl)
                                            as ImageProvider
                                        : AssetImage("assets/images/man.png"),
                                    radius: height * 0.03,
                                  ),
                                  SizedBox(
                                    width: width * 0.02,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "$userName",
                                        style: GoogleFonts.raleway(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "${feeds[index]['location']['city']}, ${feeds[index]['location']['state']}, ${feeds[index]['location']['country']}",
                                        style:
                                            GoogleFonts.raleway(fontSize: 13),
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
                          Image.asset(
                            "${feeds[index]['image_path']}",
                            height: height * 0.3,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          // Row(
                          //   children: [
                          //     badges.Badge(
                          //       badgeContent: Text(
                          //         "${feeds[index]['likes']}",
                          //         style: GoogleFonts.raleway(
                          //             color: Colors.white),
                          //       ),
                          //       badgeStyle: badges.BadgeStyle(
                          //         badgeColor: Color(0xff243b55),
                          //       ),
                          //       showBadge:
                          //           int.parse(feeds[index]['likes']!.toString()) > 0
                          //               ? true
                          //               : false,
                          //       position: badges.BadgePosition.topEnd(
                          //           end: -width * 0.0075,
                          //           top: -height * 0.005),
                          //       child: IconButton(
                          //           onPressed: () {},
                          //           icon: feeds[index]['user_liked'] != null
                          //               ? Icon(
                          //                   CupertinoIcons.heart_fill,
                          //                   color: Colors.red,
                          //                 )
                          //               : Icon(CupertinoIcons.heart)),
                          //     ),
                          //     badges.Badge(
                          //       badgeContent: Text(
                          //         "${feeds[index]['comments']}",
                          //         style: GoogleFonts.raleway(
                          //             color: Colors.white),
                          //       ),
                          //       showBadge:
                          //           int.parse(feeds[index]['comments']!.toString()) >
                          //                   0
                          //               ? true
                          //               : false,
                          //       badgeStyle: badges.BadgeStyle(
                          //           badgeColor: Color(0xff243b55),
                          //           padding: EdgeInsets.all(6)),
                          //       position: badges.BadgePosition.topEnd(
                          //           end: -width * 0.0075,
                          //           top: -height * 0.005),
                          //       child: IconButton(
                          //           onPressed: () {},
                          //           icon: Icon(CupertinoIcons.text_bubble)),
                          //     ),
                          //     Flexible(
                          //       fit: FlexFit.tight,
                          //       // child: DotsIndicator(
                          //       //   dotsCount: 4,
                          //       //   decorator: DotsDecorator(
                          //       //       color: Colors.grey.shade600,
                          //       //       activeColor: Colors.white,
                          //       //       spacing: EdgeInsets.all(3),
                          //       //       activeSize: Size.square(height * 0.01),
                          //       //       size: Size.square(height * 0.008)),
                          //       // )
                          //       child: Container(),
                          //     ),
                          //     IconButton(
                          //         onPressed: () {},
                          //         icon: Icon(CupertinoIcons.bookmark)),
                          //     IconButton(
                          //         onPressed: () {},
                          //         icon: Icon(Icons.share_rounded))
                          //   ],
                          // ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: width * 0.015),
                            child: Text(
                              "${feeds[index]['description']}",
                              textAlign: TextAlign.justify,
                              style: GoogleFonts.raleway(),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          Center(
                            child: Text(
                              "${feeds[index]['timestamp']}",
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
                );
              });
  }
}
