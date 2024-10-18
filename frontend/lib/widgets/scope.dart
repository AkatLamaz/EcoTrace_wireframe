import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import provider package
import 'package:fl_chart/fl_chart.dart';
import '../data/scope_data.dart';
import '../helpers/responsiveness.dart';
import '../theme_provider.dart'; // Import ThemeProvider
import '../constants/style.dart'; // Import style for colors

class ScopeWidget extends StatelessWidget {
  final List<ScopeData> data;

  const ScopeWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return ResponsiveWidget(
          largeScreen: _buildScopeItems(context, themeProvider, 0.29, 20.0, double.infinity),
          mediumScreen: _buildScopeItems(context, themeProvider, 0.40, 10.0, 1000.0),
          smallScreen: _buildScopeItems(context, themeProvider, 1.0, 10.0, 758.0),
        );
      },
    );
  }

  Widget _buildScopeItems(BuildContext context, ThemeProvider themeProvider, double widthFactor, double spacing, double maxWidth) {
    double screenWidth = MediaQuery.of(context).size.width;
    double adjustedScreenWidth = screenWidth * 0.9;
    double itemWidth = (adjustedScreenWidth * widthFactor).clamp(50.0, maxWidth);

    return Wrap(
      spacing: spacing,
      runSpacing: spacing,
      children: data.map((scopeData) {
        return Container(
          constraints: BoxConstraints(
            minWidth: 300.0,
            maxWidth: maxWidth,
          ),
          width: itemWidth,
          child: _buildScopeItem(context, themeProvider, scopeData),
        );
      }).toList(),
    );
  }

  Widget _buildScopeItem(BuildContext context, ThemeProvider themeProvider, ScopeData scopeData) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 8,
      color: themeProvider.isDarkMode ? dark(context) : light(context), // Adjust card color based on theme
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPieChart(scopeData),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  scopeData.category,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: themeProvider.isDarkMode ? light(context) : dark(context), // Adjust text color based on theme
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${scopeData.amount.toStringAsFixed(2)} ton CO2-eq',
                  style: TextStyle(
                    color: themeProvider.isDarkMode ? light(context) : dark(context), // Adjust text color based on theme
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Icon(Icons.arrow_forward_ios, size: 16, color: themeProvider.isDarkMode ? light(context) : dark(context)), // Adjust icon color based on theme
          ],
        ),
      ),
    );
  }

  Widget _buildPieChart(ScopeData scopeData) {
    return SizedBox(
      width: 50,
      height: 50,
      child: PieChart(
        PieChartData(
          sections: [
            PieChartSectionData(
              value: scopeData.amount,
              color: _getColor(scopeData.category),
              title: '',
              radius: 10,
            ),
            PieChartSectionData(
              value: _getTotalAmount() - scopeData.amount,
              color: Colors.grey[200],
              title: '',
              radius: 10,
            ),
          ],
          sectionsSpace: 0,
          centerSpaceRadius: 20,
        ),
      ),
    );
  }

  double _getTotalAmount() {
    return data.fold(0, (sum, item) => sum + item.amount);
  }

  Color _getColor(String category) {
    switch (category) {
      case 'Scope 1':
        return Colors.green;
      case 'Scope 2':
        return Colors.blue;
      case 'Scope 3':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
}
