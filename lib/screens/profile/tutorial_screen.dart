import 'package:bikeapp_v0/model/slide.dart';
import 'package:bikeapp_v0/screens/auth/login_screen.dart';
import 'package:bikeapp_v0/screens/profile/slidesitem.dart';
import 'package:bikeapp_v0/utils/config.dart';
import 'package:flutter/material.dart';

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({Key? key}) : super(key: key);

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
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
            ? /*Color(0xff326789)*/ const LinearGradient(
                colors: [Colors.blue, Colors.cyan], stops: [0.1, 0.9])
            : const LinearGradient(colors: [Colors.grey, Colors.blueGrey]),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: app_bar(context, "Visite guidée"),
      body: Container(
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
          ]),
        ),
      ),
    );
  }
}
