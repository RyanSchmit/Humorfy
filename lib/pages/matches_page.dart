import 'package:flutter/material.dart';
import 'package:humorfy/pages/chat_page.dart';

class MatchesPage extends StatefulWidget {
  const MatchesPage({super.key});

  @override
  _MatchesPageState createState() => _MatchesPageState();
}

class _MatchesPageState extends State<MatchesPage> {
  @override
  Widget build(BuildContext context) {
    // Make infinite scroll possible
    return const Padding(
      padding: EdgeInsets.only(top: 60.0),
      child: Column(
        children: [
          Text("New Matches", style: TextStyle(fontSize: 40)),
          Row(
            children: [
              NewMatch(name: "Ava"),
              NewMatch(name: "Lucy"),
              NewMatch(name: "Mae"),
              NewMatch(name: "Sonny"),
              NewMatch(name: "Anna"),
            ],
          ),
          Text("Messages", style: TextStyle(fontSize: 40)),
          MessageRow(name: 'Janna', messageBody: 'hi'),
          MessageRow(name: 'Diane', messageBody: 'hello')
        ],
      ),
    );
  }
}

class MessageRow extends StatelessWidget {
  final String name;
  final String messageBody;
  const MessageRow({super.key, required this.name, required this.messageBody});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ChatPage(name: name, receiverUserId: '8Q7xFHTNOJfmVZGfTdR7gZNWBQt2')),
      ),
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: (Row(
            children: [
              Image.asset('assets/images/match.png'),
              Padding(
                  padding: const EdgeInsets.only(right: 15.0, left: 7.0),
                  child: Text("$name: ", style: const TextStyle(fontSize: 30))),
              Text(messageBody,
                  style: const TextStyle(fontSize: 25),
                  overflow: TextOverflow.ellipsis)
            ],
          )),
        ),
      ),
    );
  }
}

class NewMatch extends StatelessWidget {
  final String name;
  const NewMatch({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          GestureDetector(
            child: Image.asset('assets/images/match.png'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ChatPage(name: name, receiverUserId: 'iqiOw4JOMTOJz6XDc7RuoH538ND3=[======]',)),
            ),
          ),
          Text(name)
        ],
      ),
    );
  }
}
