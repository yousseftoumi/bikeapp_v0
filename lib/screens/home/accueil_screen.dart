import 'package:bikeapp_v0/utils/card_widget.dart';
import 'package:flutter/material.dart';

import '../../utils/config.dart';

class AccueilScreen extends StatefulWidget {
  const AccueilScreen({Key? key}) : super(key: key);

  @override
  State<AccueilScreen> createState() => _AccueilScreenState();
}

class _AccueilScreenState extends State<AccueilScreen> 
    with SingleTickerProviderStateMixin{
  late TabController _tabController;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = new TabController(length: 3, vsync: this, initialIndex: 0)
      ..addListener(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: Text(
                "Choisir votre vélo",
                style: TextStyle(
                  color: kTextColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 23,
                ),
              ),
            ),
            TabBar(
              isScrollable: true,
              indicatorPadding: EdgeInsets.all(10),
              labelPadding:
                  EdgeInsets.only(left: 18, right: 18, top: 10, bottom: 10),
              labelColor: kTextColor,
              labelStyle: TextStyle(fontSize: 20),
              indicator: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              controller: _tabController,
              tabs: [
                Text(
                  'Favoris',
                  style: TextStyle(fontFamily: 'Varela_Round'),
                ),
                Text('Classique',
                    style: TextStyle(fontFamily: 'Varela_Round')),
                Text('Électrique',
                    style: TextStyle(fontFamily: 'Varela_Round')),
              ],
            ),
          ],
        )),
        Expanded(
          child: TabBarView(controller: _tabController, children: [
            CardWidget(),
            CardWidget(),
            CardWidget(),
          ]),
        )
      ],
    );
  }
}
// body: Column(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: <Widget>[
    //     Padding(
    //       padding: const EdgeInsets.symmetric(horizontal: 30),
    //       child: Text(
    //         "Choisir votre vélo",
    //         style: TextStyle(
    //             color: Colors.blue,
    //             fontWeight: FontWeight.bold,
    //             fontSize: 23),
    //       ),
    //     ),
    //     Types(),
    // Expanded(
    //   child: Padding(
    //     padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
    //     child: GridView.builder(
    //         itemCount: bikes.length,
    //         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //           crossAxisCount: 2,
    //           mainAxisSpacing: kDefaultPaddin,
    //           crossAxisSpacing: kDefaultPaddin,
    //           childAspectRatio: 0.75,
    //         ),
    //         itemBuilder: (context, index) => ItemCard(
    //               product: bikes[index],
    //               press: () => Navigator.push(
    //                   context,
    //                   MaterialPageRoute(
    //                     builder: (context) => DetailsScreen(
    //                       product: bikes[index],
    //                     ),
    //                   )),
    //             )),
    //   ),
    // ),
    //   ],
    // ));

  // // the logout function
  // Future<void> logout(BuildContext context) async {
  //   await FirebaseAuth.instance.signOut();
  //   Navigator.of(context).pushReplacement(
  //       MaterialPageRoute(builder: (context) => LoginScreen()));
  // }
