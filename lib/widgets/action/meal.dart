import 'package:flutter/material.dart';

class MealForm extends StatefulWidget {
  final Map<String, dynamic> formData;

  const MealForm({super.key, required this.formData});

  @override
  _MealFormState createState() => _MealFormState();
}

class _MealFormState extends State<MealForm> {
  final List<String> _products = [];
  final TextEditingController _productController = TextEditingController();

  void _addProduct() {
    if (_productController.text.isNotEmpty) {
      setState(() {
        _products.add(_productController.text);
        _productController.clear();
      });
    }
  }

  void _saveMeal() {
    widget.formData['products'] = _products;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Wprowadź dane dla żywienia:'),
        TextFormField(
          decoration: const InputDecoration(labelText: 'Nazwa posiłku'),
          onChanged: (value) {
            widget.formData['meal'] = value;
          },
        ),
        TextFormField(
          decoration: const InputDecoration(labelText: 'Ilość składników'),
          keyboardType: TextInputType.number,
          onChanged: (value) {
            widget.formData['ingredients'] = int.tryParse(value) ?? 0;
          },
        ),
        TextFormField(
          controller: _productController,
          decoration: const InputDecoration(labelText: 'Dodaj produkt'),
        ),
        ElevatedButton(
          onPressed: _addProduct,
          child: const Text('Dodaj produkt'),
        ),
        const SizedBox(height: 10),
        Wrap(
          children: _products.map((product) => Chip(label: Text(product))).toList(),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: _saveMeal,
          child: const Text('Zapisz danie'),
        ),
      ],
    );
  }
}