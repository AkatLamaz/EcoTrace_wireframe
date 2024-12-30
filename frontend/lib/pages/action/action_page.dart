import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/action/energy.dart';
import '../../widgets/action/meal.dart';
import '../../widgets/action/transport.dart';
import '../../widgets/action/fashion.dart';
import '../../widgets/action/purchase.dart';
import '../../widgets/action/streaming.dart';
//import '../../helpers/responsiveness.dart';
import '../../constants/style.dart';
import '../../theme_provider.dart';

class ActionsPage extends StatefulWidget {
  const ActionsPage({super.key});

  @override
  _ActionPageState createState() => _ActionPageState();
}

class _ActionPageState extends State<ActionsPage> {
  int _selectedAction = -1;
  final Map<String, dynamic> _formData = {};
  final _cache = <String, dynamic>{};

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
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Action'),
            backgroundColor: themeProvider.isDarkMode ? dark(context) : light(context),
            iconTheme: IconThemeData(
              color: themeProvider.isDarkMode ? light(context) : dark(context),
            ),
            titleTextStyle: TextStyle(
              color: themeProvider.isDarkMode ? light(context) : dark(context),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          body: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth >= 1200) {
                return _buildLargeScreen(context, themeProvider);
              } else if (constraints.maxWidth >= 800) {
                return _buildMediumScreen(context, themeProvider);
              } else {
                return _buildSmallScreen(context, themeProvider);
              }
            },
          ),
        );
      },
    );
  }

  Widget _buildLargeScreen(BuildContext context, ThemeProvider themeProvider) {
    return Column(
      children: [
        const SizedBox(height: 20),
        _buildButtonGrid(context, themeProvider, crossAxisCount: 6),
        const SizedBox(height: 20),
        _buildFormSection(themeProvider),
        _buildActionButtons(themeProvider),
      ],
    );
  }

  Widget _buildMediumScreen(BuildContext context, ThemeProvider themeProvider) {
    return Column(
      children: [
        const SizedBox(height: 20),
        _buildButtonGrid(context, themeProvider, crossAxisCount: 3),
        const SizedBox(height: 20),
        _buildFormSection(themeProvider),
        _buildActionButtons(themeProvider),
      ],
    );
  }

  Widget _buildSmallScreen(BuildContext context, ThemeProvider themeProvider) {
    return Column(
      children: [
        const SizedBox(height: 20),
        _buildButtonGrid(context, themeProvider, crossAxisCount: 2),
        const SizedBox(height: 20),
        _buildFormSection(themeProvider),
        _buildActionButtons(themeProvider),
      ],
    );
  }

  Widget _buildButtonGrid(BuildContext context, ThemeProvider themeProvider, {required int crossAxisCount}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GridView.builder(
        itemCount: _buildButtons(context, themeProvider).length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 6.5,
        ),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return _buildButtons(context, themeProvider)[index];
        },
      ),
    );
  }

  List<Widget> _buildButtons(BuildContext context, ThemeProvider themeProvider) {
    return [
      _buildButton(context, themeProvider, 'Transport', 0),
      _buildButton(context, themeProvider, 'Meal', 1),
      _buildButton(context, themeProvider, 'Energy', 2),
      _buildButton(context, themeProvider, 'Fashion', 3),
      _buildButton(context, themeProvider, 'Purchase', 4),
      _buildButton(context, themeProvider, 'Streaming', 5),
    ];
  }

  Widget _buildButton(BuildContext context, ThemeProvider themeProvider, String text, int actionIndex) {
    return SizedBox(
      width: 100,
      height: 20,
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            _selectedAction = actionIndex;
            _resetForm();
            if (actionIndex == 1) _showFoodSelectionDialog(context);
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: _selectedAction == actionIndex
              ? Theme.of(context).primaryColor
              : themeProvider.isDarkMode ? dark(context) : light(context), // Adjust button color based on theme
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontFamily: 'Inter Tight',
            color: themeProvider.isDarkMode ? light(context) : dark(context), // Adjust text color based on theme
            letterSpacing: 0.0,
          ),
        ),
      ),
    );
  }

  Widget _buildFormSection(ThemeProvider themeProvider) {
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

  Widget _buildActionButtons(ThemeProvider themeProvider) {
    return _selectedAction != -1
        ? Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: active,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                    ),
                    child: const Text(
                      'Zatwierdź',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _resetForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      foregroundColor: Theme.of(context).brightness == Brightness.light
                          ? dark(context)
                          : Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(
                          color: Theme.of(context).brightness == Brightness.light
                              ? lightGrey(context)
                              : Colors.white.withOpacity(0.2),
                        ),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Anuluj',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
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
