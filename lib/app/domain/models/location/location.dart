import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'location.g.dart';

@JsonSerializable()
class Location extends Equatable {
  Location({
    required this.latitude,
    required this.longitude,
    required this.lastUpdate,
    required this.placeName,
  });

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);


  final double latitude;
  final double longitude;
  final int lastUpdate;
  final String placeName;

  Map<String, dynamic> toJson() => _$LocationToJson(this);

  @override
  List<Object?> get props => [latitude,longitude,lastUpdate,placeName];
}
