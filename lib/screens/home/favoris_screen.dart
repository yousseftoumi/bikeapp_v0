import 'package:flutter/material.dart';

class FavorisScreen extends StatefulWidget {
  const FavorisScreen({Key? key}) : super(key: key);

  @override
  State<FavorisScreen> createState() => _FavorisScreenState();
}

class _FavorisScreenState extends State<FavorisScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Favoris"),
    );
  }
}
