import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme_provider.dart';
import '../../constants/style.dart';
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
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Fashion Consumption'),
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
                  _buildDropdownSearchField('Fashion Item', _selectedFashionItem, (value) {
                    setState(() {
                      _selectedFashionItem = value;
                    });
                  }, _emissionFactors.keys.toList()),
                  _buildTextField('Number of Items', _itemsController),
                  const SizedBox(height: 16),
                  _buildActionButton(
                    text: 'Calculate Emissions',
                    onPressed: _calculateEmissions,
                  ),
                  const SizedBox(height: 16),
                  _buildEmissionResult('$_selectedFashionItem CO₂ Emission', _co2Emission),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDropdownSearchField(String label, String selectedValue, ValueChanged<String> onChanged, List<String> items) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Theme.of(context).brightness == Brightness.light 
                  ? dark(context) 
                  : lightGrey(context),
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
                    color: Theme.of(context).brightness == Brightness.light 
                        ? dark(context) 
                        : Colors.white,
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
                  color: lightGrey(context).withOpacity(0.5),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: lightGrey(context).withOpacity(0.5),
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
              fillColor: Theme.of(context).brightness == Brightness.light 
                  ? Colors.white 
                  : cardBackgroundColor,
            ),
            icon: Icon(
              Icons.arrow_drop_down,
              color: lightGrey(context),
            ),
            dropdownColor: Theme.of(context).brightness == Brightness.light 
                ? Colors.white 
                : cardBackgroundColor,
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {bool isNumber = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Theme.of(context).brightness == Brightness.light 
                  ? dark(context) 
                  : lightGrey(context),
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            keyboardType: isNumber ? TextInputType.number : TextInputType.text,
            inputFormatters: isNumber
                ? <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(5),
                  ]
                : null,
            style: TextStyle(
              color: Theme.of(context).brightness == Brightness.light 
                  ? dark(context) 
                  : Colors.white,
            ),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: lightGrey(context).withOpacity(0.5),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: lightGrey(context).withOpacity(0.5),
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
              fillColor: Theme.of(context).brightness == Brightness.light 
                  ? Colors.white 
                  : cardBackgroundColor,
            ),
          ),
        ],
      ),
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

  Widget _buildActionButton({
    required String text,
    required VoidCallback onPressed,
    bool isPrimary = true,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isPrimary ? active : Colors.transparent,
          foregroundColor: isPrimary 
              ? Colors.white 
              : Theme.of(context).brightness == Brightness.light
                  ? dark(context)
                  : Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: isPrimary 
                ? BorderSide.none
                : BorderSide(
                    color: Theme.of(context).brightness == Brightness.light
                        ? lightGrey(context)
                        : Colors.white.withOpacity(0.2),
                  ),
          ),
          elevation: isPrimary ? 2 : 0,
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
