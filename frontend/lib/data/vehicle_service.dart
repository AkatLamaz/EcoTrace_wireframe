import 'package:http/http.dart' as http;
import 'dart:convert';

class VehicleService {
  static const String apiUrl = 'http://localhost:3000/pojazdy';

  Future<List<Map<String, dynamic>>> getVehicles() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((vehicle) => vehicle as Map<String, dynamic>).toList();
    } else {
      throw Exception('Failed to load vehicles');
    }
  }
}