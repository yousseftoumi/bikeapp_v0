import 'package:bikeapp_v0/screens/home/navbar_screen.dart';
import 'package:flutter/material.dart';

import '../../utils/config.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      drawer: NavBar(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Notifications",
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
      body: Center(child: Text("Notifications")),
    );
  }
}
