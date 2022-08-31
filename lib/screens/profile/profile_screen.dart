import 'package:bikeapp_v0/provider/sign_in_provider.dart';
import 'package:bikeapp_v0/screens/admin/addbike_screen.dart';
import 'package:bikeapp_v0/screens/admin/addstation_screen.dart';
import 'package:bikeapp_v0/screens/auth/login_screen.dart';
import 'package:bikeapp_v0/screens/home/notifications_screen.dart';
import 'package:bikeapp_v0/screens/home/parametres_screen.dart';
import 'package:bikeapp_v0/screens/profile/editprofile_screen.dart';
import 'package:bikeapp_v0/screens/profile/tutorial_screen.dart';
import 'package:bikeapp_v0/utils/config.dart';
import 'package:bikeapp_v0/utils/next_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class Profilescreen extends StatefulWidget {
  const Profilescreen({Key? key}) : super(key: key);

  @override
  State<Profilescreen> createState() => _ProfilescreenState();
}

class _ProfilescreenState extends State<Profilescreen> {
  Future getData() async {
    final sp = context.read<SignInProvider>();
    sp.getDataFromSharedPreferences();
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    final sp = context.watch<SignInProvider>();
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            SizedBox(
              height: 115,
              width: 115,
              child: Stack(
                fit: StackFit.expand,
                clipBehavior: Clip.none,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage("${sp.image_url}"),
                  ),
                  // Positioned(
                  //   right: -16,
                  //   bottom: 0,
                  //   child: SizedBox(
                  //     height: 46,
                  //     width: 46,
                  //     child: TextButton(
                  //       style: TextButton.styleFrom(
                  //         shape: RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.circular(50),
                  //           side: BorderSide(color: Colors.white),
                  //         ),
                  //         primary: Colors.grey,
                  //         backgroundColor: Colors.white,
                  //       ),
                  //       onPressed: () {
                  //         //change profile picture
                  //       },
                  //       child: Icon(Icons.camera_alt),
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ),
            const SizedBox(height: 5),
            Text(
              "${sp.name}",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text("${sp.email}"),
            const SizedBox(height: 20),
            ProfileMenu(
              text: "Mon profil",
              icon: const Icon(Icons.person),
              press: () {
                nextScreen(context, const EditProfile());
              },
            ),
            ProfileMenu(
              text: "Paramètres",
              icon: const Icon(Icons.settings),
              press: () {
                nextScreen(context, ParametresScreen());
              },
            ),
            ProfileMenu(
              text: "Centre d'aide",
              icon: const Icon(Icons.help),
              press: () {
                
              },
            ),
            ProfileMenu(
              text: "Visite guidée",
              icon: const Icon(Icons.auto_stories),
              press: () {
                nextScreen(context, const TutorialScreen());
              },
            ),
            ProfileMenu(
              text: "Partager l'application avec mes amis",
              icon: const Icon(Icons.share),
              press: () {
                nextScreen(context, const AddBikeScreen());
              },
            ),
            ProfileMenu(
              text: "À propos de votre application",
              icon: const Icon(Icons.perm_device_info),
              press: () {
                nextScreen(context, const AddStationScreen());
              },
            ),
            ProfileMenu(
              text: "Se déconnecter",
              icon: const Icon(Icons.exit_to_app),
              press: () async {
                final action = await AlertDialogs.yesCancelDialog(
                    context, 'Se déconnecter', 'Êtes vous sûr ?');
                if (action == DialogsAction.oui) {
                  sp.userSignOut();
                  nextScreenReplace(context, const LoginScreen());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    required this.text,
    required this.icon,
    this.press,
  }) : super(key: key);

  final String text;
  final Icon icon;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    bool _darkMode =
        Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          primary: _darkMode
              ? Theme.of(context).scaffoldBackgroundColor
              : kTextColor,
          padding: const EdgeInsets.all(14),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: _darkMode ? Colors.white : Colors.white,
        ),
        onPressed: press,
        child: Row(
          children: [
            icon,
            const SizedBox(width: 20),
            Expanded(
                child: Text(
              text,
              style: TextStyle(color: _darkMode ? Colors.black : Colors.black),
            )),
            const Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}
