import 'package:bikeapp_v0/model/bike_model.dart';
import 'package:bikeapp_v0/model/user_model.dart';
import 'package:bikeapp_v0/provider/sign_in_provider.dart';
import 'package:bikeapp_v0/screens/auth/registeration_screen.dart';
import 'package:bikeapp_v0/screens/home/accueil_screen.dart';
import 'package:bikeapp_v0/screens/home/favoris_screen.dart';
import 'package:bikeapp_v0/screens/home/map_screen.dart';
import 'package:bikeapp_v0/screens/home/notifications_screen.dart';
import 'package:bikeapp_v0/screens/profile/profile_screen.dart';
import 'package:bikeapp_v0/screens/types.dart';
import 'package:bikeapp_v0/utils/next_screen.dart';
import 'package:bikeapp_v0/screens/home/navbar_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bikeapp_v0/utils/card_widget.dart';

import '../../utils/config.dart';
import '../auth/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int curIndex = 0;
  final screens = [
    AccueilScreen(),
    FavorisScreen(),
    MapScreen(),
    Profilescreen(),
    NotificationsScreen(),
  ];
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  Future getData() async {
    final sp = context.read<SignInProvider>();
    sp.getDataFromSharedPreferences();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // FirebaseFirestore.instance
    //     .collection("users")
    //     .doc(user!.uid)
    //     .get()
    //     .then((value) {
    //   this.loggedInUser = UserModel.fromMap(value.data());
    //   setState(() {});
    // });
    getData();
  }

  @override
  Widget build(BuildContext context) {
    final sp = context.watch<SignInProvider>();

    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text("Bienvenu !"),
    //     centerTitle: true,
    //   ),
    //   body: Center(
    //     child: Padding(
    //       padding: EdgeInsets.all(20),
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         crossAxisAlignment: CrossAxisAlignment.center,
    //         children: <Widget>[
    //           SizedBox(
    //             height: 150,
    //             child:
    //                 Image.asset("assets/bikeAppLogo.png", fit: BoxFit.contain),
    //           ),
    //           Text(
    //             "Welcome Back",
    //             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    //           ),
    //           SizedBox(
    //             height: 10,
    //           ),
    //           Text("${loggedInUser.firstName} ${loggedInUser.lastName}",
    //               style: TextStyle(
    //                   color: Colors.black54, fontWeight: FontWeight.w500)),
    //           Text("${loggedInUser.email}",
    //               style: TextStyle(
    //                   color: Colors.black54, fontWeight: FontWeight.w500)),
    //           SizedBox(
    //             height: 15,
    //           ),
    //           ActionChip(
    //               label: Text("Se déconnecter"),
    //               onPressed: () {
    //                 logout(context);
    //               }),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
    //Social auth
    // return Scaffold(
    //   drawer: NavBar(),
    //   appBar: AppBar(
    //     backgroundColor: Colors.blue,
    //     elevation: 0,
    //   ),
    //   body: Center(
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       crossAxisAlignment: CrossAxisAlignment.center,
    //       children: <Widget>[
    //         CircleAvatar(
    //           backgroundColor: Colors.white,
    //           backgroundImage: NetworkImage("${sp.image_url}"),
    //           radius: 50,
    //         ),
    //         const SizedBox(
    //           height: 20,
    //         ),
    //         Text(
    //           "Welcome ${sp.name}",
    //           style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
    //         ),
    //         const SizedBox(
    //           height: 10,
    //         ),
    //         Text(
    //           "${sp.email}",
    //           style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
    //         ),
    //         const SizedBox(
    //           height: 10,
    //         ),
    //         Text(
    //           "${sp.uid}",
    //           style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
    //         ),
    //         const SizedBox(
    //           height: 10,
    //         ),
    //         Row(
    //           crossAxisAlignment: CrossAxisAlignment.center,
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: [
    //             const Text("PROVIDER:"),
    //             const SizedBox(
    //               width: 5,
    //             ),
    //             Text("${sp.provider}".toUpperCase(),
    //                 style: const TextStyle(color: Colors.red)),
    //           ],
    //         ),
    //         const SizedBox(
    //           height: 20,
    //         ),
    //         ElevatedButton(
    //             onPressed: () {
    //               sp.userSignOut();
    //               nextScreenReplace(context, const LoginScreen());
    //             },
    //             child: const Text("SIGNOUT",
    //                 style: TextStyle(
    //                   color: Colors.white,
    //                 )))
    //       ],
    //     ),
    //   ),
    // );
    return Scaffold(
      backgroundColor: null,
      drawer: NavBar(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Image.asset(
          'assets/bikeAppLogo.png',
          width: 80,
          height: 80,
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: kTextColor),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(35)),
        ),
        actions: [
          TextButton.icon(
            style: TextButton.styleFrom(primary: kTextColor),
            onPressed: () {
              nextScreen(context, NotificationsScreen());
            },
            icon: Icon(Icons.notifications),
            label: Text(''),
          ),
        ],
      ),
      body: IndexedStack(
        index: curIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: false,
          onTap: (index) {
            setState(() {
              curIndex = index;
            });
          },
          currentIndex: curIndex,
          elevation: 0,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Accueil'),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite), label: 'Favoris'),
            BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Carte'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ]),
    );
  }
}
