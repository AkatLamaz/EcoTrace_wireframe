import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PurchaseForm extends StatefulWidget {
  final Map<String, dynamic> formData;

  const PurchaseForm({super.key, required this.formData});

  @override
  _PurchaseFormState createState() => _PurchaseFormState();
}

class _PurchaseFormState extends State<PurchaseForm> {
  final TextEditingController _amountController = TextEditingController();

  double _co2Emission = 0.0;

  final Map<String, double> _emissionFactors = {
    'Electronics': 1.5, // kg CO₂ per unit
    'Clothing': 0.8, // kg CO₂ per unit
    'Furniture': 2.0, // kg CO₂ per unit
    'Books': 0.2, // kg CO₂ per unit
  };

  String _selectedPurchaseType = 'Electronics';

  void _calculateEmissions() {
    setState(() {
      _co2Emission = (double.tryParse(_amountController.text) ?? 0.0) * _emissionFactors[_selectedPurchaseType]!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Purchase Consumption'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildDropdownSearchField('Purchase Type', _selectedPurchaseType, (value) {
                setState(() {
                  _selectedPurchaseType = value;
                });
              }, _emissionFactors.keys.toList()),
              _buildTextField('Amount Purchased', _amountController),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _calculateEmissions,
                child: const Text('Calculate Emissions'),
              ),
              const SizedBox(height: 16),
              _buildEmissionResult('$_selectedPurchaseType CO₂ Emission', _co2Emission),
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
