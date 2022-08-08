import 'package:bikeapp_v0/model/user_model.dart';
import 'package:bikeapp_v0/provider/sign_in_provider.dart';
import 'package:bikeapp_v0/utils/next_screen.dart';
import 'package:bikeapp_v0/screens/navbar_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bikeapp_v0/utils/card_widget.dart';

import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  Future getData() async {
    final sp = context.read<SignInProvider>();
    sp.getDataFromSharedPreferences();
  }

  @override
  void initState() {
    // TODO: implement initState
    _tabController = new TabController(length: 3, vsync: this, initialIndex: 0)
      ..addListener(() {});
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
    //           backgroundImage: NetworkImage("${sp.imageUrl}"),
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
      backgroundColor: Colors.grey[100],
      drawer: NavBar(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu),
          color: Colors.blue,
        ),
        title: Image.asset(
          'assets/bikeAppLogo.png',
          width: 80,
          height: 80,
        ),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(35)),
        ),
      ),
      body: Column(
        children: [
          Container(
            child: TabBar(
              isScrollable: true,
              indicatorPadding: EdgeInsets.all(10),
              labelPadding:
                  EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
              labelColor: Colors.black,
              labelStyle: TextStyle(fontSize: 20),
              indicator: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              controller: _tabController,
              tabs: [
                Text('Favorite'),
                Text('Electric'),
                Text('Classic'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(controller: _tabController, children: [
              CardWidget(),
              CardWidget(),
              CardWidget(),
            ]),
          )
        ],
      ),
      bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          ),
          child: Material(
            elevation: 0.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40.0)),
            child: BottomNavigationBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(icon: Icon(Icons.favorite), label: ''),
                BottomNavigationBarItem(
                    icon: Icon(Icons.calendar_month), label: ''),
                BottomNavigationBarItem(icon: Icon(Icons.favorite), label: ''),
              ],
            ),
          )),
    );
  }

  // // the logout function
  // Future<void> logout(BuildContext context) async {
  //   await FirebaseAuth.instance.signOut();
  //   Navigator.of(context).pushReplacement(
  //       MaterialPageRoute(builder: (context) => LoginScreen()));
  // }
}
