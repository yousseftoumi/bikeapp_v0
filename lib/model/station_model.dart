class Station {
  final String sid;
  final String name;
  final String address;
  final String nbBikes;

  Station({
    required this.sid,
    required this.name, 
    required this.address, 
    required this.nbBikes
  });
 factory Station.fromMap(map) {
    return Station(
      sid: map['bid'],
      name: map['name'],
      address: map['address'],
      nbBikes: map['nbBikes'],
    );
  }
  Map<String, dynamic> toMap() => {
    "id": sid,
    "name": name,
    "address": address,
    "nbBikes": nbBikes
  };

}