import 'package:flutter/material.dart';
import 'package:scorp/widgets/app_bar.dart';

class ChatBotPage extends StatelessWidget {
  const ChatBotPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: ScorpAppBar(title: 'Chat Bot'),
      body: Center(
        child: Text(
          "Chatbot Interface Coming Soon!",
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
}
