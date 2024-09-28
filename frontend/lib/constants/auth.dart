import 'package:http/http.dart' as http;
import 'dart:convert';
import 'endpoints.dart';

class AuthService {
  Future<void> register(String email, String password) async {
    final response = await http.post(
      Uri.parse(ApiEndpoints.register),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to register');
    }
  }

  Future<void> login(String email, String password) async {
    final response = await http.post(
      Uri.parse(ApiEndpoints.login),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to login');
    }
  }
}