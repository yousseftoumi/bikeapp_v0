import 'package:bikeapp_v0/utils/config.dart';
import 'package:flutter/material.dart';

class ConfirmationScreen extends StatelessWidget {
  const ConfirmationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: app_bar(context, "Réservation Complète"),
      body: Center(
        child: Text("Votre réservation est complete"),
      ),
    );
  }
}
