import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wonderlust/utilities/bottom_drawer.dart';
import 'package:wonderlust/utilities/side_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      drawer: SideDrawer(),
      body: SafeArea(
        child: Column(
          children: [
            Text(
              'Hi Aditi !',
              style: GoogleFonts.lato(
                textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, left: 10),
              child: Text(
                'Let\'s explore a new city !',
                style: GoogleFonts.lato(
                    textStyle: TextStyle(
                  fontSize: 15,
                )),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomDrawer(),
    );
  }
}
