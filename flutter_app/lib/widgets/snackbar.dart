import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void showSnackBar(String message, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.redAccent.shade700,
      duration: Duration(seconds: 2),
      content: Text(message,
          textAlign: TextAlign.center,
          style: GoogleFonts.raleway(color: Colors.white, fontSize: 16.0))));
}
