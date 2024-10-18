import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import provider package
import '../constants/style.dart';
import '../theme_provider.dart'; // Import ThemeProvider

class YearSelector extends StatelessWidget {
  final int selectedYear;
  final List<int> availableYears;
  final ValueChanged<int> onYearSelected;

  const YearSelector({
    super.key,
    required this.selectedYear,
    required this.availableYears,
    required this.onYearSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return AlertDialog(
          backgroundColor: themeProvider.isDarkMode
              ? dark(context) // Use dark color for dark mode
              : light(context), // Use light color for light mode
          elevation: 8,
          title: const Text('Select Year'),
          content: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 450,
            ),
            child: SizedBox(
              width: double.maxFinite,
              child: GridView.builder(
                shrinkWrap: true,
                itemCount: availableYears.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // 3 elementy w wierszu
                  crossAxisSpacing: 10.0, // Odstępy między elementami w wierszu
                  mainAxisSpacing: 10.0, // Odstępy między wierszami
                ),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      onYearSelected(availableYears[index]);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: selectedYear == availableYears[index]
                            ? Theme.of(context).primaryColor
                            : themeProvider.isDarkMode
                                ? dark(context)
                                : light(context),
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: [
                          BoxShadow(
                            color: shadowColor(context), // Use shadowColor from style.dart
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        '${availableYears[index]}',
                        style: TextStyle(
                          color: selectedYear == availableYears[index]
                              ? light(context) // Use light color for selected text
                              : Theme.of(context).textTheme.bodyLarge?.color, // Default text color
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                foregroundColor: themeProvider.isDarkMode
                    ? light(context)
                    : dark(context),
              ),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
