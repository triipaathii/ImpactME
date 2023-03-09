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
    return Center(
      child: Text(
        "FEEDS",
        style: GoogleFonts.raleway(),
      ),
    );
  }
}
