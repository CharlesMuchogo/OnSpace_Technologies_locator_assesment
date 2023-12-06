import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:locator/app/data/repository.dart';

class MockRepositoryImpl implements Repository {
  List<Map<String, dynamic>> users = [
    {
      'id': 121212,
      'name': 'Alice',
      'imageLink': 'https://images.pexels.com/photos/1239291/pexels-photo-1239291.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      'location': {
        'latitude': -1.2655367,
        'longitude': 36.8104826,
        'lastUpdate': 1634778081000,
        'placeName': 'Nairobi CBD',
      },
    },
    {
      'id': 123491,
      'name': 'Bob',
      'imageLink': 'https://images.pexels.com/photos/91224/pexels-photo-91224.jpeg?auto=compress&cs=tinysrgb&w=1600',
      'location': {
        'latitude': -1.2655367,
        'longitude': 36.8114826,
        'lastUpdate': 1634778082000,
        'placeName': 'Koja Round about',
      },
    },
  ];

  List<Map<String, dynamic>> updates = [
    {
      'latitude': -1.2655367,
      'longitude': 36.8104826,
      'lastUpdate': 1634778081000,
      'placeName': 'Nairobi CBD',
    },
    {
      'latitude': -1.2655367,
      'longitude': 36.8114826,
      'lastUpdate': 1634778082000,
      'placeName': 'Koja Round about',
    },
    {
      'latitude': -1.2655367,
      'longitude': 36.8094826,
      'lastUpdate': 1634778083000,
      'placeName': 'Parklands',
    },
    {
      'latitude': -1.2665367,
      'longitude': 36.8104826,
      'lastUpdate': 1634778084000,
      'placeName': 'parklands',
    }
  ];

  @override
  Future<http.Response> getUserUpdates({required int id}) async {
    final response =
        await Future<void>.delayed(const Duration(seconds: 3)).then(
      (value) => http.Response(
        jsonEncode(updates),
        200,
        headers: {'content-type': 'application/json'},
      ),
    );
    return response;
  }

  @override
  Future<http.Response> getUsers() async {
    final response =
        await Future<void>.delayed(const Duration(seconds: 3)).then(
      (value) => http.Response(
        jsonEncode(users),
        200,
        headers: {'content-type': 'application/json'},
      ),
    );
    log('passing here ');
    return response;
  }
}
