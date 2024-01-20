import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:humorfy/pages/auth.dart';
import 'package:humorfy/pages/chat_page.dart';
import 'package:humorfy/pages/messages.dart';
import 'package:humorfy/pages/path.dart';
import 'package:humorfy/pages/info.dart';
import 'package:humorfy/pages/profile.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() async {
  runApp(const MyApp());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    Future checkUserStatus() async {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        return null;
      } else {
        var userDoc =
            FirebaseFirestore.instance.collection("users").doc(user.uid);
        return await userDoc.get().then((snapshot) => snapshot.exists);
      }
    }

    return MaterialApp(
        title: "Humorfy",
        home: DefaultTabController(
            length: 3,
            child: FutureBuilder(
              future: checkUserStatus(),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return const AuthPage();
                } else if (snapshot.data == true) {
                  return const Views();
                } else {
                  return const InfoPage();
                }
              },
            )));
  }
}

class Views extends StatelessWidget {
  const Views({super.key});

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      // Remove shadow
      shape: const LinearBorder(),
      bottom: const TabBar(tabs: [
        Padding(
          padding: EdgeInsets.only(bottom: 40.0),
          child: Tab(icon: Icon(Icons.house, size: 45.0)),
        ),
        Padding(
            padding: EdgeInsets.only(bottom: 40.0),
            child: Tab(icon: Icon(Icons.message_rounded, size: 45.0))),
        Padding(
            padding: EdgeInsets.only(bottom: 40.0),
            child: Tab(icon: Icon(Icons.person, size: 45.0))),
      ]),
    );

    return Scaffold(
      body: const TabBarView(
        physics: NeverScrollableScrollPhysics(),
        children: [
          PathPage(),
          ChatPage(name: "Ryan", receiverUserId: '89',),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: appBar.preferredSize.height,
        child: appBar,
      ),
    );
  }
}
