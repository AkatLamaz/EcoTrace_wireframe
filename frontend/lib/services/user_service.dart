import 'package:http/http.dart' as http;
import 'dart:convert';
import '../constants/endpoints.dart';
import 'auth_service.dart';

class UserService {
  static final UserService _instance = UserService._internal();
  factory UserService() => _instance;
  UserService._internal();

  Future<Map<String, dynamic>> getUserProfile() async {
    final token = await AuthService().getToken();
    final response = await http.get(
      Uri.parse(ApiEndpoints.getUserProfile),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load user profile');
    }
  }

  Future<void> updateUserProfile(Map<String, dynamic> userData) async {
    final token = await AuthService().getToken();
    final response = await http.put(
      Uri.parse(ApiEndpoints.updateUser),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(userData),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update user profile');
    }
  }
}