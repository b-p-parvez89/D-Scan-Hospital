// chat_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {
  final CollectionReference _messagesCollection =
      FirebaseFirestore.instance.collection('messages');

  Stream<QuerySnapshot> getMessages() {
    return _messagesCollection.orderBy('timestamp').snapshots();
  }

  Future<void> sendMessage(String text, String sender) async {
    await _messagesCollection.add({
      'text': text,
      'sender': sender,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
}
