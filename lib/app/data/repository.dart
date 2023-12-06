

import 'package:http/http.dart' as http;


abstract class Repository{
  Future<http.Response> getUsers();
  Future<http.Response> getUserUpdates({required int id});
}
