import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme_provider.dart';
import '../../constants/style.dart';
import '/data/vehicle_service.dart'; 
import 'package:dropdown_search/dropdown_search.dart'; 

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

      _filterData(); 
    });
  }

  List<String> _extractUniqueValues(String key) {
    final values = _data.map((item) => item[key]!).toSet().toList();
    values.sort(); 
    return values;
  }

  void _filterData() {
    _filteredModelNames = _data
        .where((item) => item['division'] == _selectedDivision)
        .map((item) => item['carline']!)
        .toSet()
        .toList();

    _filteredFuelTypes = _data
        .where((item) => item['carline'] == _selectedModelName)
        .map((item) => item['fuel_type']!)
        .toSet()
        .toList();

    _filteredModelNames.sort(); 
    _filteredFuelTypes.sort(); 

    if (!_filteredModelNames.contains(_selectedModelName)) {
      _selectedModelName = '';
    }
    if (!_filteredFuelTypes.contains(_selectedFuelType)) {
      _selectedFuelType = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Transport'),
            centerTitle: true, // Center the title
            backgroundColor: themeProvider.isDarkMode ? dark(context) : light(context),
            automaticallyImplyLeading: false, // Remove the back button
            titleTextStyle: TextStyle(
              color: themeProvider.isDarkMode ? light(context) : dark(context),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
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
                        _filterData();
                      });
                    }, _divisions),
                    _buildDropdownSearchField('Model name', _selectedModelName, (value) {
                      setState(() {
                        _selectedModelName = value;
                        _filterData();
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
      },
    );
  }

  Widget _buildDropdownSearchField(String label, String selectedValue, ValueChanged<String> onChanged, List<String> items) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) => Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: themeProvider.isDarkMode 
                    ? lightGrey(context)
                    : dark(context),
              ),
            ),
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
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: themeProvider.isDarkMode
                          ? Colors.white.withOpacity(0.1)
                          : lightGrey(context).withOpacity(0.5),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: themeProvider.isDarkMode
                          ? Colors.white.withOpacity(0.1)
                          : lightGrey(context).withOpacity(0.5),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: active,
                      width: 2,
                    ),
                  ),
                  filled: true,
                  fillColor: themeProvider.isDarkMode
                      ? cardBackgroundColor
                      : Colors.white,
                ),
              ),
              popupProps: PopupProps.menu(
                showSearchBox: true,
                constraints: const BoxConstraints(maxHeight: 300),
                searchFieldProps: TextFieldProps(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    labelText: 'Search $label',
                    labelStyle: TextStyle(
                      color: themeProvider.isDarkMode
                          ? Colors.white.withOpacity(0.7)
                          : lightGrey(context),
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: themeProvider.isDarkMode
                          ? Colors.white.withOpacity(0.7)
                          : lightGrey(context),
                    ),
                  ),
                ),
                menuProps: MenuProps(
                  backgroundColor: themeProvider.isDarkMode
                      ? cardBackgroundColor
                      : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownField(String label, String selectedValue, ValueChanged<String> onChanged, List<String> items) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) => Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: themeProvider.isDarkMode
                    ? lightGrey(context)
                    : dark(context),
              ),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: selectedValue.isEmpty ? null : selectedValue,
              items: items.map((item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: TextStyle(
                      color: themeProvider.isDarkMode
                          ? Colors.white
                          : dark(context),
                    ),
                  ),
                );
              }).toList(),
              onChanged: (String? value) {
                if (value != null) {
                  onChanged(value);
                }
              },
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: themeProvider.isDarkMode
                        ? Colors.white.withOpacity(0.1)
                        : lightGrey(context).withOpacity(0.5),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: themeProvider.isDarkMode
                        ? Colors.white.withOpacity(0.1)
                        : lightGrey(context).withOpacity(0.5),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: active,
                    width: 2,
                  ),
                ),
                filled: true,
                fillColor: themeProvider.isDarkMode
                    ? cardBackgroundColor
                    : Colors.white,
              ),
              icon: Icon(
                Icons.arrow_drop_down,
                color: themeProvider.isDarkMode
                    ? Colors.white.withOpacity(0.7)
                    : lightGrey(context),
              ),
              dropdownColor: themeProvider.isDarkMode
                  ? cardBackgroundColor
                  : Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
