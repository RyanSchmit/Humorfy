import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:humorfy/pages/info.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegisterPage({super.key, required this.showLoginPage});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  Future signUp() async {
    if (_confirmPasswordController.text.trim() ==
        _passwordController.text.trim()) {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: 1010,
        width: 1000,
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(
                left: 16.0, right: 16.0, top: 6.0, bottom: 6.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Sign Up", style: TextStyle(fontSize: 24)),
                const SizedBox(height: 10),
                const Text("Register with your info below",
                    style: TextStyle(fontSize: 20)),
                const SizedBox(height: 50),

                // Email
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white)),
                  child: TextField(
                    cursorColor: Colors.black,
                    controller: _emailController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Email",
                        labelStyle: TextStyle(color: Colors.black)),
                  ),
                ),
                const SizedBox(height: 32.0),

                // Password
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white)),
                  child: TextField(
                    // Make a show password boolean
                    obscureText: true,
                    cursorColor: Colors.black,
                    controller: _passwordController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Password",
                        labelStyle: TextStyle(color: Colors.black)),
                  ),
                ),
                const SizedBox(height: 32.0),

                // Confirm Password
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white)),
                  child: TextField(
                    obscureText: true,
                    cursorColor: Colors.black,
                    controller: _confirmPasswordController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Confirm Password",
                        labelStyle: TextStyle(color: Colors.black)),
                  ),
                ),
                const SizedBox(height: 32.0),

                // Sign up button
                ElevatedButton(
                  onPressed: () async {
                    await signUp().then(
                      (value) => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const InfoPage()),
                      ),
                    );
                  },
                  child: const Text('Register'),
                ),
                Column(
                  children: [
                    const Text("Already a member?"),
                    GestureDetector(
                        onTap: () => widget.showLoginPage(),
                        child: const Text("Login",
                            style: TextStyle(color: Colors.blue)))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
