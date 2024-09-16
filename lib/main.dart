import 'package:chatbot/constants/constants.dart';
import 'package:chatbot/providers/chat_provider.dart';
import 'package:chatbot/screens/checker_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ChatProvider(), 
        )
      ],
      child: MaterialApp(
        title: 'Chatbot com ChatGPT',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: scaffoldBackgroundColor,
          appBarTheme: AppBarTheme(
            color: cardColor,
          ),
        ),
        home: CheckerScreen(), 
      ),
    );
  }
}
