import 'package:flutter/material.dart';

class Config {
  static final app_icon = "assets/bikeAppLogo.png";
  static final app_font = "Varela_Round";
  static final apikey_twitter = "9Feip53jOk8esDtSM6w08d3XT";
  static final secretkey_twitter =
      "1eJOsBMqbI5HGjVAH7KNWkJsGgD44EHMFsZrqb1ne5nfYSwhBW";
}

const kTextColor = Color.fromRGBO(56, 182, 255, 1);
const kTextLightColor = Color.fromARGB(255, 171, 185, 196);

const kDefaultPaddin = 20.0;

enum DialogsAction { Oui, Annuler }

class AlertDialogs {
  static Future<DialogsAction> yesCancelDialog(
    BuildContext context,
    String title,
    String body,
  ) async {
    final action = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            title: Text(title),
            content: Text(body),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () =>
                    Navigator.of(context).pop(DialogsAction.Annuler),
                child: Text(
                  'Cancel',
                  style: TextStyle(
                       fontWeight: FontWeight.bold),
                ),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(DialogsAction.Oui),
                child: Text(
                  'Confirm',
                  style: TextStyle(
                       fontWeight: FontWeight.w700),
                ),
              )
            ],
          );
        },);
        return (action != null) ? action : DialogsAction.Annuler;
  }
}