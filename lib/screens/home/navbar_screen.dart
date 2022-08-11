import 'package:bikeapp_v0/screens/auth/login_screen.dart';
import 'package:bikeapp_v0/screens/home/parametres_screen.dart';
import 'package:bikeapp_v0/screens/profile/editprofile_screen.dart';
import 'package:bikeapp_v0/utils/config.dart';
import 'package:flutter/material.dart';
import 'package:bikeapp_v0/model/user_model.dart';
import 'package:bikeapp_v0/provider/sign_in_provider.dart';
import 'package:bikeapp_v0/utils/next_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    final sp = context.watch<SignInProvider>();
    return Drawer(
      child: ListView(
        // Remove padding
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text("${sp.name}"),
            accountEmail: Text("${sp.email}"),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.network(
                  "${sp.image_url}",
                  fit: BoxFit.cover,
                  width: 90,
                  height: 90,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: kTextColor,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                    'https://hdwallpaperim.com/wp-content/uploads/2017/08/24/99743-bicycle-simple_background.jpg'),
              ),
            ),
            onDetailsPressed: () {
              nextScreen(context, EditProfile());
            },
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text('Favoris'),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Amis'),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.share),
            title: Text('Share'),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Notifications'),
            onTap: () => null,
            trailing: ClipOval(
              child: Container(
                color: Colors.red,
                width: 20,
                height: 20,
                child: Center(
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
          Divider(),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Paramètres'),
            onTap: () => nextScreen(context, ParametresScreen()),
          ),
          ListTile(
            leading: Icon(Icons.description),
            title: Text('Policies'),
            onTap: () => null,
          ),
          Divider(),
          ListTile(
              title: Text('Se déconnecter'),
              leading: Icon(Icons.exit_to_app),
              onTap: () async {
                final action = await AlertDialogs.yesCancelDialog(
                    context, 'Se déconnecter', 'Êtes vous sûr ?');
                if (action == DialogsAction.Oui) {
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
