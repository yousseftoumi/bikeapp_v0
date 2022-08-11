import 'package:bikeapp_v0/screens/home/navbar_screen.dart';
import 'package:flutter/material.dart';

import '../../utils/config.dart';

class ParametresScreen extends StatefulWidget {
  const ParametresScreen({Key? key}) : super(key: key);

  @override
  State<ParametresScreen> createState() => _ParametresScreenState();
}

class _ParametresScreenState extends State<ParametresScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      drawer: NavBar(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Paramètres",
          style: TextStyle(color: kTextColor),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: kTextColor),
          onPressed: () {
            //passing this to our root
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(child: Text("Paramètres")),
    );
  }
}
