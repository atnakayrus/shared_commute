import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Appstyle {
  TextStyle buttonText = GoogleFonts.poppins(
    fontSize: 22,
    color: Colors.white,
  );
  TextStyle headerText = GoogleFonts.poppins(
    fontSize: 48,
    color: const Color(0xFF111111),
  );
  TextStyle titleText = GoogleFonts.poppins(
    fontSize: 32,
    color: const Color(0xFF111111),
  );
  TextStyle mainText = GoogleFonts.poppins(
    fontSize: 24,
    color: const Color(0xFF111111),
  );
  TextStyle subtitleText = GoogleFonts.poppins(
    fontSize: 22,
    color: const Color(0xFF111111),
  );
  TextStyle contentText = GoogleFonts.poppins(
    fontSize: 18,
    color: const Color(0xFF111111),
  );
  TextStyle helperText = GoogleFonts.poppins(
    fontSize: 14,
    color: const Color(0xFF111111),
  );
  Color brandColor = Colors.purple;
  Color buttonActiveColor = Colors.purple;
  Color buttonDisabledColor = Colors.purple[200]!;

  double scUserIconSize = 100;
  double scChatIconSize = 64;
  double scIconSize = 32;
}
