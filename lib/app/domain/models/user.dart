

import 'location.dart';

class User {

  User({
    required this.id,
    required this.name,
    required this.imageLink,
    required this.location,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      name: json['name'].toString(),
      imageLink: json['imageLink'].toString(),
      location: Location.fromJson(json['location'] as Map<String, dynamic>),
    );
  }
  final int id;
  final String name;
  final String imageLink;
  final Location location;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageLink': imageLink,
      'location': location.toJson(),
    };
  }
}
