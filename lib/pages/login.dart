import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:humorfy/main.dart';
import 'package:humorfy/pages/home.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showRegisterPage;
  const LoginPage({super.key, required this.showRegisterPage});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future signIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim());
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const MyTitle(),
                const Airplane(),
                TextField(
                  cursorColor: Colors.blue,
                  controller: _emailController,
                  decoration: const InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      labelText: 'Email',
                      labelStyle: TextStyle(color: Colors.black)),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  cursorColor: Colors.blue,
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Colors.black)),
                ),
                const SizedBox(height: 32.0),
                ElevatedButton(
                  onPressed: () async {
                    await signIn().then(
                      (value) => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const MyApp()),
                      ),
                    );
                  },
                  child: const Text('Login'),
                ),
                Column(
                  children: [
                    const Text("Not a member?"),
                    GestureDetector(
                        onTap: () => widget.showRegisterPage(),
                        child: const Text("Register now",
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
