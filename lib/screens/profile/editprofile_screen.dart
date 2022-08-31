import 'dart:io';

import 'package:bikeapp_v0/model/user_model.dart';
import 'package:bikeapp_v0/provider/sign_in_provider.dart';
import 'package:bikeapp_v0/utils/config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  // bool _obscureText = true;
  User? user;
  final _auth = FirebaseAuth.instance;
  // our form key
  final _formKey = GlobalKey<FormState>();
  //editing Controller
  final nameEditingController = TextEditingController();
  // final secondNameEditingController = new TextEditingController();
  final emailEditingController = TextEditingController();
  // bool _isLoading = false;

  Future getData() async {
    final sp = context.read<SignInProvider>();
    sp.getDataFromSharedPreferences();
    emailEditingController.text = "${sp.email}";
    nameEditingController.text = "${sp.name}";
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    bool _darkMode =
        Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark;
    final sp = context.watch<SignInProvider>();
    //name field
    final nameField = TextFormField(
        autofocus: false,
        controller: nameEditingController,
        keyboardType: TextInputType.name,
        validator: (value) {
          RegExp regex = RegExp(r'^.{3,}$');
          if (value!.isEmpty) {
            return ("Veuillez saisir votre Nom ");
          }
          if (!regex.hasMatch(value)) {
            return ("Veuillez saisir un Nom valide (Min. 3 caractères) ");
          }
          return null;
        },
        onSaved: (value) {
          nameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          // prefixIcon: Icon(Icons.account_circle),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          // hintText: "Nom",
          labelText: 'Nom',
          labelStyle: const TextStyle(color: Colors.blueAccent),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));
    //email field
    final emailField = TextFormField(
        enabled: false,
        autofocus: false,
        controller: emailEditingController,
        // style: TextStyle(fontSize: 14),
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Veuillez saisir votre e-mail !");
          }
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value)) {
            return ("Veuillez saisir un email valide ! ");
          }
          return null;
        },
        onSaved: (value) {
          emailEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          // prefixIcon: Icon(Icons.mail),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          //hintText: ,
          //hintStyle: TextStyle(fontSize: 10),
          labelText: 'Email',
          labelStyle: const TextStyle(color: Colors.blueAccent),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    // save button
    final saveButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Theme.of(context).iconTheme.color,
      child: MaterialButton(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () async {
            user = _auth.currentUser!;
            final docUser =
                FirebaseFirestore.instance.collection('users').doc(user!.uid);
            docUser.update({'name': nameEditingController.text});
            await user?.reload();
            user = _auth.currentUser!;
          },
          child: Text(
            "Enregistrer",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20,
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5),
          )),
    );
    // saveProfilePicture() async {
    //   _formKey.currentState.save();
    //   if (_formKey.currentState.validate() && !_isLoading) {
    //     setState(() {
    //       _isLoading = true;
    //     });
    //     String profilePictureUrl = '';
    //     String coverPictureUrl = '';
    //     if (_profileImage == null) {
    //       profilePictureUrl = widget.user.profilePicture;
    //     } else {
    //       profilePictureUrl = await StorageService.uploadProfilePicture(
    //           widget.user.profilePicture, _profileImage);
    //     }
    //     if (_coverImage == null) {
    //       coverPictureUrl = widget.user.coverImage;
    //     } else {
    //       coverPictureUrl = await StorageService.uploadCoverPicture(
    //           widget.user.coverImage, _coverImage);
    //     }
    //     UserModel user = UserModel(
    //       id: widget.user.id,
    //       name: _name,
    //       profilePicture: profilePictureUrl,
    //       bio: _bio,
    //       coverImage: coverPictureUrl,
    //     );

    //     DatabaseServices.updateUserData(user);
    //     Navigator.pop(context);
    //   }
    // }

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: app_bar(context, "Modifier mon profil"),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(36),
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Column(
              children: [
                SizedBox(
                  height: 115,
                  width: 115,
                  child: Stack(
                    fit: StackFit.expand,
                    clipBehavior: Clip.none,
                    children: [
                      Hero(
                        tag: "profilepic",
                        child: CircleAvatar(
                          backgroundImage: NetworkImage("${sp.image_url}"),
                        ),
                      ),
                      Positioned(
                        right: -16,
                        bottom: 0,
                        child: SizedBox(
                          height: 46,
                          width: 46,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                                side: const BorderSide(color: Colors.white),
                              ),
                              primary: Theme.of(context).primaryColor,
                              backgroundColor: Colors.grey[200],
                            ),
                            onPressed: () {
                              // saveProfilePicture();
                            },
                            child: const Icon(
                              Icons.edit,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 35),
                nameField,
                const SizedBox(height: 25),
                emailField,
                const SizedBox(height: 30),
                saveButton,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
