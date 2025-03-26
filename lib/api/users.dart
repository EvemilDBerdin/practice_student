import 'package:http/http.dart' as http;
import 'package:crudtutorial/values/app_constants.dart';
import 'dart:convert';

class ApiService { 
  
  static Future<Map<String, dynamic>> registerUser(String name, String email, String password, String role) async {
    print('test2');
    final response = await http.post(
      Uri.parse(AppConstants.authUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "action": "register",
        "name": name,
        "email": email,
        "password": password,
        "role": role
      }),
    ); 
    print('test3');
    return jsonDecode(response.body);
  }

  static Future<Map<String, dynamic>> loginUser(String email, String password) async {
    final response = await http.post(
      Uri.parse(AppConstants.authUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "action": "login",
        "email": email,
        "password": password,
      }),
    ); 
    return jsonDecode(response.body);
  }


}

