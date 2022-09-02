import 'dart:io';

import 'package:bikeapp_v0/model/user_model.dart';
import 'package:bikeapp_v0/provider/sign_in_provider.dart';
import 'package:bikeapp_v0/screens/home/home_screen.dart';
import 'package:bikeapp_v0/screens/profile/profile_screen.dart';
import 'package:bikeapp_v0/utils/config.dart';
import 'package:bikeapp_v0/utils/next_screen.dart';
import 'package:bikeapp_v0/utils/snack_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

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
  final birthDateEditingController = TextEditingController();
  final emailEditingController = TextEditingController();
  String profilePicLink = "";
  bool _isLoading = false;
  DateTime date = DateTime.now();
  TimeOfDay time = TimeOfDay.now();

  Future getData() async {
    setState(() {
      _isLoading = true;
    });
    final sp = context.read<SignInProvider>();
    sp.getDataFromSharedPreferences();
    emailEditingController.text = "${sp.email}";
    nameEditingController.text = "${sp.name}";
    birthDateEditingController.text = "${sp.birthDate}";
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    // bool _darkMode =
    // Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark;
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

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));
//email field
    final birthDateField = TextFormField(
        autofocus: false,
        controller: birthDateEditingController,
        // style: TextStyle(fontSize: 14),
        keyboardType: TextInputType.datetime,
        onSaved: (value) {
          emailEditingController.text = value!;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          suffixIcon: GestureDetector(
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime(2000),
                  firstDate: DateTime(1950),
                  //DateTime.now() - not to allow to choose before today.
                  lastDate: DateTime(2010));

              if (pickedDate != null) {
                String formattedDate =
                    DateFormat('dd/MM/yyyy').format(pickedDate);
                setState(() {
                  birthDateEditingController.text =
                      formattedDate; //set output date to TextField value.
                });
              } else {}
            },
            child: const Icon(Icons.calendar_month),
          ),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          labelText: 'Date de naissance',
          // labelStyle: TextStyle(color: Theme.of(context).iconTheme.color),
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
            docUser.update({
              'name': nameEditingController.text,
              'email': emailEditingController.text,
              'birthDate': birthDateEditingController.text,
              'imageUrl':
                  profilePicLink == "" ? "${sp.imageUrl}" : profilePicLink
            });
            await user!.reload();
            user = _auth.currentUser!;
            Navigator.of(context).pop();

            openSnackbar(context, "Profil mis à jour!", Colors.white);
            // await sp.saveDataToFirestore().then((value) => sp
            //     .saveDataToSharedPreferences()
            //     .then((value) => sp.setSignIn().then((value) {
            //           Navigator.of(context).pop();
            // })));
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

    void pickUploadProfilePic() async {
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxHeight: 512,
        maxWidth: 512,
        imageQuality: 90,
      );

      Reference ref = FirebaseStorage.instance
          .ref('/users')
          .child("${sp.uid}_profilepic.jpg");

      await ref.putFile(File(image!.path));

      ref.getDownloadURL().then((value) async {
        setState(() {
          profilePicLink = value;
        });
        await FirebaseFirestore.instance
            .collection("users")
            .doc("${sp.uid}")
            .update({
          'imageUrl': value,
        });
      });
    }

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: app_bar(context, "Modifier mon profil"),
      body: _isLoading
          ? const CircularProgressIndicator()
          : Center(
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
                                backgroundImage: profilePicLink == ""
                                    ? NetworkImage("${sp.imageUrl}")
                                    : NetworkImage(profilePicLink),
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
                                      side:
                                          const BorderSide(color: Colors.white),
                                    ),
                                    primary: Theme.of(context).primaryColor,
                                    backgroundColor: Colors.grey[200],
                                  ),
                                  onPressed: () {
                                    pickUploadProfilePic();
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
                      const SizedBox(height: 25),
                      birthDateField,
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
