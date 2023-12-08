import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:locator/app/data/repository.dart';

class MockRepositoryImpl implements Repository {
  MockRepositoryImpl({this.testFailure = false});
  final bool testFailure;

  List<Map<String, dynamic>> users = [
    {
      'id': 121212,
      'name': 'Alice',
      'user_type': 'people',
      'imageLink': 'https://images.pexels.com/photos/1239291/pexels-photo-1239291.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      'location': {
        'latitude': -1.2655367,
        'longitude': 36.8104826,
        'lastUpdate': 1701976887000,
        'placeName': 'Nairobi CBD'
      }
    },
    {
      'id': 1326697,
      'name': 'iPhone',
      'user_type': 'items',
      'imageLink': 'https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/iphone-15-pro-finish-select-202309-6-7inch-naturaltitanium?wid=5120&hei=2880&fmt=p-jpg&qlt=80&.v=1692845702708',
      'location': {
        'latitude': -1.2645367,
        'longitude': 36.8204826,
        'lastUpdate': 1701976887000,
        'placeName': 'Westlands'
      }
    },
    {
      'id': 123491,
      'name': 'Bob',
      'user_type': 'people',
      'imageLink': 'https://images.pexels.com/photos/91224/pexels-photo-91224.jpeg?auto=compress&cs=tinysrgb&w=1600',
      'location': {
        'latitude': -1.2655367,
        'longitude': 36.8114826,
        'lastUpdate': 1701976888000,
        'placeName': 'Koja Round about'
      }
    },
    {
      'id': 132657,
      'name': 'Keys',
      'user_type': 'items',
      'imageLink': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSJ0nS-Uj2s0byk9yqOcyIYAVqiws5StWcTj1DrKbCfMw&s',
      'location': {
        'latitude': -1.2655367,
        'longitude': 36.8104826,
        'lastUpdate': 1701976887000,
        'placeName': 'Westlands'
      }
    }
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

  Map<String, String> errorResponse = {'message':'error'};

  @override
  Future<http.Response> getUserUpdates({required int id}) async {
    late http.Response response;

    if(testFailure){
      response = await Future<void>.delayed(const Duration(seconds: 3)).then(
            (value) => http.Response(
          jsonEncode(errorResponse),
          500,
          headers: {'content-type': 'application/json'},
        ),
      );
    }else{
      response = await Future<void>.delayed(const Duration(seconds: 3)).then(
            (value) => http.Response(
          jsonEncode(updates),
          200,
          headers: {'content-type': 'application/json'},
        ),
      );
    }
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
