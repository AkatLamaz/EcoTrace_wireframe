import 'package:postgres/postgres.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  late PostgreSQLConnection _connection;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<void> connect() async {
    _connection = PostgreSQLConnection(
      '127.0.0.1', // Host serwera
      5432, // Port PostgreSQL
      'Ecotrace', // Nazwa bazy danych
      username: 'postgres', // Użytkownik PostgreSQL
      password: '1111', // Hasło użytkownika
    );
    await _connection.open();
    print('Connected to the database!');
  }

  Future<List<Map<String, dynamic>>> getVehicles() async {
    // Wykonanie zapytania SELECT do tabeli 'pojazdy'
    List<List<dynamic>> results = await _connection.query('SELECT * FROM pojazdy');

    // Zamiana wyników na listę map
    List<Map<String, dynamic>> vehicles = results.map((row) {
      return {
        'model_year': row[0],
        'manufacturer_name': row[1],
        'division': row[2],
        'carline': row[3],
        'gearbox': row[4],
        'fuel_usage': row[5],
        'fuel_type': row[6],
      };
    }).toList();

    return vehicles;
  }
}

void main() async {
  // Tworzymy instancję klasy DatabaseHelper
  final dbHelper = DatabaseHelper();

  // Nawiązujemy połączenie z bazą danych
  await dbHelper.connect();

  // Pobieramy dane pojazdów
  final vehicles = await dbHelper.getVehicles();

  // Wyświetlamy pobrane dane
  vehicles.forEach((vehicle) {
    print(vehicle);
  });
}