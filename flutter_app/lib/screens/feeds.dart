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
    await db.collection("feeds").get().then((event) async {
      for (var doc in event.docs) {
        await db
            .collection("users")
            .doc(doc.data()['userId'])
            .get()
            .then((value) {
          var map = doc.data();
          print(value.data());
          map['username'] = value.data()!['name'];
          map['user_profile_picture_path'] =
              value.data()!['profile_picture_path'];
          setState(() {
            feeds.add(map);
          });
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
            : ListView.builder(
                itemCount: feeds.length,
                itemBuilder: (context, index) {
                  return Padding(
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
                                      backgroundImage: feeds[index][
                                                  'user_profile_picture_path'] !=
                                              null
                                          ? NetworkImage(feeds[index][
                                                  'user_profile_picture_path']!)
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
                                          "${feeds[index]['username']}",
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
                                    icon:
                                        Icon(CupertinoIcons.ellipsis_vertical))
                              ],
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            Image.network(
                              "${feeds[index]['feed_image_path']}",
                              height: height * 0.3,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.015),
                              child: Text(
                                "${feeds[index]['description']}",
                                textAlign: TextAlign.justify,
                                style: GoogleFonts.raleway(),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            // Center(
                            //   child: Text(
                            //     "${feeds[index]['timestamp']}",
                            //     style: GoogleFonts.raleway(
                            //         fontWeight: FontWeight.bold, fontSize: 13),
                            //   ),
                            // ),
                            // SizedBox(
                            //   height: height * 0.01,
                            // ),
                          ],
                        ),
                      ),
                    ),
                  );
                });
  }
}
