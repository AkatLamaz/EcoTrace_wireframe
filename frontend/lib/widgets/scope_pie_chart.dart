import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../constants/style.dart';
import '../data/scope_data.dart';
import '../helpers/responsiveness.dart';

class ScopePieChart extends StatelessWidget {
  const ScopePieChart({super.key});

  @override
  Widget build(BuildContext context) {
    List<PieChartSectionData> sections = getSampleData().map((data) {
      Color color;
      switch (data.category) {
        case 'Scope 1':
          color = Colors.green;
          break;
        case 'Scope 2':
          color = Colors.blue;
          break;
        case 'Scope 3':
          color = Colors.orange;
          break;
        default:
          color = Colors.grey;
      }
      return PieChartSectionData(
        color: color,
        value: data.amount.toDouble(),
        title: '${data.amount} ton',
        radius: 60,
        titleStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: light(context)),
      );
    }).toList();

    return LayoutBuilder(
      builder: (context, constraints) {
        double width = constraints.maxWidth >= customScreenSize ? constraints.maxWidth * 0.6 : constraints.maxWidth;

        return Center(
          child: SizedBox(
            width: width,
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              color: Theme.of(context).cardColor,
              child: Column(
                children: [
                  const Text(
                    'Total impact',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'Jun 2021',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  SizedBox(
                    height: 250,
                    child: PieChart(
                      PieChartData(
                        sections: sections,
                        centerSpaceRadius: 40,
                        sectionsSpace: 2,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Legend
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildLegendItem(Colors.green, 'Scope 1'),
                      _buildLegendItem(Colors.blue, 'Scope 2'),
                      _buildLegendItem(Colors.orange, 'Scope 3'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        const SizedBox(width: 5),
        Text(label),
        const SizedBox(width: 15),
      ],
    );
  }
}
