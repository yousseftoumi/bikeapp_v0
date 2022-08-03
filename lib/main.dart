import 'package:bikeapp_v0/provider/internet_provider.dart';
import 'package:bikeapp_v0/provider/sign_in_provider.dart';
import 'package:bikeapp_v0/screens/login_screen.dart';
import 'package:bikeapp_v0/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   title: 'BikeApp : Bike Rental',
    //   theme: ThemeData(
    //     primarySwatch: Colors.blue,
    //   ),
    //   home: const LoginScreen(),
    // );
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: ((context) => SignInProvider()),
        ),
        ChangeNotifierProvider(
          create: ((context) => InternetProvider()),
        ),
      ],
      child: const MaterialApp(
        home: SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
