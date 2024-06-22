import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {
  final CollectionReference chatCollection = FirebaseFirestore.instance.collection('chats');

  Stream<QuerySnapshot> getMessages() {
    return chatCollection.orderBy('timestamp', descending: true).snapshots();
  }

  Future<void> sendMessage(String text, String userId) async {
    await chatCollection.add({
      'text': text,
      'userId': userId,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
}
