import 'package:bikeapp_v0/model/slide.dart';
import 'package:bikeapp_v0/screens/auth/login_screen.dart';
import 'package:bikeapp_v0/screens/home/home_screen.dart';
import 'package:bikeapp_v0/screens/profile/slidesitem.dart';
import 'package:flutter/material.dart';

class GettingStarted extends StatefulWidget {
  const GettingStarted({Key? key}) : super(key: key);

  @override
  State<GettingStarted> createState() => _GettingStartedState();
}

class _GettingStartedState extends State<GettingStarted> {
  final PageController _pageController = PageController(
    initialPage: 0,
  );

  final int _numPages = 3;

  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      height: 2.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        gradient: isActive
            ? /*Color(0xff326789)*/ LinearGradient(
                colors: const [Colors.blue, Colors.cyan],
                stops: const [0.1, 0.9])
            : LinearGradient(colors: const [Colors.grey, Colors.blueGrey]),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(children: <Widget>[
            Expanded(
              child: PageView.builder(
                scrollDirection: Axis.horizontal,
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                itemCount: slideList.length,
                itemBuilder: (ctx, i) => SlideItem(i),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildPageIndicator(),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        gradient: const LinearGradient(colors: [
                          Color.fromARGB(255, 33, 69, 228),
                          Colors.cyan
                        ], stops: [
                          0.1,
                          0.9
                        ])),
                    child: FlatButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()));
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      color: Colors.transparent,
                      textColor: Colors.white,
                      child: const Text(
                        'Rejoinez nous!',
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Sfpro',
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Vous êtes un pompier ?',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Sfpro',
                          color: Color.fromARGB(255, 33, 69, 228),
                        ),
                      ),
                      FlatButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomeScreen()));
                        },
                        child: Text(
                          'Se connecter',
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Sfpro',
                              color: Color.fromARGB(255, 33, 69, 228),
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
