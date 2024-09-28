import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EnergyForm extends StatefulWidget {
  final Map<String, dynamic> formData;

  EnergyForm({required this.formData});

  @override
  _EnergyFormState createState() => _EnergyFormState();
}

class _EnergyFormState extends State<EnergyForm> {
  final TextEditingController _consumptionController = TextEditingController();

  double _co2Emission = 0.0;

  final Map<String, double> _emissionFactors = {
    'Electricity': 0.8, // kg CO₂/kWh for Poland
    'Natural Gas': 2.0, // kg CO₂/m³
    'Heating Oil': 2.68, // kg CO₂/liter
    'Wood': 0.0, // kg CO₂ (assumed low or zero)
    'Solar Energy': 0.0, // kg CO₂ (assumed low or zero)
    'Wind Energy': 0.0, // kg CO₂ (assumed low or zero)
  };

  final Map<String, String> _units = {
    'Electricity': 'kWh',
    'Natural Gas': 'm³',
    'Heating Oil': 'liters',
    'Wood': 'kg',
    'Solar Energy': 'kWh',
    'Wind Energy': 'kWh',
  };

  String _selectedEnergyType = 'Electricity';

  void _calculateEmissions() {
    setState(() {
      _co2Emission = (double.tryParse(_consumptionController.text) ?? 0.0) * _emissionFactors[_selectedEnergyType]!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Energy Consumption'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildDropdownSearchField('Energy Type', _selectedEnergyType, (value) {
                setState(() {
                  _selectedEnergyType = value;
                });
              }, _emissionFactors.keys.toList()),
              _buildTextField('Consumption (${_units[_selectedEnergyType]})', _consumptionController),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _calculateEmissions,
                child: const Text('Calculate Emissions'),
              ),
              const SizedBox(height: 16),
              _buildEmissionResult('${_selectedEnergyType} CO₂ Emission', _co2Emission),
            ],
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

  Widget _buildTextField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(5),
          ],
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            filled: true,
            fillColor: Colors.grey[200],
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildEmissionResult(String label, double value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$label: ${value.toStringAsFixed(2)} kg CO₂'),
        const SizedBox(height: 8),
      ],
    );
  }
}
