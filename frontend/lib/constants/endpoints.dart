class ApiEndpoints {
  static const String baseUrl = 'http://localhost:3000';

  // Auth endpoints
  static const String register = '$baseUrl/auth/register';
  static const String login = '$baseUrl/auth/login';
  static const String logout = '$baseUrl/auth/logout';

  // User endpoints
  static const String updateUser = '$baseUrl/user/update';
  static const String getUserProfile = '$baseUrl/user/profile';

  // Vehicle endpoints
  static const String getVehicles = '$baseUrl/vehicles';
  static const String addVehicle = '$baseUrl/vehicles/add';
  static const String updateVehicle = '$baseUrl/vehicles/update';
  static const String deleteVehicle = '$baseUrl/vehicles/delete';
  
  // Action endpoints
  static const String addTransportAction = '$baseUrl/actions/transport';
  static const String addMealAction = '$baseUrl/actions/meal';
  static const String addEnergyAction = '$baseUrl/actions/energy';
  static const String addFashionAction = '$baseUrl/actions/fashion';
  static const String addPurchaseAction = '$baseUrl/actions/purchase';
  static const String addStreamingAction = '$baseUrl/actions/streaming';
  
  // User actions history
  static const String getUserActions = '$baseUrl/actions/history';
}