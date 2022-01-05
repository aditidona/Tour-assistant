import 'package:flutter/material.dart';
import 'package:wonderlust/utilities/bottom_drawer.dart';
import 'package:wonderlust/utilities/side_drawer.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account details'),
      ),
      drawer: SideDrawer(),
      bottomNavigationBar: BottomDrawer(),
    );
  }
}
