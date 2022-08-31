import 'package:bikeapp_v0/screens/profile/editprofile_screen.dart';
import 'package:bikeapp_v0/utils/next_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/config.dart';

class ParametresScreen extends StatefulWidget {
  @override
  _ParametresScreenState createState() => _ParametresScreenState();
}

class _ParametresScreenState extends State<ParametresScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: app_bar(context, "Paramètres"),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: ListView(
          children: [
            Row(
              children: const [
                Icon(
                  Icons.person,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Compte",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(
              height: 15,
              thickness: 2,
            ),
            const SizedBox(
              height: 10,
            ),
            buildAccountOptionRow(context, "Mes informations"),
            buildAccountOptionRow(context, "Mot de passe"),
            buildAccountOptionRow(context, "Notifications"),
            buildAccountOptionRow(context, "Langue"),
            const SizedBox(
              height: 40,
            ),
            Row(
              children: [
                Icon(
                  Provider.of<ThemeProvider>(context).themeMode ==
                          ThemeMode.dark
                      ? Icons.nightlight
                      : Icons.wb_sunny,
                  //color: kTextColor,
                ),
                const SizedBox(
                  width: 8,
                ),
                const Text(
                  "Apparence",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(
              height: 15,
              thickness: 2,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Mode sombre",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                ChangeThemeSwitch(),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              children: const [
                Icon(
                  Icons.help,
                  //color: kTextColor,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Support",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(
              height: 15,
              thickness: 2,
            ),
            const SizedBox(
              height: 10,
            ),
            // buildNotificationOptionRow("New for you", true),
            buildAccountOptionRow(context, "J'ai besoin d'aide"),
            buildAccountOptionRow(
                context, "J'ai une question de confidentialité"),
            const SizedBox(
              height: 50,
            ),
            Column(
              children: const [
                Text(
                  "Bike App v1.3.5",
                  style: TextStyle(
                    fontSize: 10,
                    // color: Colors.grey[600]
                  ),
                ),
                Text(
                  "Made in Casablanca",
                  style: TextStyle(
                    fontSize: 10,
                    //color: Colors.grey[600]
                  ),
                ),
              ],
            ),
            Center(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
                onPressed: () {},
                child: const Text("SIGN OUT",
                    style: TextStyle(fontSize: 16, letterSpacing: 2.2)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row buildNotificationOptionRow(String title, bool isActive) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            //color: Colors.grey[600]
          ),
        ),
        Transform.scale(
            scale: 0.7,
            child: CupertinoSwitch(
              value: isActive,
              onChanged: (bool val) {},
            ))
      ],
    );
  }

  GestureDetector buildAccountOptionRow(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {
        // nextScreen(context, page);
        // showDialog(

        //     context: context,
        //     builder: (BuildContext context) {
        //       return AlertDialog(
        //         title: Text(title),
        //         content: Column(
        //           mainAxisSize: MainAxisSize.min,
        //           children: [
        //             Text("Option 1"),
        //             Text("Option 2"),
        //             Text("Option 3"),
        //           ],
        //         ),
        //         actions: [
        //           FlatButton(
        //               onPressed: () {
        //                 Navigator.of(context).pop();
        //               },
        //               child: Text("Close")),
        //         ],
        //       );
        //     });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                //color: Colors.grey[600],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              // color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}

class ChangeThemeSwitch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Transform.scale(
      scale: 0.7,
      child: CupertinoSwitch(
          value: themeProvider.isDarkMode,
          onChanged: (value) {
            final provider = Provider.of<ThemeProvider>(context, listen: false);
            provider.toggleTheme(value);
          }),
    );
  }
}
