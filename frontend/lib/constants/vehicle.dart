import 'package:http/http.dart' as http;
import 'dart:convert';
import 'endpoints.dart';

class VehicleService {
  Future<List<Map<String, dynamic>>> getVehicles() async {
    final response = await http.get(Uri.parse(ApiEndpoints.getVehicles));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((vehicle) => vehicle as Map<String, dynamic>).toList();
    } else {
      throw Exception('Failed to load vehicles');
    }
  }

  Future<void> addVehicle(Map<String, dynamic> vehicle) async {
    final response = await http.post(
      Uri.parse(ApiEndpoints.addVehicle),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(vehicle),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to add vehicle');
    }
  }

  Future<void> updateVehicle(Map<String, dynamic> vehicle) async {
    final response = await http.put(
      Uri.parse(ApiEndpoints.updateVehicle),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(vehicle),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update vehicle');
    }
  }

  Future<void> deleteVehicle(String vehicleId) async {
    final response = await http.delete(
      Uri.parse('${ApiEndpoints.deleteVehicle}/$vehicleId'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete vehicle');
    }
  }
}