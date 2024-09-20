import 'package:flutter/material.dart';
import 'package:flutter_web_tutorial2/widgets/year_selector.dart';
import '../../data/scope_data.dart';
import '../../widgets/scope.dart';
import '../../widgets/latest_impact_items.dart'; // Import the new widget
import '../../data/latest_impact_items_data.dart'; // Import the data

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
      //print('Selected year: $selectedYear'); // Debug print
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
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.arrow_right),
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
                    width: double.infinity, // Ograniczenie szerokości
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 8.0,
                      children: months.map((month) {
                        return ChoiceChip(
                          label: Text(month),
                          selected: selectedMonth == month,
                          onSelected: (bool selected) {
                            _selectMonth(month);
                          },
                          selectedColor: Colors.blue,
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
                          child: ScopeWidget(data: getSampleData()),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          child: LatestImpactItems(items: getImpactItems()),
                        ),
                      ],
                    ),
                  )
                  // const SizedBox(height: 20),
                  // // Dodanie widgetu LatestImpactItems
                  // LatestImpactItems(items: getImpactItems()),
                  // const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
