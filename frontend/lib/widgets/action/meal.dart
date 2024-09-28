import 'package:flutter/material.dart';
import 'package:xml/xml.dart' as xml;
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:flutter/services.dart'; // Import for input formatters

class MealForm extends StatefulWidget {
  final Map<String, dynamic> formData;

  MealForm({required this.formData});

  @override
  _MealFormState createState() => _MealFormState();
}

class _MealFormState extends State<MealForm> {
  final List<Map<String, String>> _ingredients = [];
  final TextEditingController _weightController = TextEditingController();
  final Map<String, double> _carbonFootprintPer100g = {
    'Tomato': 20.0,
    'Cucumber': 15.0,
    'Lettuce': 10.0,
  };
  String _selectedIngredient = '';

  @override
  void initState() {
    super.initState();
    _initializeSampleIngredients();
  }

  void _initializeSampleIngredients() {
    _ingredients.addAll([
      {'name': 'Tomato', 'weight': '100', 'carbonFootprint': '20'},
      {'name': 'Cucumber', 'weight': '150', 'carbonFootprint': '15'},
      {'name': 'Lettuce', 'weight': '200', 'carbonFootprint': '10'},
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Meal'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildDropdownSearchField('Ingredient Name', _selectedIngredient, (value) {
                setState(() {
                  _selectedIngredient = value;
                });
              }, _carbonFootprintPer100g.keys.toList()),
              _buildTextField('Weight (g)', _weightController, isNumber: true),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _addIngredient,
                child: const Text('Add Ingredient'),
              ),
              const SizedBox(height: 16),
              _buildIngredientList(),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _saveMeal,
                child: const Text('Save Meal'),
              ),
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

  Widget _buildTextField(String label, TextEditingController controller, {bool isNumber = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
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

  void _addIngredient() {
    if (_selectedIngredient.isEmpty || _weightController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please select an ingredient and enter its weight.')));
      return;
    }

    final weight = double.tryParse(_weightController.text) ?? 0.0;
    final carbonFootprintPer100g = _carbonFootprintPer100g[_selectedIngredient] ?? 0.0;
    final carbonFootprint = (weight / 100) * carbonFootprintPer100g;

    setState(() {
      _ingredients.add({
        'name': _selectedIngredient,
        'weight': _weightController.text,
        'carbonFootprint': carbonFootprint.toStringAsFixed(2),
      });
      _selectedIngredient = '';
      _weightController.clear();
    });
  }

  void _removeIngredient(int index) {
    setState(() {
      _ingredients.removeAt(index);
    });
  }

  Widget _buildIngredientList() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: _ingredients.length,
      itemBuilder: (context, index) {
        final ingredient = _ingredients[index];
        return ListTile(
          title: Text(ingredient['name']!),
          subtitle: Text('Weight: ${ingredient['weight']}g, Carbon Footprint: ${ingredient['carbonFootprint']}g CO2'),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => _removeIngredient(index),
          ),
        );
      },
    );
  }

  Future<void> _saveMeal() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/data.xml');
    final builder = xml.XmlBuilder();
    
    builder.processing('xml', 'version="1.0"');
    builder.element('meal', nest: () {
      for (var ingredient in _ingredients) {
        builder.element('ingredient', nest: () {
          builder.element('name', nest: ingredient['name']);
          builder.element('weight', nest: ingredient['weight']);
          builder.element('carbonFootprint', nest: ingredient['carbonFootprint']);
        });
      }
    });

    final xmlDocument = builder.buildDocument();
    await file.writeAsString(xmlDocument.toXmlString(pretty: true));
    setState(() {
      _ingredients.clear();
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Meal saved successfully!')));
  }
}