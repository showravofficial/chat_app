import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../authentication/auth_service.dart';
import 'chat_service.dart';
import 'message_list.dart';
import 'message_input.dart';

class ChatScreen extends StatelessWidget {
  final ChatService _chatService = ChatService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await AuthService().signOut();
              context.go('/login');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(child: MessageList(messageStream: _chatService.getMessages())),
          MessageInput(),
        ],
      ),
    );
  }
}
