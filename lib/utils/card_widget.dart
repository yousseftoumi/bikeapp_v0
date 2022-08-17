import 'package:bikeapp_v0/screens/reservation/bikedetails_screen.dart';
import 'package:bikeapp_v0/utils/config.dart';
import 'package:bikeapp_v0/utils/next_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GridView.builder(
        itemCount: 8,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          return Stack(//alignment: AlignmentDirectional.center,
              children: <Widget>[
            GestureDetector(
              onTap: () => nextScreen(context, BikeDetailsScreen()),
              child: Card(
                color: Theme.of(context).iconTheme.color,
                
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  
                  children: [
                    Image.asset(
                      Config.app_icon,
                      width: 150,
                      height: 110,
                    ),
                    Text(
                      'Umbro',
                      style: TextStyle(color: Theme.of(context).scaffoldBackgroundColor,fontSize: 17,fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4,),
                    Text('1 Dhs/Km',style: TextStyle(color: Theme.of(context).scaffoldBackgroundColor)),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0.0,
              child: SizedBox(
                height: 30,
                width: 64,
                
                child: TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(color: Colors.white),
                    ),
                    primary:Theme.of(context).iconTheme.color,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
