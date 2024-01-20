import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:humorfy/pages/messages.dart';

class ChatService extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Sending message
  Future<void> sendMessage(String receiverId, String messageBody) async {
    // Get user info
    final String currUserId = _firebaseAuth.currentUser!.uid;
    final String currUserEmail = _firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    // create a new message
    Message newMessage = Message(
        senderId: currUserId,
        senderEmail: currUserEmail,
        receiverId: receiverId,
        messageBody: messageBody,
        timestamp: timestamp);

    // ensure that the chat room id is always the same
    List<String> ids = [currUserId, receiverId];
    ids.sort();
    String chatRoomId = ids.join('_');

    // Add the message to the database
    await _firestore
        .collection('chat')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toMap());
  }

  // Getting messages
  Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatId = ids.join("_");

    return _firestore
        .collection('chat')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
