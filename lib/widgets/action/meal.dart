import 'package:flutter/material.dart';

class MealForm extends StatelessWidget {
  final Map<String, dynamic> formData;

  const MealForm({super.key, required this.formData});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Wprowadź dane dla żywienia:'),
        TextFormField(
          decoration: const InputDecoration(labelText: 'Nazwa posiłku'),
          onChanged: (value) {
            formData['meal'] = value;
          },
        ),
        TextFormField(
          decoration: const InputDecoration(labelText: 'Ilość składników'),
          keyboardType: TextInputType.number,
          onChanged: (value) {
            formData['ingredients'] = int.tryParse(value) ?? 0;
          },
        ),
      ],
    );
  }
}