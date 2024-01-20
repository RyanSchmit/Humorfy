import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:humorfy/main.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  final TextEditingController _nameController = TextEditingController();
  final int avatarNumber = 0;

  final user = FirebaseAuth.instance.currentUser!;

  Future addUserData() async {
    await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
      'name': _nameController.text.trim(),
      'avatar': avatarNumber,
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: 1000,
        width: 1000,
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(
                left: 16.0, right: 16.0, top: 6.0, bottom: 6.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Profile Info", style: TextStyle(fontSize: 24)),
                const SizedBox(height: 10),
                const Text("Complete your profile",
                    style: TextStyle(fontSize: 20)),
                const SizedBox(height: 50),

                // Name
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white)),
                  child: TextField(
                    cursorColor: Colors.black,
                    controller: _nameController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "nickname",
                        labelStyle: TextStyle(color: Colors.black)),
                  ),
                ),
                const SizedBox(height: 32.0),

                // Avatar
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.arrow_back_ios,
                    ),
                    Image.asset(
                      'assets/images/avatar0.png',
                      scale: 3.0,
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                    ),
                  ],
                ),
                const SizedBox(height: 50.0),

                // Sign up button
                ElevatedButton(
                  onPressed: () async {
                    await addUserData().then(
                      (value) => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const MyApp()),
                      ),
                    );
                  },
                  child: const Text('Complete Registration'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GenderButtons extends StatefulWidget {
  final TextEditingController controller;

  const GenderButtons({super.key, required this.controller});

  @override
  State<GenderButtons> createState() => _GenderButtonsState();
}

class _GenderButtonsState extends State<GenderButtons> {
  bool selectedMale = false;
  bool selectedFemale = false;
  bool selectedOther = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Male
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: ElevatedButton(
            onPressed: () {
              widget.controller.text = "Male";
              selectedMale = true;
              selectedFemale = false;
              selectedOther = false;
              setState(() {
                GenderButtons;
              });
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: selectedMale ? Colors.red : Colors.white),
            child: Text(
              "Male",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: selectedMale ? Colors.white : Colors.red),
            ),
          ),
        ),

        // Female
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: ElevatedButton(
            onPressed: () {
              widget.controller.text = "Female";
              selectedFemale = true;
              selectedMale = false;
              selectedOther = false;
              setState(() {
                GenderButtons;
              });
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: selectedFemale ? Colors.red : Colors.white),
            child: Text(
              "Female",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: selectedFemale ? Colors.white : Colors.red),
            ),
          ),
        ),

        // Other
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: ElevatedButton(
            onPressed: () {
              widget.controller.text = "Other";
              selectedOther = true;
              selectedMale = false;
              selectedFemale = false;
              setState(() {
                GenderButtons;
              });
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: selectedOther ? Colors.red : Colors.white),
            child: Text(
              "Other",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: selectedOther ? Colors.white : Colors.red),
            ),
          ),
        ),
      ],
    );
  }
}
