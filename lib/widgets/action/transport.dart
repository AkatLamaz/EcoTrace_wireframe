import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'dart:async';
import 'dart:io';
import '../../../converter.dart';
import '/data/2010.csv';

class TransportForm extends StatefulWidget {
  @override
  _TransportFormState createState() => _TransportFormState();
}

class _TransportFormState extends State<TransportForm> {
  List<Map<String, String>> _data = [];
  String _selectedModelName = '';
  String _selectedDivision = '';
  String _selectedModelYear = '';
  String _selectedFuelType = '';

  @override
  void initState() {
    super.initState();
    _loadCSV();
  }

  Future<void> _loadCSV() async {
    String csvData = await DefaultAssetBundle.of(context).loadString('/data/2010.csv');
    List<List<dynamic>> csvTable = const CsvToListConverter().convert(csvData);
    setState(() {
      _data = csvTable.skip(1).map((row) {
        return Map.fromIterables(csvTable[0].cast<String>(), row.map((cell) => cell.toString()));
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transport'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height - kToolbarHeight - 48,
            ),
            child: Column(
              children: [
                _buildDropdownField('Model name', _selectedModelName, (value) {
                  setState(() {
                    _selectedModelName = value;
                  });
                }, 'Carline'),
                _buildDropdownField('Division', _selectedDivision, (value) {
                  setState(() {
                    _selectedDivision = value;
                  });
                }, 'Division'),
                Row(
                  children: [
                    Expanded(
                      child: _buildDropdownField('Model Year', _selectedModelYear, (value) {
                        setState(() {
                          _selectedModelYear = value;
                        });
                      }, 'Model Yr'),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: _buildDropdownField('Fuel type', _selectedFuelType, (value) {
                        setState(() {
                          _selectedFuelType = value;
                        });
                      }, 'Fuel Usage Desc - Conventional Fuel'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownField(String label, String selectedValue, ValueChanged<String> onChanged, String csvKey) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: selectedValue.isEmpty ? null : selectedValue,
          items: _data.map((item) {
            return DropdownMenuItem<String>(
              value: item[csvKey],
              child: Text(item[csvKey]!),
            );
          }).toList(),
          onChanged: (String? value) {
            if (value != null) {
              onChanged(value);
            }
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            fillColor: Colors.grey[200],
          ),
        ),
      ],
    );
  }
}