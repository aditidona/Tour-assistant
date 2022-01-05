import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wonderlust/utilities/bottom_drawer.dart';
import 'package:wonderlust/utilities/side_drawer.dart';
import '../services/api_service.dart';
import '../component/customListTile.dart';
import '../model/article_model.dart';

class HomePage extends StatefulWidget {
  late String uid;
  HomePage({Key? key, required this.uid}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState(uid);
}

class _HomePageState extends State<HomePage> {
  ApiService client = ApiService();
  late String uid;
  _HomePageState(this.uid);
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
            SizedBox(
              height: 25,
            ),
            Text(
              'Helloo User !',
              style: GoogleFonts.amaranth(
                textStyle: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, left: 10),
              child: Text(
                'Let\'s explore a new city !',
                style: GoogleFonts.amaranth(
                    textStyle: TextStyle(
                  fontSize: 20,
                )),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            SizedBox(
              width: 300,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/trip');
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blueGrey),
                ),
                child: Center(
                  child: Text(
                    "Start a new Trip Here",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            SizedBox(
              child: Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.blueGrey),
                    ),
                    child: Center(
                      child: Text(
                        "Restaurents",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.blueGrey),
                    ),
                    child: Center(
                      child: Text(
                        "Hotels",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.blueGrey),
                    ),
                    child: Center(
                      child: Text(
                        "Shopping",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              'News about your Safety',
              style: GoogleFonts.amaranth(
                textStyle: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.34,
              child: FutureBuilder(
                future: client.getArticle(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Article>> snapshot) {
                  //let's check if we got a response or not
                  print("snapshot data is :- $snapshot.data");
                  if (snapshot.hasData) {
                    //Now let's make a list of articles
                    List<Article>? articles = snapshot.data;
                    return ListView.builder(
                        //Now let's create our custom List tile
                        itemCount: articles!.length,
                        itemBuilder: (context, index) =>
                            customListTile(articles[index], context));
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomDrawer(),
    );
  }
}
