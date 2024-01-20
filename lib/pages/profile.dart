import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:humorfy/pages/auth.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final user = FirebaseAuth.instance.currentUser!;

  Future getUserInfo() async {
    var userDoc =
        FirebaseFirestore.instance.collection("users").doc(user.uid);
    return await userDoc.get().then((snapshot) => snapshot.data());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 65.0),
      child: Center(
          child: FutureBuilder(
              future: getUserInfo(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Image.asset('assets/images/avatar0.png', scale: 2.0,)),
                      const Text("Your Profile", style: TextStyle(fontSize: 40)),
                      // Nickname
                      const Text("Nickname:",
                          style: TextStyle(fontSize: 20, color: Colors.lightBlue)),
                      Text(snapshot.data['name'],
                          style: const TextStyle(
                              fontSize: 25, color: Colors.black)),

                      // Sleep
                      const Text("Average Sleep in Past 7 days:",
                          style: TextStyle(fontSize: 20, color: Colors.lightBlue)),
                      const Text("7.8 hours",
                          style: TextStyle(
                              fontSize: 25, color: Colors.black)),

                      // Active Day Streak
                      const Text("Fitness Streak:",
                          style: TextStyle(fontSize: 20, color: Colors.lightBlue)),
                      const Text("20 days",
                          style: TextStyle(
                              fontSize: 25, color: Colors.black)),
                              
                      MaterialButton(
                        onPressed: () async {
                          await FirebaseAuth.instance.signOut().then(
                                (value) => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const AuthPage()),
                                ),
                              );
                        },
                        color: Colors.lightGreen,
                        child: const Text("Sign out"),
                      )
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                }
                return const Center(child: CircularProgressIndicator());
              })),
    );
  }
}
