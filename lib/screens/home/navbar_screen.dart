import 'package:bikeapp_v0/screens/auth/login_screen.dart';
import 'package:bikeapp_v0/screens/home/parametres_screen.dart';
import 'package:bikeapp_v0/screens/profile/editprofile_screen.dart';
import 'package:bikeapp_v0/utils/config.dart';
import 'package:flutter/material.dart';

import 'package:bikeapp_v0/provider/sign_in_provider.dart';
import 'package:bikeapp_v0/utils/next_screen.dart';

import 'package:provider/provider.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  // bool tappedYes = false;
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
    bool _darkMode =
        Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark;
    return Drawer(
      backgroundColor:
          _darkMode ? Theme.of(context).scaffoldBackgroundColor : Colors.white,
      child: ListView(
        // Remove padding
        padding: EdgeInsets.zero,

        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              "${sp.name}",
              style: const TextStyle(color: Colors.white),
            ),
            accountEmail: Text(
              "${sp.email}",
              style: const TextStyle(color: Colors.white),
            ),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Hero(
                  tag: "profilepic",
                  child: Image.network(
                    "${sp.imageUrl}",
                    fit: BoxFit.cover,
                    width: 90,
                    height: 90,
                  ),
                ),
              ),
            ),
            decoration: const BoxDecoration(
              // color: kTextColor,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                    'https://hdwallpaperim.com/wp-content/uploads/2017/08/24/99743-bicycle-simple_background.jpg'),
              ),
            ),
            onDetailsPressed: () {
              nextScreen(context, const EditProfile());
            },
          ),
          ListTile(
            leading: const Icon(Icons.favorite),
            title: const Text('Favoris'),
            onTap: () => null,
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Amis'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.share),
            title: const Text('Share'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Notifications'),
            onTap: () => null,
            trailing: ClipOval(
              child: Container(
                color: Colors.red,
                width: 20,
                height: 20,
                child: const Center(
                  child: Text(
                    '8',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Paramètres'),
            onTap: () => nextScreen(context, ParametresScreen()),
          ),
          ListTile(
            leading: const Icon(Icons.description),
            title: const Text('Policies'),
            onTap: () => null,
          ),
          const Divider(),
          ListTile(
              title: const Text('Se déconnecter'),
              leading: const Icon(Icons.exit_to_app),
              onTap: () async {
                final action = await AlertDialogs.yesCancelDialog(
                    context, 'Se déconnecter', 'Êtes vous sûr ?');
                if (action == DialogsAction.oui) {
                  sp.userSignOut();
                  nextScreenReplace(context, const LoginScreen());
                  // setState(() => tappedYes = true);
                } else {
                  // setState(() => tappedYes = false);
                }
              }),
        ],
      ),
    );
  }
}
