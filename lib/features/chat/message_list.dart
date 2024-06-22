import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'message.dart';

class MessageList extends StatelessWidget {
  final Stream<QuerySnapshot> messageStream;

  MessageList({required this.messageStream});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: messageStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        final messages = snapshot.data!.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          return Message(
            text: data['text'],
            userId: data['userId'],
            isMine: data['userId'] == FirebaseAuth.instance.currentUser?.uid,
          );
        }).toList();

        return ListView(
          reverse: true,
          children: messages,
        );
      },
    );
  }
}
