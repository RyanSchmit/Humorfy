import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body:
          Center(child: Column(children: [MyTitle(), SubTitle(), Airplane()])),
    );
  }
}

class MyTitle extends StatelessWidget {
  const MyTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const  Center(child:Text(
      "Humorfy",
      style: TextStyle(fontSize: 60),
    ));
  }
}

class SubTitle extends StatelessWidget {
  const SubTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Get fit with fun",
      style: TextStyle(fontSize: 25),
    );
  }
}

class Airplane extends StatelessWidget {
  const Airplane({super.key});

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.face,
      color: Colors.blue,
      size: 100,
    );
  }
}

