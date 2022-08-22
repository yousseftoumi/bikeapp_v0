import 'dart:async';
import 'package:bikeapp_v0/provider/sign_in_provider.dart';
import 'package:bikeapp_v0/screens/home/home_screen.dart';
import 'package:bikeapp_v0/screens/auth/login_screen.dart';
import 'package:bikeapp_v0/utils/next_screen.dart';
import 'package:bikeapp_v0/utils/snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VerifyScreen extends StatefulWidget {
  const VerifyScreen({Key? key}) : super(key: key);

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  bool isEmailVerified = false;
  bool canResendEmail = false;

  User? user = FirebaseAuth.instance.currentUser;
  Future getData() async {
    final sp = context.read<SignInProvider>();
    sp.getDataFromSharedPreferences();
  }

  Timer? timer;

  @override
  void initState() {
    isEmailVerified = user!.emailVerified;
    if (!isEmailVerified) {
      sendVerificationEmail();
      timer = Timer.periodic(
        Duration(seconds: 4),
        (_) => checkEmailVerified(),
      );
    }
    super.initState();
    getData();
  }

  @override
  @mustCallSuper
  void dispose() {
    timer?.cancel();
  }

  Future sendVerificationEmail() async {
    try {
      await user!.sendEmailVerification();
      setState(() => canResendEmail = false);
      await Future.delayed(Duration(seconds: 15));
      setState(() => canResendEmail = true);
    } catch (e) {
      openSnackbar(context, e.toString(), Colors.red);
    }
  }

  Future checkEmailVerified() async {
    await user!.reload();
    setState(() {
      isEmailVerified = user!.emailVerified;
    });
    if (isEmailVerified) timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final sp = context.watch<SignInProvider>();
    if (isEmailVerified) {
      return HomeScreen();
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text("Vérifiez votre email !"),
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Un email de vérification a été envoyé à ${user!.email}",
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24),
              ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(50),
                  ),
                  icon: Icon(
                    Icons.email,
                    size: 32,
                  ),
                  label: Text(
                    "Renvoyer l'email",
                    style: TextStyle(fontSize: 22),
                  ),
                  onPressed: canResendEmail ? sendVerificationEmail : null),
              SizedBox(height: 14),
              TextButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(50),
                ),
                child: const Text(
                  "Annuler",
                  style: TextStyle(fontSize: 22),
                ),
                onPressed: () {
                  sp.userSignOut();
                  nextScreen(context, LoginScreen());
                },
              )
            ],
          ),
        ),
      );
    }
  }
}
