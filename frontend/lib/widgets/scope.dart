import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../data/scope_data.dart';
import '../helpers/responsiveness.dart';

class ScopeWidget extends StatelessWidget {
  final List<ScopeData> data;

  const ScopeWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      largeScreen: _buildScopeItems(context, 0.29, 20.0, double.infinity),
      mediumScreen: _buildScopeItems(context, 0.40, 10.0, 1000.0),
      smallScreen: _buildScopeItems(context, 1.0, 10.0, 758.0),
    );
  }

  Widget _buildScopeItems(BuildContext context, double widthFactor, double spacing, double maxWidth) {
    double screenWidth = MediaQuery.of(context).size.width;
    double adjustedScreenWidth = screenWidth * 0.9;
    double itemWidth = (adjustedScreenWidth * widthFactor).clamp(50.0, maxWidth);

    return Wrap(
      spacing: spacing, // Odstęp między widgetami
      runSpacing: spacing, // Odstęp między wierszami
      children: data.map((scopeData) {
        return Container(
          constraints: BoxConstraints(
            minWidth: 300.0,
            maxWidth: maxWidth,
          ),
          width: itemWidth,
          child: _buildScopeItem(scopeData),
        );
      }).toList(),
    );
  }

Widget _buildScopeItem(ScopeData scopeData) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    elevation: 4,
    child: Container(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start, // Ustawia Scope1 lekko wyżej
        children: [
          // Wykres po lewej stronie
          _buildPieChart(scopeData),
          const SizedBox(width: 16), // Odstęp między wykresem a tekstem
          // Kolumna z tekstem po prawej stronie
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Scope1 lekko wyżej
              Text(
                scopeData.category,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              // CO2
              Text(
                '${scopeData.amount.toStringAsFixed(2)} ton CO2-eq',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
            ],
          ),
          // Spacer, aby strzałka była bardziej wysunięta na prawo
          const Spacer(),
          // Strzałka po prawej
          Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[600]),
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
