import 'package:bikeapp_v0/utils/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GridView.builder(
        itemCount: 10,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          return Stack(//alignment: AlignmentDirectional.center,
              children: <Widget>[
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(48)),
              child: Column(
                children: [
                  Image.asset(
                    'assets/bikeAppLogo.png',
                    width: 150,
                    height: 110,
                  ),
                  Text(
                    'VTT ST 50',
                    style: TextStyle(),
                  ),
                  Text('1 Dhs/Km'),
                ],
              ),
            ),
            Positioned(
              top: 0.0,
              child: SizedBox(
                height: 30,
                width: 58,
                
                child: TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(color: Colors.white),
                    ),
                    primary: Colors.white,
                    backgroundColor: kTextColor,
                  ),
                  onPressed: () {},
                  child: Row(children: [
                    Icon(
                      Icons.star,
                      size: 17,
                    ),
                    SizedBox(width: 3),
                    Text(
                      "4,5",
                      style: TextStyle(fontWeight: FontWeight.w700,fontSize: 14),
                    )
                  ]),
                ),
              ),
            ),
          ]);
        },
      ),
    );
  }
}
