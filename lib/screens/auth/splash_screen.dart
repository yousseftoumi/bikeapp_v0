import 'dart:async';

import 'package:bikeapp_v0/provider/sign_in_provider.dart';
import 'package:bikeapp_v0/screens/home/home_screen.dart';
import 'package:bikeapp_v0/screens/auth/login_screen.dart';
import 'package:bikeapp_v0/utils/config.dart';
import 'package:bikeapp_v0/utils/next_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // init state
  @override
  void initState() {
    final sp = context.read<SignInProvider>();
    super.initState();
    // create a timer of 2 seconds
    Timer(const Duration(seconds: 3), () {
      sp.isSignedIn == false
          ? nextScreen(context, const LoginScreen())
          : nextScreen(context, const HomeScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Center(
            child: Image(
          image: AssetImage(Config.app_icon),
          height: 200,
          width: 200,
        )),
        SizedBox(height: 18),
        Text(
          "Trouvez votre vélo idéal et découvrez la plus grande collection de pistes cyclables au monde.",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.blueGrey,
            fontSize: 15,
          ),
        )
      ]),
    );
  }
}
