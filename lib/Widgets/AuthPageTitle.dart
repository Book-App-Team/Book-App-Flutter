import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthPageTitle extends StatelessWidget {
  final String name;

  AuthPageTitle({this.name});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 8.0, bottom: 20),
      child: Text(
        this.name,
        style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 36),
      ),
    );
  }
}
