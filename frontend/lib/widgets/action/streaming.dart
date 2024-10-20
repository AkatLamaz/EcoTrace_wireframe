import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme_provider.dart';
import '../../constants/style.dart';
import 'package:flutter/services.dart';

class StreamingForm extends StatefulWidget {
  final Map<String, dynamic> formData;

  const StreamingForm({super.key, required this.formData});

  @override
  _StreamingFormState createState() => _StreamingFormState();
}

class _StreamingFormState extends State<StreamingForm> {
  final TextEditingController _hoursController = TextEditingController();

  double _co2Emission = 0.0;

  final Map<String, double> _emissionFactors = {
    'Netflix': 0.2, // kg CO₂ per hour
    'YouTube': 0.1, // kg CO₂ per hour
    'Amazon Prime': 0.15, // kg CO₂ per hour
    'Disney+': 0.12, // kg CO₂ per hour
  };

  String _selectedStreamingService = 'Netflix';

  void _calculateEmissions() {
    setState(() {
      _co2Emission = (double.tryParse(_hoursController.text) ?? 0.0) * _emissionFactors[_selectedStreamingService]!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Streaming Consumption'),
            centerTitle: true,
            backgroundColor: themeProvider.isDarkMode ? dark(context) : light(context),
            automaticallyImplyLeading: false,
            titleTextStyle: TextStyle(
              color: themeProvider.isDarkMode ? light(context) : dark(context),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _buildDropdownSearchField('Streaming Service', _selectedStreamingService, (value) {
                    setState(() {
                      _selectedStreamingService = value;
                    });
                  }, _emissionFactors.keys.toList()),
                  _buildTextField('Hours Watched', _hoursController),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _calculateEmissions,
                    child: const Text('Calculate Emissions'),
                  ),
                  const SizedBox(height: 16),
                  _buildEmissionResult('$_selectedStreamingService CO₂ Emission', _co2Emission),
                ],
              ),
            ),
          ),
        );
      },
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
