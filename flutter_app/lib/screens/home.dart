import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            width: double.infinity,
            height: 30,
          ),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: const Color(0xff243b55),
                borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: [
                Text(
                  "Want to become a Volunteer?",
                  style: GoogleFonts.raleway(color: Colors.white, fontSize: 20),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {},
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.white),
                    child: Text(
                      "EXPLORE NOW",
                      style:
                          GoogleFonts.raleway(color: const Color(0xff243b55)),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
