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
            constraints: const BoxConstraints(maxHeight: 600),
      child: const Card(
        margin: EdgeInsets.all(28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(width: 50),
            SizedBox(height: 20),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Dzisiaj zaoszczędziłeś 5 kg śladu węglowego!',
                style:  TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'To o 20% mniej niż średnia światowa.',
                style: TextStyle(fontSize: 16),
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
    ),
        );
      },
    );
  }
}