class ApiEndpoints {
  static const String baseUrl = 'http://localhost:3000';

  // Endpointy dla pojazdów
  static const String getVehicles = '$baseUrl/pojazdy';
  static const String addVehicle = '$baseUrl/pojazdy/add';
  static const String updateVehicle = '$baseUrl/pojazdy/update';
  static const String deleteVehicle = '$baseUrl/pojazdy/delete';

  // Endpointy dla rejestracji i logowania
  static const String register = '$baseUrl/register';
  static const String login = '$baseUrl/login';
}