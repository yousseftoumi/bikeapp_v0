import 'package:bikeapp_v0/screens/home/home_screen.dart';
import 'package:bikeapp_v0/utils/config.dart';
import 'package:flutter/material.dart';

import '../../utils/next_screen.dart';

class ConfirmationScreen extends StatelessWidget {
  const ConfirmationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: app_bar(context, "Réservation Complète"),
      body: Center(
        child: Column(
          children: [
            const Text(
                "Votre réservation est complète. Vous pouvez maintenant récupérer votre vélo"),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
                onPressed: () {
                  nextScreen(context, const HomeScreen());
                },
                child: const Text(
                  "Retourner à la page d'acceuil",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                )),
          ],
        ),
      ),
    );
  }
}
