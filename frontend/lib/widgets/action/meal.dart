import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme_provider.dart';
import '../../constants/style.dart';
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
  final List<Map<String, dynamic>> _savedMeals = [
    {
      'name': 'Vegetable Salad',
      'ingredients': [
        {'name': 'Tomato', 'weight': '100', 'carbonFootprint': '20'},
        {'name': 'Cucumber', 'weight': '150', 'carbonFootprint': '15'},
        {'name': 'Lettuce', 'weight': '200', 'carbonFootprint': '10'},
      ],
      'totalCarbonFootprint': '45.0'
    },
  ];
  
  final TextEditingController _mealNameController = TextEditingController();
  bool _isCreatingNewMeal = false;
  String _selectedMeal = '';

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
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(_isCreatingNewMeal ? 'Create New Meal' : 'Select Meal'),
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
                  if (!_isCreatingNewMeal) ...[
                    _buildDropdownSearchField(
                      'Select Existing Meal',
                      _selectedMeal,
                      (value) {
                        setState(() {
                          _selectedMeal = value;
                        });
                      },
                      _savedMeals.map((meal) => meal['name'] as String).toList(),
                    ),
                    const SizedBox(height: 16),
                    _buildActionButton(
                      text: 'Create New Meal',
                      onPressed: () {
                        setState(() {
                          _isCreatingNewMeal = true;
                          _ingredients.clear();
                          _mealNameController.clear();
                        });
                      },
                    ),
                    if (_selectedMeal.isNotEmpty) ...[
                      const SizedBox(height: 16),
                      _buildSelectedMealDetails(),
                    ],
                  ] else ...[
                    _buildTextField('Meal Name', _mealNameController),
                    const SizedBox(height: 16),
                    _buildDropdownSearchField(
                      'Add Ingredient',
                      _selectedIngredient,
                      (value) {
                        setState(() {
                          _selectedIngredient = value;
                        });
                      },
                      _carbonFootprintPer100g.keys.toList(),
                    ),
                    _buildTextField('Weight (g)', _weightController, isNumber: true),
                    const SizedBox(height: 16),
                    _buildActionButton(
                      text: 'Add Ingredient',
                      onPressed: _addIngredient,
                    ),
                    const SizedBox(height: 16),
                    _buildIngredientList(),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: _buildActionButton(
                            text: 'Save Meal',
                            onPressed: _saveMeal,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildActionButton(
                            text: 'Cancel',
                            onPressed: () {
                              setState(() {
                                _isCreatingNewMeal = false;
                                _ingredients.clear();
                                _mealNameController.clear();
                              });
                            },
                            isPrimary: false,
                          ),
                        ),
                      ],
                    ),
                  ],
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
    if (_mealNameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a meal name')),
      );
      return;
    }

    if (_ingredients.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add at least one ingredient')),
      );
      return;
    }

    final totalCarbonFootprint = _ingredients
        .map((ing) => double.parse(ing['carbonFootprint']!))
        .reduce((a, b) => a + b)
        .toStringAsFixed(2);

    setState(() {
      _savedMeals.add({
        'name': _mealNameController.text,
        'ingredients': List.from(_ingredients),
        'totalCarbonFootprint': totalCarbonFootprint,
      });
      _isCreatingNewMeal = false;
      _ingredients.clear();
      _mealNameController.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Meal saved successfully!')),
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

  Widget _buildSelectedMealDetails() {
    final selectedMealData = _savedMeals.firstWhere(
      (meal) => meal['name'] == _selectedMeal,
      orElse: () => {'name': '', 'ingredients': [], 'totalCarbonFootprint': '0.0'},
    );

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.light 
            ? Colors.white 
            : cardBackgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: lightGrey(context).withOpacity(0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Meal Details',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).brightness == Brightness.light 
                  ? dark(context) 
                  : Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Total Carbon Footprint: ${selectedMealData['totalCarbonFootprint']} kg CO₂',
            style: TextStyle(
              color: active,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          Text('Ingredients:'),
          ...(selectedMealData['ingredients'] as List).map((ingredient) {
            return Padding(
              padding: const EdgeInsets.only(left: 16, top: 8),
              child: Text(
                '${ingredient['name']}: ${ingredient['weight']}g (${ingredient['carbonFootprint']} kg CO₂)',
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
