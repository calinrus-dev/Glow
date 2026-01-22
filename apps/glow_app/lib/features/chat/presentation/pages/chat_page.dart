import 'package:flutter/material.dart';

/// Chat conversation page.
class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
      ),
      body: const Center(
        child: Text('Chat Conversation - TODO'),
      ),
    );
  }
}
