import 'package:flutter/material.dart';

class PathPage extends StatefulWidget {
  const PathPage({super.key});

  @override
  State<PathPage> createState() => _PathPageState();
}

class _PathPageState extends State<PathPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 200.0),
      child: Column(
        children: [PathPoint(), PathPoint()],
      ),
    );
  }
}

class PathPoint extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: SizedBox(
        width: 80.0,
        height: 80.0,
        child: ElevatedButton(
          onPressed: () {},
          child: Text("  "),
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            padding: EdgeInsets.all(20),
            backgroundColor: Colors.green,
          ),
        ),
      ),
    );
  }
}
