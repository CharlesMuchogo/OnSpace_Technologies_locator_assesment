// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Location _$LocationFromJson(Map<String, dynamic> json) => Location(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      lastUpdate: json['lastUpdate'] as int,
      placeName: json['placeName'] as String,
    );

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'lastUpdate': instance.lastUpdate,
      'placeName': instance.placeName,
    };
