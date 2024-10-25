import 'package:flutter/material.dart';
import 'package:flutter_web_tutorial2/widgets/line_chart_card.dart';
import 'package:flutter_web_tutorial2/theme_provider.dart';
import 'package:flutter_web_tutorial2/constants/style.dart';
import 'package:provider/provider.dart';

class EmissionsPage extends StatelessWidget {
  const EmissionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Emissions'),
            backgroundColor: themeProvider.isDarkMode ? dark(context) : light(context),
            iconTheme: IconThemeData(
              color: themeProvider.isDarkMode ? light(context) : dark(context), // Change arrow color based on theme
            ),
            titleTextStyle: TextStyle(
              color: themeProvider.isDarkMode ? light(context) : dark(context), // Change title text color based on theme
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          body: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 700),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              margin: const EdgeInsets.all(28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.eco, color: Colors.green, size: 30),
                        ),
                        const SizedBox(width: 16),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Dzisiaj zaoszczędziłeś X śladu węglowego!',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'To o 20% mniej niż średnia światowa.',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Twój ślad węglowy w czasie',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Wykres pokazuje miesięczne zużycie CO₂',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 20),
                        SizedBox(
                          height: 400,
                          child: LineChartCard(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
