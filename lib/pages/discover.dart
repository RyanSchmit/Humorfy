import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  CollectionReference collectionRef =
      FirebaseFirestore.instance.collection('profiles');

  // Get images from firebase storage
  final List<Image> _images = [
    Image.asset("assets/images/discover0.jpg"),
    Image.asset("assets/images/discover1.png"),
    Image.asset("assets/images/discover2.png"),
    Image.asset("assets/images/discover3.png"),
    Image.asset("assets/images/discover4.jpg"),
  ];

  Future getPossibleMatches() async {
    QuerySnapshot querySnapshot = await collectionRef.get();
    final data = querySnapshot.docs.map((doc) => doc.data()).toList();
    return data;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getPossibleMatches(),
        builder: (context, snapshot) {
          return const Scaffold();
        });
  }
}

class MatchCard {
  final String? name;
  final String? bio;
  final Image? image;

  MatchCard({this.name, this.bio, this.image});
}
