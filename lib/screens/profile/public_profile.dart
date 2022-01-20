import 'package:books_app/constants/routes.dart';
import 'package:books_app/providers/books.dart';
import 'package:books_app/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PublicProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String ownedBooksLength =
        Provider.of<Books>(context).ownedBooks.length.toString();
    final String borrowedBooksLength =
        Provider.of<Books>(context).borrowedBooks.length.toString();
    final String lentBooksLength =
        Provider.of<Books>(context).lentBooks.length.toString();
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Icon(
                      Icons.settings,
                      size: 24.0,
                      color: Color(0xFF200E32),
                    ),
                    Text(
                      'My Profile',
                      style: GoogleFonts.poppins(
                          color: Colors.black87,
                          fontWeight: FontWeight.w300,
                          fontSize: 26),
                    ),
                    Text(
                      'Logout',
                      style: GoogleFonts.poppins(
                          color: Colors.black87,
                          fontWeight: FontWeight.w400,
                          fontSize: 13),
                    )
                  ],
                ),
              ),
              flex: 15,
            ),
            Expanded(
              child: Column(
                children: <Widget>[
                  const Expanded(
                    child: CircleAvatar(
                      radius: 100,
                      backgroundImage:
                          AssetImage('assets/images/placeholder.PNG'),
                    ),
                    flex: 60,
                  ),
                  Expanded(
                    child: Text(
                      'John Doe',
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 36,
                          fontWeight: FontWeight.w400),
                    ),
                    flex: 15,
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(top: 5),
                      child: Text(
                        'SAN FRANCISCO,CA',
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    flex: 15,
                  ),
                ],
              ),
              flex: 40,
            ),
            const Divider(
              color: Colors.black54,
            ),
            Expanded(
              flex: 25,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    'User Stats',
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.w400),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(ownedBooksLength,
                              style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w400)),
                          const Text('Owned Books')
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Text(lentBooksLength,
                              style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w400)),
                          const Text('Lent Books')
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Text(borrowedBooksLength,
                              style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w400)),
                          const Text('Borrowed Books')
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Button(
                    name: 'My Library',
                    myFunction: () {},
                    color: const Color(0xFF06070D),
                  ),
                  Button(
                    name: 'Edit Profile',
                    myFunction: () {},
                    color: const Color(0xFF0FB269),
                  ),
                  Button(
                    name: 'Change Preferences',
                    myFunction: () {
                      Navigator.pushNamed(context, Routes.PRIVATE_PROFILE);
                    },
                    color: const Color(0xFF0FB269),
                  ),
                ],
              ),
              flex: 25,
            ),
          ],
        ),
      ),
    );
  }
}
