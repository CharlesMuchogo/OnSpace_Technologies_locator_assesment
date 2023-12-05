class Location {
  Location({
    required this.latitude,
    required this.longitude,
    required this.lastUpdate,
    required this.placeName,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      latitude: json['latitude'] as double,
      longitude: json['longitude'] as double,
      lastUpdate: json['lastUpdate'] as int,
      placeName: json['placeName'].toString(),
    );
  }
  final double latitude;
  final double longitude;
  final int lastUpdate;
  final String placeName;

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'lastUpdate': lastUpdate,
      'placeName': placeName,
    };
  }
}