import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VolunteerHomepage extends StatefulWidget {
  const VolunteerHomepage({super.key});

  @override
  State<VolunteerHomepage> createState() => _VolunteerHomepageState();
}

class _VolunteerHomepageState extends State<VolunteerHomepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "VOLUNTEER HOMEPAGE",
          style: GoogleFonts.raleway(),
        ),
      ),
    );
  }
}