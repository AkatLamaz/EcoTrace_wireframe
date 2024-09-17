import 'package:flutter/material.dart';
import '/data/vehicle_service.dart'; // Import the new vehicle service
import 'package:dropdown_search/dropdown_search.dart'; // Import the dropdown_search package

class TransportForm extends StatefulWidget {
  @override
  _TransportFormState createState() => _TransportFormState();
}

class _TransportFormState extends State<TransportForm> {
  List<Map<String, String>> _data = [];
  List<String> _modelNames = [];
  List<String> _divisions = [];
  List<String> _modelYears = [];
  List<String> _fuelTypes = [];
  List<String> _filteredModelNames = [];
  List<String> _filteredFuelTypes = [];
  String _selectedModelName = '';
  String _selectedDivision = '';
  String _selectedModelYear = '';
  String _selectedFuelType = '';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    VehicleService vehicleService = VehicleService();
    List<Map<String, dynamic>> vehicles = await vehicleService.getVehicles();
    setState(() {
      _data = vehicles.map((vehicle) {
        return vehicle.map((key, value) => MapEntry(key, value.toString()));
      }).toList();

      _divisions = _extractUniqueValues('division');
      _modelYears = _extractUniqueValues('model_year');
      _fuelTypes = _extractUniqueValues('fuel_type');

      _filterData(); // Filter data based on initial state
    });
  }

  List<String> _extractUniqueValues(String key) {
    final values = _data.map((item) => item[key]!).toSet().toList();
    values.sort(); // Optional: Sort values alphabetically
    return values;
  }

  void _filterData() {
    // Filter model names based on selected division
    _filteredModelNames = _data
        .where((item) => item['division'] == _selectedDivision)
        .map((item) => item['carline']!)
        .toSet()
        .toList();

    // Filter fuel types based on selected model name
    _filteredFuelTypes = _data
        .where((item) => item['carline'] == _selectedModelName)
        .map((item) => item['fuel_type']!)
        .toSet()
        .toList();

    _filteredModelNames.sort(); // Optional: Sort values alphabetically
    _filteredFuelTypes.sort(); // Optional: Sort values alphabetically

    // Reset selected values if they are not in the filtered lists
    if (!_filteredModelNames.contains(_selectedModelName)) {
      _selectedModelName = '';
    }
    if (!_filteredFuelTypes.contains(_selectedFuelType)) {
      _selectedFuelType = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transport'),
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
                _buildDropdownSearchField('Division', _selectedDivision, (value) {
                  setState(() {
                    _selectedDivision = value;
                    _filterData(); // Update filters based on new selection
                  });
                }, _divisions),
                _buildDropdownSearchField('Model name', _selectedModelName, (value) {
                  setState(() {
                    _selectedModelName = value;
                    _filterData(); // Update filters based on new selection
                  });
                }, _filteredModelNames),
                Row(
                  children: [
                    Expanded(
                      child: _buildDropdownField('Model Year', _selectedModelYear, (value) {
                        setState(() {
                          _selectedModelYear = value;
                        });
                      }, _modelYears),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildDropdownField('Fuel type', _selectedFuelType, (value) {
                        setState(() {
                          _selectedFuelType = value;
                        });
                      }, _filteredFuelTypes),
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

  Widget _buildDropdownSearchField(String label, String selectedValue, ValueChanged<String> onChanged, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 8),
        DropdownSearch<String>(
          items: items,
          selectedItem: selectedValue.isEmpty ? null : selectedValue,
          onChanged: (String? value) {
            if (value != null) {
              onChanged(value);
            }
          },
          dropdownDecoratorProps: DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
              labelText: label,
              border: const OutlineInputBorder(),
              filled: true,
              fillColor: Colors.grey[200],
            ),
          ),
          popupProps: PopupProps.menu(
            showSearchBox: true,
            constraints: const BoxConstraints(maxHeight: 300), // Limit to 4 items
            searchFieldProps: TextFieldProps(
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Search $label',
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField(String label, String selectedValue, ValueChanged<String> onChanged, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: selectedValue.isEmpty ? null : selectedValue,
          items: items.map((item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: (String? value) {
            if (value != null) {
              onChanged(value);
            }
          },
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            filled: true,
            fillColor: Colors.grey[200],
          ),
        ),
      ],
    );
  }
}