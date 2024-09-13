import 'package:flutter/material.dart';
import 'package:flutter_web_tutorial2/widgets/line_chart_card.dart';
import 'package:flutter_web_tutorial2/data/line_chart_data.dart';

class EmissionsPage extends StatelessWidget {
  const EmissionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final LineData lineData = LineData();

    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 600, maxWidth: 650),
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
    );
  }
}