class UserModel {
  String? uid;
  String? email;
  String? name;
  String? birthDate;
  String? imageUrl;
  String? provider;

  UserModel({this.uid, this.email, this.name,this.birthDate, this.imageUrl, this.provider});

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      name: map['name'],
      birthDate: map['birthDate'],
      imageUrl: map['imageUrl'],
      provider: map['provider'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'birthDate': birthDate,
      'imageUrl': imageUrl,
      'provider': provider,
    };
  }
}
