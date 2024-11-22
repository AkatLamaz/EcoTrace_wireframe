import 'package:http/http.dart' as http;
import 'dart:convert';
import '../constants/endpoints.dart';
import 'auth_service.dart';

class ActionsService {
  static final ActionsService _instance = ActionsService._internal();
  factory ActionsService() => _instance;
  ActionsService._internal();

  Future<void> addTransportAction(Map<String, dynamic> data) async {
    final token = await AuthService().getToken();
    final response = await http.post(
      Uri.parse(ApiEndpoints.addTransportAction),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode != 201) {
      throw Exception(jsonDecode(response.body)['message'] ?? 'Failed to add transport action');
    }
  }
}