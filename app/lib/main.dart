import 'package:flutter/material.dart';
import 'package:wonderlust/screens/account_screen.dart';
import 'package:wonderlust/screens/chatbot_screen.dart';
import 'package:wonderlust/screens/home_page.dart';
import 'package:wonderlust/screens/memories.dart';
import 'package:wonderlust/screens/translator_page.dart';
import 'package:wonderlust/screens/trip_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:wonderlust/screens/login-screen.dart';
import 'package:wonderlust/screens/create-new-account.dart';
import 'package:wonderlust/screens/forgot-screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'authenthication/auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: HomPage(),
      initialRoute: '/login',
      routes: {
        '/home': (context) => HomPage(),
        '/chatbot': (context) => ChatbotPage(),
        '/trip': (context) => TripPage(),
        '/translator': (context) => TranslatorPage(),
        '/story': (context) => StoryPage(),
        '/account': (context) => AccountScreen(),
        '/login': (context) => LoginScreen(),
        'ForgotPassword': (context) => ForgotPassword(),
        '/createnewaccount': (context) => CreateNewAccount(),
      },
    );
  }
}

class HomPage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
      future: currantUserhere(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          User? user = snapshot.data;
          return HomePage(uid: user!.uid); //TasksPage(uid: user.uid);
        } else {
          return LoginScreen();
        }
      },
    );
  }
}
