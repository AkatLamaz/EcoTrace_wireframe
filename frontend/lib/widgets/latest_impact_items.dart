import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import provider package
import '../data/latest_impact_items_data.dart';
import '../helpers/responsiveness.dart';
import '../theme_provider.dart'; // Import ThemeProvider
import '../constants/style.dart'; // Import style for colors

class LatestImpactItems extends StatelessWidget {
  final List<ImpactItem> items;

  const LatestImpactItems({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return LayoutBuilder(
          builder: (context, constraints) {
            double width = constraints.maxWidth >= customScreenSize ? constraints.maxWidth * 1 : constraints.maxWidth;

            return Center(
              child: SizedBox(
                width: width,
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  color: themeProvider.isDarkMode ? dark(context) : light(context), // Adjust card color based on theme
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Latest impact items',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: themeProvider.isDarkMode ? light(context) : dark(context), // Adjust text color based on theme
                          ),
                        ),
                        const SizedBox(height: 8),
                        ...items.map((item) => _buildImpactItemRow(context, themeProvider, item)).toList(),
                        const SizedBox(height: 8),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            'Jun 2021',
                            style: TextStyle(
                              color: themeProvider.isDarkMode ? lightGrey(context) : Colors.grey[600], // Adjust text color based on theme
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildImpactItemRow(BuildContext context, ThemeProvider themeProvider, ImpactItem item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(item.icon, color: item.color),
          const SizedBox(width: 8, height: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.category,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: themeProvider.isDarkMode ? light(context) : dark(context), // Adjust text color based on theme
                  ),
                ),
                Text(
                  item.subCategory,
                  style: TextStyle(
                    color: themeProvider.isDarkMode ? lightGrey(context) : Colors.grey[600], // Adjust text color based on theme
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '${item.amount.toStringAsFixed(3)} ton CO2-eq',
            style: TextStyle(
              fontSize: 14,
              color: themeProvider.isDarkMode ? light(context) : dark(context), // Adjust text color based on theme
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '${item.percentage.toStringAsFixed(1)}% of total',
            style: TextStyle(
              color: themeProvider.isDarkMode ? lightGrey(context) : Colors.grey[600], // Adjust text color based on theme
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
