

import 'package:http/http.dart' as http;
import 'package:locator/app/data/repository.dart';
import 'package:locator/app/utils/constants.dart';


class RepositoryImpl implements Repository{
  @override
  Future<http.Response> getUserUpdates({required int id}) async {
    const usersUrl = '$baseUrl/api/v1/updates';
    final response = await http.get(Uri.parse(usersUrl));

      return response;

  }

  @override
  Future<http.Response> getUsers() async {
    const usersUrl = '$baseUrl/api/v1/users';
    final response = await http.get(Uri.parse(usersUrl));

    return response;
  }
  
}
