import 'package:flutter/material.dart';
import 'package:flutter_web_tutorial2/widgets/line_chart_card.dart';

class EmissionsPage extends StatelessWidget {
  const EmissionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 600, maxWidth: 650),
      child: const Card(
        margin: EdgeInsets.all(28),
        child: Column(
          children: [
            SizedBox(width: 50),
            SizedBox(height: 20),
            SizedBox(
              height: 400, // Określenie wymiarów
              child: LineChartCard(),
            ),
            // const SizedBox(
            //   width: 200,
            //   height: 200, // Określenie wymiarów
            //   child: EmissionsOverTimeChart(),
            // ),
          ],
        ),
      ),
    );
  }
}