import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String baseUrl = "http://192.168.30.138/practice_api/auth.php";

  static Future<Map<String, dynamic>> registerUser(
      String name, String email, String password, String role) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "action": "register",
        "name": name,
        "email": email,
        "password": password,
        "role": role
      }),
    );

    return jsonDecode(response.body);
  }

  static Future<Map<String, dynamic>> loginUser(
      String email, String password) async {
    var response = await http.post(
      Uri.parse(baseUrl),
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

