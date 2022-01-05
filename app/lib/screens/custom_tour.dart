import 'package:flutter/material.dart';
import 'package:wonderlust/utilities/side_drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CustomTourPage extends StatefulWidget {
  final DateTime start;
  final DateTime end;
  final int num_people;
  final int num_days;
  final List choices;
  const CustomTourPage(
      {Key? key,
      required this.start,
      required this.end,
      required this.num_people,
      required this.num_days,
      required this.choices})
      : super(key: key);
  @override
  _CustomTourPageState createState() => _CustomTourPageState();
}

class _CustomTourPageState extends State<CustomTourPage> {
  List<List<String>> plan = [];
  List<String> master = [];

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _stream = FirebaseFirestore.instance
        .collection('places')
        .where('category', whereIn: widget.choices)
        .orderBy('rank')
        .snapshots();

    return Scaffold(
      appBar: AppBar(
        title: Text('My Tour'),
      ),
      body: StreamBuilder(
        stream: _stream,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          List<List<Map<String, dynamic>>> plan = [];
          int count = 0;
          for (int i = 0;
              i < snapshot.data!.docs.length && count < widget.num_days;
              i += widget.choices.length) {
            List<Map<String, dynamic>> day = [];
            for (int j = i; j < i + widget.choices.length; j++) {
              if (j < snapshot.data!.docs.length) {
                day.add(snapshot.data!.docs[j].data() as Map<String, dynamic>);
              }
            }
            plan.add(day);
            print(plan);
            count++;
          }

          return ListView.builder(
              itemCount: plan.length,
              itemBuilder: (context, day_num) {
                return Column(
                  children: [
                    Text(
                      'Day ${day_num + 1}',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    Divider(
                      height: 20,
                      color: Colors.white,
                      thickness: 5,
                    ),
                    Container(
                      height: 200,
                      //width: 200,
                      child: ListView.builder(
                          // scrollDirection: Axis.horizontal,
                          itemCount: plan[day_num].length,
                          itemBuilder: (context, index) {
                            print(day_num);
                            return Card(
                              child: ListTile(
                                title: Text(plan[day_num][index]['place']),
                              ),
                            );
                          }),
                    )
                  ],
                );
              });
        },
      ),
      drawer: SideDrawer(),
    );
  }
}
