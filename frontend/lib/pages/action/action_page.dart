import 'package:flutter/material.dart';
import '../../widgets/action/energy.dart';
import '../../widgets/action/meal.dart';
import '../../widgets/action/transport.dart';
import '../../widgets/action/fashion.dart';
import '../../widgets/action/purchase.dart';
import '../../widgets/action/streaming.dart';
import '../../helpers/responsiveness.dart';
import '../../constants/style.dart';

class ActionsPage extends StatefulWidget {
  const ActionsPage({super.key});

  @override
  _ActionPageState createState() => _ActionPageState();
}

class _ActionPageState extends State<ActionsPage> {
  int _selectedAction = -1;
  final Map<String, dynamic> _formData = {};

  void _resetForm() {
    setState(() {
      _formData.clear();
    });
  }

  void _submitForm() {
    print("Formularz zapisany: $_formData");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Actions'),
      ),
      body: ResponsiveWidget(
        largeScreen: _buildLargeScreen(context),
        mediumScreen: _buildMediumScreen(context),
        smallScreen: _buildSmallScreen(context),
      ),
    );
  }

  Widget _buildLargeScreen(BuildContext context) {
    return Column(
      children: [
        _buildButtonGrid(context, crossAxisCount: 6), // 6 przycisków w rzędzie
        const SizedBox(height: 20),
        _buildFormSection(),
        _buildActionButtons(),
      ],
    );
  }

  Widget _buildMediumScreen(BuildContext context) {
    return Column(
      children: [
        _buildButtonGrid(context, crossAxisCount: 3), // 3 przyciski w rzędzie
        const SizedBox(height: 20),
        _buildFormSection(),
        _buildActionButtons(),
      ],
    );
  }

  Widget _buildSmallScreen(BuildContext context) {
    return Column(
      children: [
        _buildButtonGrid(context, crossAxisCount: 2), // 2 przyciski w rzędzie
        const SizedBox(height: 20),
        _buildFormSection(),
        _buildActionButtons(),
      ],
    );
  }

  Widget _buildButtonGrid(BuildContext context, {required int crossAxisCount}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GridView.builder(
        itemCount: _buildButtons(context).length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount, // Ilość przycisków w rzędzie
          crossAxisSpacing: 10, // Odstępy poziome
          mainAxisSpacing: 10, // Odstępy pionowe
          childAspectRatio: 6.5, // Stosunek szerokości do wysokości, aby kontrolować proporcje
        ),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return _buildButtons(context)[index];
        },
      ),
    );
  }

  List<Widget> _buildButtons(BuildContext context) {
    return [
      _buildButton(context, 'Transport', 0),
      _buildButton(context, 'Meal', 1),
      _buildButton(context, 'Energy', 2),
      _buildButton(context, 'Fashion', 3),
      _buildButton(context, 'Purchase', 4),
      _buildButton(context, 'Streaming', 5),
    ];
  }

  Widget _buildButton(BuildContext context, String text, int actionIndex) {
    return SizedBox(
      width: 100,  // Stała szerokość
      height: 20,  // **Stała wysokość**
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            _selectedAction = actionIndex;
            _resetForm();
            if (actionIndex == 1) _showFoodSelectionDialog(context);
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: _selectedAction == actionIndex ? Theme.of(context).primaryColor : light(context),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontFamily: 'Inter Tight',
            color: light(context),
            letterSpacing: 0.0,
          ),
        ),
      ),
    );
  }

  Widget _buildFormSection() {
    return Expanded(
      child: _selectedAction == 0
          ? TransportForm()
          : _selectedAction == 1
              ? MealForm(formData: _formData)
              : _selectedAction == 2
                  ? EnergyForm(formData: _formData)
                  : _selectedAction == 3
                      ? FashionForm(formData: _formData)
                      : _selectedAction == 4
                          ? PurchaseForm(formData: _formData)
                          : _selectedAction == 5
                              ? StreamingForm(formData: _formData)
                              : Container(),
    );
  }

  Widget _buildActionButtons() {
    return _selectedAction != -1
        ? Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text('Zatwierdź'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _resetForm,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text('Anuluj'),
                ),
              ],
            ),
          )
        : Container();
  }

  void _showFoodSelectionDialog(BuildContext context) {
    // Placeholder for the food selection dialog
  }
}
