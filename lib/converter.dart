import 'dart:convert';
import 'dart:io';
import 'package:csv/csv.dart';

class CsvDataLoader {
  List<Map<String, String>> data = [];

  // Konstruktor klasy, który pobiera dane z pliku CSV
  CsvDataLoader(String filePath) {
    _loadCsv(filePath);
  }

  // Funkcja do ładowania CSV z pliku
  void _loadCsv(String filePath) async {
    final file = File(filePath);
    final input = file.openRead();
    final fields = await input
        .transform(utf8.decoder)
        .transform(const CsvToListConverter())
        .toList();

    if (fields.isNotEmpty) {
      // Zakładamy, że pierwsza linia to nagłówki kolumn
      List<String> headers = fields[0].cast<String>();

      // Przetwarzamy każdą kolejną linię CSV na mapę
      for (var i = 1; i < fields.length; i++) {
        List<dynamic> row = fields[i];
        Map<String, String> rowMap = {};

        for (var j = 0; j < headers.length; j++) {
          rowMap[headers[j]] = row[j].toString();
        }

        data.add(rowMap);
      }
    }
  }

  // Metoda zwracająca dane
  List<Map<String, String>> getData() {
    return data;
  }

  // Metoda filtrująca dane po kluczu i wartości
  List<Map<String, String>> filterData(String key, String value) {
    return data.where((row) => row[key] == value).toList();
  }
}
