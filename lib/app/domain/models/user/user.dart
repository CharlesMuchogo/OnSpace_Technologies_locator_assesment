import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:locator/app/domain/models/location/location.dart';
part 'user.g.dart';


@JsonSerializable()
class User  extends Equatable {

  const User({
    required this.id,
    required this.name,
    required this.imageLink,
    required this.location,
    required this.type,
  });
  factory User.fromJson(Map<String, dynamic> json) =>
      _$UserFromJson(json);


  final int id;
  final String name;
  final String imageLink;
  final String type;
  final Location location;

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  List<Object?> get props => [id, name, imageLink, location, type];
}
