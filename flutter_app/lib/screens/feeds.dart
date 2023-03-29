import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:badges/badges.dart' as badges;
import 'package:shared_preferences/shared_preferences.dart';

class Feeds extends StatefulWidget {
  const Feeds({super.key});

  @override
  State<Feeds> createState() => _FeedsState();
}

class _FeedsState extends State<Feeds> {
  final firestoreDb = FirebaseFirestore.instance.collection("feeds");
  bool isLoading = true;
  bool? isVolunteer;
  String? userId;

  final feeds = [];

  Future<void> _loadFeeds() async {
    await firestoreDb.get().then((event) {
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
        : SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.02,
                ),
                for (var feed in feeds) ...[
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
                                        "${feed['user_image']}",
                                      ),
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
                                          "${feed['user_name']}",
                                          style: GoogleFonts.raleway(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "${feed['location']}",
                                          style:
                                              GoogleFonts.raleway(fontSize: 13),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                IconButton(
                                    onPressed: () {},
                                    icon:
                                        Icon(CupertinoIcons.ellipsis_vertical))
                              ],
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            Image.asset(
                              "${feed['image_path']}",
                              height: height * 0.3,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                            Row(
                              children: [
                                badges.Badge(
                                  badgeContent: Text(
                                    "${feed['likes']}",
                                    style: GoogleFonts.raleway(
                                        color: Colors.white),
                                  ),
                                  badgeStyle: badges.BadgeStyle(
                                    badgeColor: Color(0xff243b55),
                                  ),
                                  showBadge:
                                      int.parse(feed['likes']!.toString()) > 0
                                          ? true
                                          : false,
                                  position: badges.BadgePosition.topEnd(
                                      end: -width * 0.0075,
                                      top: -height * 0.005),
                                  child: IconButton(
                                      onPressed: () {},
                                      icon: feed['user_liked'] != null
                                          ? Icon(
                                              CupertinoIcons.heart_fill,
                                              color: Colors.red,
                                            )
                                          : Icon(CupertinoIcons.heart)),
                                ),
                                badges.Badge(
                                  badgeContent: Text(
                                    "${feed['comments']}",
                                    style: GoogleFonts.raleway(
                                        color: Colors.white),
                                  ),
                                  showBadge:
                                      int.parse(feed['comments']!.toString()) >
                                              0
                                          ? true
                                          : false,
                                  badgeStyle: badges.BadgeStyle(
                                      badgeColor: Color(0xff243b55),
                                      padding: EdgeInsets.all(6)),
                                  position: badges.BadgePosition.topEnd(
                                      end: -width * 0.0075,
                                      top: -height * 0.005),
                                  child: IconButton(
                                      onPressed: () {},
                                      icon: Icon(CupertinoIcons.text_bubble)),
                                ),
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
                                    onPressed: () {},
                                    icon: Icon(Icons.share_rounded))
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.015),
                              child: Text(
                                "${feed['description']}",
                                textAlign: TextAlign.justify,
                                style: GoogleFonts.raleway(),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            Center(
                              child: Text(
                                "${feed['timestamp']}",
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
