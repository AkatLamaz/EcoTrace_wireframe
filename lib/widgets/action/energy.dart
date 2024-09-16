import 'package:flutter/material.dart';

class EnergyForm extends StatelessWidget {
  final Map<String, dynamic> formData;

  const EnergyForm({super.key, required this.formData});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Wprowadź dane dla energii:'),
        TextFormField(
          decoration: const InputDecoration(labelText: 'Rodzaj energii'),
          onChanged: (value) {
            formData['energy_type'] = value;
          },
        ),
        TextFormField(
          decoration: const InputDecoration(labelText: 'Zużycie (kWh)'),
          keyboardType: TextInputType.number,
          onChanged: (value) {
            formData['consumption'] = double.tryParse(value) ?? 0;
          },
        ),
      ],
    );
  }
}