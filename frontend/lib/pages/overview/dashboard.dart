import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import provider package
import 'package:flutter_web_tutorial2/widgets/scope_pie_chart.dart';
import 'package:flutter_web_tutorial2/widgets/year_selector.dart';
import '../../data/scope_data.dart';
import '../../widgets/scope.dart';
import '../../widgets/latest_impact_items.dart'; // Import the new widget
import '../../data/latest_impact_items_data.dart'; // Import the data
import '../../helpers/responsiveness.dart'; // Import the responsiveness helper
import '../../theme_provider.dart'; // Import ThemeProvider
import '../../constants/style.dart'; // Import style for colors

class DashboardWidget extends StatefulWidget {
  const DashboardWidget({super.key});

  @override
  _DashboardWidgetState createState() => _DashboardWidgetState();
}

class _DashboardWidgetState extends State<DashboardWidget> {
  int selectedYear = 2021; // Początkowy wybrany rok
  String selectedMonth = "Jun"; // Początkowy wybrany miesiąc

  final List<int> availableYears = [2020, 2021, 2022, 2023, 2024, 2025, 2026, 2027, 2028,2029,2030,2031,2032,2033,2034,2035,2036,2037,2038,2039,2040];
  final List<String> months = [
    "JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"
  ];

  void _selectYear(int year) {
    setState(() {
      selectedYear = year;
    });
  }

  void _selectMonth(String month) {
    setState(() {
      if (selectedMonth == month) {
        selectedMonth = ""; // Odklikaj miesiąc, jeśli jest już wybrany
      } else {
        selectedMonth = month;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: double.infinity, // Ograniczenie szerokości
            ),
            child: SizedBox(
              width: double.infinity,
              height: 800,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Sekcja z wyborem lat
                      SizedBox(
                        width: double.infinity, // Ograniczenie szerokości
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.arrow_left),
                              color: themeProvider.isDarkMode ? light(context) : dark(context), // Adjust icon color based on theme
                              onPressed: () {
                                setState(() {
                                  if (selectedYear > availableYears.first) {
                                    selectedYear--;
                                  }
                                });
                              },
                            ),
                            TextButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return YearSelector(
                                      selectedYear: selectedYear,
                                      availableYears: availableYears,
                                      onYearSelected: (year) {
                                        _selectYear(year);
                                        Navigator.of(context).pop(); // Ensure dialog is closed after selection
                                      },
                                    );
                                  },
                                );
                              },
                              child: Text(
                                '$selectedYear',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: themeProvider.isDarkMode ? light(context) : dark(context), // Adjust text color based on theme
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.arrow_right),
                              color: themeProvider.isDarkMode ? light(context) : dark(context), // Adjust icon color based on theme
                              onPressed: () {
                                setState(() {
                                  if (selectedYear < availableYears.last) {
                                    selectedYear++;
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Sekcja z wyborem miesięcy
                      SizedBox(
                        width: double.infinity,
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 12.0,
                          runSpacing: 12.0,
                          children: months.map((month) {
                            final isSelected = selectedMonth == month;
                            return SizedBox(
                              height: 36,
                              child: ElevatedButton(
                                onPressed: () => _selectMonth(month),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: isSelected 
                                      ? active 
                                      : themeProvider.isDarkMode
                                          ? cardBackgroundColor
                                          : Colors.white,
                                  foregroundColor: isSelected
                                      ? Colors.white
                                      : themeProvider.isDarkMode
                                          ? Colors.white
                                          : dark(context),
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    side: BorderSide(
                                      color: isSelected
                                          ? Colors.transparent
                                          : themeProvider.isDarkMode
                                              ? Colors.white.withOpacity(0.1)
                                              : lightGrey(context).withOpacity(0.3),
                                      width: 1,
                                    ),
                                  ),
                                  elevation: isSelected ? 2 : 0,
                                  shadowColor: shadowColor(context),
                                ),
                                child: Text(
                                  month,
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,  // Ensures the column takes up minimal space
                          children: [
                            SizedBox(
                              child: ScopeWidget(data: getSampleData(context)),
                            ),
                            const SizedBox(height: 20),
                            LayoutBuilder(
                              builder: (context, constraints) {
                                if (ResponsiveWidget.isSmallScreen(context) || ResponsiveWidget.isCustomScreen(context)) {
                                  return Column(
                                    children: [
                                      const ScopePieChart(),
                                      const SizedBox(height: 20),
                                      LatestImpactItems(items: getImpactItems()),
                                    ],
                                  );
                                } else {
                                  return Row(
                                    children: [
                                      const Flexible(
                                        flex: 2, 
                                        child: ScopePieChart(),
                                      ),
                                      const SizedBox(width: 20), // Odstęp między widgetami
                                      Flexible(
                                        flex: 4, 
                                        child: LatestImpactItems(items: getImpactItems()),
                                      ),
                                    ],
                                  );
                                }
                              },
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
