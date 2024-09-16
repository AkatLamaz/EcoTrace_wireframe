import 'package:flutter/material.dart';
import '../../widgets/action/energy.dart';
import '../../widgets/action/meal.dart';
import '../../widgets/action/transport.dart';

class ActionsPage extends StatefulWidget {
  const ActionsPage({super.key});

  @override
  _ActionPageState createState() => _ActionPageState();
}

class _ActionPageState extends State<ActionsPage> {
  int _selectedAction = -1; // -1 oznacza brak wybranej akcji
  final Map<String, dynamic> _formData = {}; // Dane formularza

  void _resetForm() {
    setState(() {
      _formData.clear();
    });
  }

  void _submitForm() {
    // Tutaj możesz zaimplementować logikę zapisu danych
    print("Formularz zapisany: $_formData");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Akcje'),
      ),
      body: Column(
        children: [
          // Sekcja z przyciskami wyboru akcji
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Adjust layout
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _selectedAction = 0; // Transport
                    _resetForm();
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _selectedAction == 0 ? Theme.of(context).primaryColor : Colors.grey,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Transport',
                  style: TextStyle(
                    fontFamily: 'Inter Tight',
                    color: Colors.white,
                    letterSpacing: 0.0,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _selectedAction = 1; // Żywienie
                    _resetForm();
                    _showFoodSelectionDialog(context); // Show food selection dialog
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _selectedAction == 1 ? Theme.of(context).primaryColor : Colors.grey,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Żywienie',
                  style: TextStyle(
                    fontFamily: 'Inter Tight',
                    color: Colors.white,
                    letterSpacing: 0.0,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _selectedAction = 2; // Energia
                    _resetForm();
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _selectedAction == 2 ? Theme.of(context).primaryColor : Colors.grey,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Energia',
                  style: TextStyle(
                    fontFamily: 'Inter Tight',
                    color: Colors.white,
                    letterSpacing: 0.0,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          
          // Sekcja z formularzem odpowiednim do wybranej akcji
          if (_selectedAction == 0) Expanded(child: TransportForm()),
          if (_selectedAction == 1) Expanded(child: MealForm(formData: _formData)),
          if (_selectedAction == 2) Expanded(child: EnergyForm(formData: _formData)),

          // Sekcja z przyciskami akcji
          if (_selectedAction != -1)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _submitForm(); // Zatwierdzenie formularza
                    },
                    child: const Text('Zatwierdź'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      _resetForm(); // Resetowanie formularza
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: Text('Anuluj'),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  void _showFoodSelectionDialog(BuildContext context) {
    // Placeholder for the food selection dialog
  }
}