import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:humorfy/main.dart';
import 'package:humorfy/pages/chat_service.dart';

class ChatPage extends StatefulWidget {
  final String name;
  final String receiverUserId;
  const ChatPage({super.key, required this.name, required this.receiverUserId});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Widget _buildSentMessagesItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    var alignment = (data['senderId'] != _firebaseAuth.currentUser!.uid);

    return SentMessage(
      messageBody: data['messageBody'],
      received: alignment,
    );
  }

  Widget _buildSentMessagesList() {
    return StreamBuilder(
        stream: _chatService.getMessages(
            widget.receiverUserId, _firebaseAuth.currentUser!.uid),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error:${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading..");
          }

          return ListView(
            children: snapshot.data!.docs
                .map((document) => _buildSentMessagesItem(document))
                .toList(),
          );
        });
  }

  void sendMessage() async {
    // Only calls send message if there is text to send
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.receiverUserId, _messageController.text);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        child: SizedBox(
          height: 1010,
          width: 1000,
          child: Scaffold(
            appBar: AppBar(
              title: Column(
                children: [
                  // Image.asset('assets/images/match.png', scale: 2.0),
                  Text(widget.name),
                ],
              ),
              leading: BackButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyApp()),
                ),
              ),
            ),
            backgroundColor: const Color.fromARGB(221, 55, 55, 55),
            body: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 0.0),
                child: Column(
                  children: [Expanded(child: _buildSentMessagesList())],
                ),
              ),
            ),
            bottomNavigationBar: Padding(
              padding:
                  const EdgeInsets.only(bottom: 0.0, left: 0.0, right: 0.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      cursorColor: Colors.blue,
                      controller: _messageController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          labelText: 'Type Message',
                          labelStyle: TextStyle(color: Colors.white)),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      sendMessage();
                    },
                    child: const Text('Send'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SentMessage extends StatelessWidget {
  final String messageBody;
  final bool received;
  const SentMessage(
      {super.key, required this.messageBody, required this.received});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          bottom: 10.0),
      child: Align(
        alignment: received ? Alignment.bottomLeft : Alignment.bottomRight,
        child: Container(
          decoration: BoxDecoration(
            color: received ? Colors.grey : Colors.blue,
            borderRadius: const BorderRadius.all(
              Radius.circular(15.0),
            ),
          ),
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
          child: Text(
            messageBody,
            style: const TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
