import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Jobs extends StatefulWidget {
  const Jobs({super.key});

  @override
  State<Jobs> createState() => _JobsState();
}

class _JobsState extends State<Jobs> {
  bool isLoading = true;
  List<Map<String, dynamic>> jobs = [];

  final db = FirebaseFirestore.instance;

  Future<void> _loadJobs() async {
    await db.collection("jobs").get().then((event) {
      for (var doc in event.docs) {
        print("${doc.id} => ${doc.data()}");
        setState(() {
          jobs.add(doc.data());
        });
      }
    });
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    _loadJobs();
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
              children: [
                SizedBox(
                  height: height * 0.02,
                ),
                for (var job in jobs) ...[
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: height * 0.01, horizontal: width * 0.01),
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
                                        "${job['company_image']}",
                                      ),
                                      radius: height * 0.05,
                                    ),
                                    SizedBox(
                                      width: width * 0.03,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${job['company_name']}",
                                          style: GoogleFonts.raleway(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "${job['location']}",
                                          style:
                                              GoogleFonts.raleway(fontSize: 14),
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
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.05),
                              child: RichText(
                                  textAlign: TextAlign.start,
                                  text: TextSpan(
                                      style: GoogleFonts.raleway(
                                          color: Colors.black, fontSize: 14),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: "\nJOB DESCRIPTION:\n\n",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        TextSpan(
                                          text: "${job['job_description']}",
                                        ),
                                        TextSpan(
                                            text: "\n\nSKILLS REQUIRED:\n",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        TextSpan(text: "${job['skills']}\n"),
                                        TextSpan(
                                            text: "\nGENDER:\n",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        TextSpan(
                                            text:
                                                "${job['preferred_gender']}\n"),
                                        TextSpan(
                                            text: "\nSALARY:\n",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        TextSpan(text: "${job['salary']}\n"),
                                        TextSpan(
                                            text: "\nCONTACT US:\n",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        TextSpan(
                                            text:
                                                "${job['contact_details']}\n"),
                                      ])),
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            Center(
                              child: Text(
                                "${job['timestamp']}",
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
