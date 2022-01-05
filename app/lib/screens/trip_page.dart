import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:wonderlust/screens/custom_tour.dart';
import 'package:wonderlust/utilities/bottom_drawer.dart';
import 'package:wonderlust/utilities/side_drawer.dart';
import 'package:wonderlust/utilities/actionchip.dart';

class TripPage extends StatefulWidget {
  const TripPage({Key? key}) : super(key: key);

  @override
  _TripPageState createState() => _TripPageState();
}

class _TripPageState extends State<TripPage> {
  //date input
  //text input
  DateTime start = DateTime.now();
  DateTime end = DateTime.now();
  final num_people = TextEditingController();
  var choices = new Map();
  var num_days = 0;
  int passengers = 0;
  List<String> interests = [];
  int _calculate_duration(DateTime s, DateTime e) {
    return e.difference(s).inDays.toInt();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'New Trip',
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(32),
        children: [
          Text(
            'Enter Trip Details',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          Divider(
            height: 20,
            color: Colors.white,
          ),
          DateTimeFormField(
            mode: DateTimeFieldPickerMode.date,
            decoration: InputDecoration(
              labelText: 'Enter Start Date',
              border: OutlineInputBorder(),
              icon: Icon(Icons.event_note),
            ),
            onDateSelected: (DateTime value) {
              start = value;
              print(value);
            },
          ),
          SizedBox(
            height: 10,
          ),
          DateTimeFormField(
            mode: DateTimeFieldPickerMode.date,
            decoration: InputDecoration(
              labelText: 'Enter End Date',
              border: OutlineInputBorder(),
              icon: Icon(Icons.event_note),
            ),
            onDateSelected: (DateTime value) {
              end = value;
              print(value);
              num_days = _calculate_duration(start, end);
            },
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            decoration: InputDecoration(
              icon: Icon(Icons.people_alt),
              labelText: 'Passengers',
              border: OutlineInputBorder(),
            ),
            controller: num_people,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Tell us about your Interests',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          Divider(
            height: 10,
            color: Colors.white,
          ),
          Wrap(
            runSpacing: 0,
            spacing: 10,
            children: [
              Actionchip(chipName: 'Religious', choices: choices),
              Actionchip(chipName: 'Entertainment', choices: choices),
              Actionchip(chipName: 'Parks', choices: choices),
              Actionchip(chipName: 'Historical Site', choices: choices),
              Actionchip(chipName: 'Shopping', choices: choices),
            ],
          ),
          Divider(
            height: 10,
            color: Colors.white,
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                  Theme.of(context).colorScheme.secondary),
            ),
            onPressed: () {
              print('Start Date: $start');
              print('End Date: $end');
              print('Number of days: $num_days');
              passengers = int.parse(num_people.text);
              print('Passengers: $passengers');
              interests.clear();
              choices.forEach((key, value) {
                if (value == true) {
                  interests.add(key);
                }
              });
              print('Choices: $interests');

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CustomTourPage(
                      start: start,
                      end: end,
                      num_people: passengers,
                      num_days: num_days,
                      choices: interests),
                ),
              );
            },
            child: Text(
              'Submit',
              style: TextStyle(color: Colors.black),
            ),
          )
        ],
      ),
      drawer: SideDrawer(),
      bottomNavigationBar: BottomDrawer(),
    );
  }
}
