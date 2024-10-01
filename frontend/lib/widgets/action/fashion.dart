import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FashionForm extends StatefulWidget {
  final Map<String, dynamic> formData;

  const FashionForm({super.key, required this.formData});

  @override
  _FashionFormState createState() => _FashionFormState();
}

class _FashionFormState extends State<FashionForm> {
  final TextEditingController _itemsController = TextEditingController();

  double _co2Emission = 0.0;

  final Map<String, double> _emissionFactors = {
    'T-Shirt': 2.5, // kg CO₂ per item
    'Jeans': 10.0, // kg CO₂ per item
    'Jacket': 15.0, // kg CO₂ per item
    'Shoes': 5.0, // kg CO₂ per item
  };

  String _selectedFashionItem = 'T-Shirt';

  void _calculateEmissions() {
    setState(() {
      _co2Emission = (double.tryParse(_itemsController.text) ?? 0.0) * _emissionFactors[_selectedFashionItem]!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fashion Consumption'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildDropdownSearchField('Fashion Item', _selectedFashionItem, (value) {
                setState(() {
                  _selectedFashionItem = value;
                });
              }, _emissionFactors.keys.toList()),
              _buildTextField('Number of Items', _itemsController),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _calculateEmissions,
                child: const Text('Calculate Emissions'),
              ),
              const SizedBox(height: 16),
              _buildEmissionResult('$_selectedFashionItem CO₂ Emission', _co2Emission),
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
