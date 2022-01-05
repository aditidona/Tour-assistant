import 'package:flutter/material.dart';
import 'package:wonderlust/utilities/bottom_drawer.dart';
import 'package:wonderlust/utilities/side_drawer.dart';
import 'package:kommunicate_flutter/kommunicate_flutter.dart';

class ChatbotPage extends StatefulWidget {
  const ChatbotPage({Key? key}) : super(key: key);

  @override
  _ChatbotPageState createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  void _chatbot() async {
    try {
      dynamic conversationObject = {
        'appId':
            '2ef5e0555ec37acf1de2419776cf5003c' // The [APP_ID](https://dashboard.kommunicate.io/settings/install) obtained from kommunicate dashboard.
      };
      dynamic result =
          await KommunicateFlutterPlugin.buildConversation(conversationObject);
      print("Conversation builder success : " + result.toString());
    } on Exception catch (e) {
      print("Conversation builder error occurred : " + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat With Us'),
      ),
      floatingActionButton: FloatingActionButton(onPressed: _chatbot),
      drawer: SideDrawer(),
      bottomNavigationBar: BottomDrawer(),
    );
  }
}
