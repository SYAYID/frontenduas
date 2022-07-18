import 'dart:convert';
import 'package:http/http.dart' as client;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:cruduas3/models/auth_model.dart';

class AuthService {
  final String baseURL = 'http://10.0.2.2:8000';

  Future<bool> register(AuthModel authModel) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    final response = await client.post(Uri.parse(baseURL + '/api/register'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: authToJson(authModel));

    if (response.statusCode == 201) {
      final dynamic jsonResponse = json.decode(response.body);

      sharedPreferences.setInt('userId', jsonResponse['user']['id']);
      sharedPreferences.setString('token', jsonResponse['token']);

      return true;
    }

    return false;
  }

  Future<bool> login(AuthModel authModel) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    final response = await client.post(Uri.parse(baseURL + '/api/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: authToJson(authModel));

    if (response.statusCode == 201) {
      final dynamic jsonResponse = json.decode(response.body);

      sharedPreferences.setInt('userId', jsonResponse['user']['id']);
      sharedPreferences.setString('token', jsonResponse['token']);

      return true;
    }

    return false;
  }
}
