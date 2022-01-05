import 'package:flutter/material.dart';

class SideDrawer extends StatefulWidget {
  const SideDrawer({Key? key}) : super(key: key);

  @override
  _SideDrawerState createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(),
            child: Text(
              'Hi, Wanderer !',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
              leading: Icon(Icons.airplanemode_on_rounded),
              title: Text('Memories'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/home'); //add memory page here
              }),
          ListTile(
              leading: Icon(Icons.account_circle_outlined),
              title: Text('Profile'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/account'); //add memory page here
              }),
          ListTile(
            leading: Icon(Icons.feedback_outlined),
            title: Text('Send Us Feedback'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.star_border),
            title: Text('Rate Us'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
