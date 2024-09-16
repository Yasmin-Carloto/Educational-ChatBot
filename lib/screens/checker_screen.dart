import 'package:chatbot/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'insert_api_key_screen.dart';

class CheckerScreen extends StatefulWidget {
  @override
  _CheckerScreenState createState() => _CheckerScreenState();
}

class _CheckerScreenState extends State<CheckerScreen> {
  @override
  void initState() {
    super.initState();
    _switchScreen();
  }

  Future<void> _switchScreen() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? savedApiKey = preferences.getString("chatgpt_api_key");

    if(savedApiKey != null){
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ChatScreen()
        )
      );
    }else{
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const InsertApiKeyScreen()
        )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
