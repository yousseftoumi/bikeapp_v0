import 'package:flutter/material.dart';

enum BikeType { classic, electric }

class BikeModel {
  String? bid;
  BikeType? type;
  String? brand;
  int? speed;
  String? description;
  int? range;
  double? rating;
  String? image;
  String? currentStation;

  // BikeModel({this.bid, this.email, this.firstName, this.lastName});
  BikeModel(
      {this.bid,
      this.type,
      this.brand,
      this.speed,
      this.description,
      this.range,
      this.rating,
      this.image,
      this.currentStation});

  // receiving data from server
  factory BikeModel.fromMap(map) {
    return BikeModel(
      bid: map['bid'],
      type: map['type'],
      brand: map['brand'],
      speed: map['speed'],
      description: map['description'],
      range: map['range'],
      rating: map['rating'],
      image: map['image'],
      currentStation: map['currentStation'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'bid': bid,
      'type': type,
      'brand': brand,
      'speed': speed,
      'description': description,
      'range': range,
      'rating': rating,
      'currentStation': currentStation,
    };
  }
}

List<BikeModel> bikes = [
  BikeModel(
      bid: "1",
      type: BikeType.classic,
      speed: 40,
      description: dummyText,
      image: "assets/bikeAppLogo.png",
      rating: 4.5),
  BikeModel(
      bid: "2",
      type: BikeType.electric,
      speed: 35,
      description: dummyText,
      image: "assets/bikeAppLogo.png",
      rating: 4.5),
  BikeModel(
      bid: "3",
      type: BikeType.classic,
      speed: 40,
      description: dummyText,
      image: "assets/bikeAppLogo.png",
      rating: 4.5),
  BikeModel(
      bid: "4",
      type: BikeType.classic,
      speed: 40,
      description: dummyText,
      image: "assets/bikeAppLogo.png",
      rating: 4.5),
  BikeModel(
      bid: "5",
      type: BikeType.electric,
      speed: 40,
      description: dummyText,
      image: "assets/bikeAppLogo.png",
      rating: 4.5),
  BikeModel(
      bid: "6",
      type: BikeType.classic,
      speed: 40,
      description: dummyText,
      image: "assets/bikeAppLogo.png",
      rating: 4.5),
];

String dummyText =
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since. When an unknown printer took a galley.";
