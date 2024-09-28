import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_web_tutorial2/constants/style.dart';
import 'package:flutter_web_tutorial2/data/line_chart_data.dart';
import 'custom_card.dart';

class LineChartCard extends StatefulWidget {
  const LineChartCard({super.key});

  @override
  _LineChartCardState createState() => _LineChartCardState();
}

class _LineChartCardState extends State<LineChartCard> {
  final data = LineData();
  int selectedRange = 12; // Domyślnie zakres na 12 miesięcy (cały rok)

  // Funkcja zwracająca odpowiedni zakres danych w zależności od wyboru
  List<FlSpot> getFilteredData() {
    if (selectedRange == 3) {
      return data.spots.sublist(0, 13); // Pierwsze 3 miesiące (dane z 12 FlSpot)
    } else if (selectedRange == 6) {
      return data.spots.sublist(0, 25); // Pierwsze 6 miesięcy (dane z 24 FlSpot)
    }
    return data.spots; // Domyślnie zwracamy cały rok
  }

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 600),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Dodanie przycisków do wyboru zakresu
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "CO2",
                  style: TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w500, color: light),
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedRange = 3; // Zakres na 3 miesiące
                        });
                      },
                      child: const Text("3 Miesiące"),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedRange = 6; // Zakres na 6 miesięcy
                        });
                      },
                      child: const Text("6 Miesięcy"),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedRange = 12; // Zakres na 12 miesięcy
                        });
                      },
                      child: const Text("Rok"),
                    ),
                  ],
                ),
              ],
            ),
            //const SizedBox(height: 20),

            Expanded(
              child: LineChart(
                LineChartData(
                  lineTouchData: const LineTouchData(
                    handleBuiltInTouches: true,
                  ),
                  gridData: const FlGridData(show: false),
                  titlesData: FlTitlesData(
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          return data.bottomTitle[value.toInt()] != null
                              ? SideTitleWidget(
                                  axisSide: meta.axisSide,
                                  child: Text(
                                    data.bottomTitle[value.toInt()].toString(),
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.grey[400]),
                                  ),
                                )
                              : const SizedBox();
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        getTitlesWidget: (double value, TitleMeta meta) {
                          return data.leftTitle[value.toInt()] != null
                              ? Text(data.leftTitle[value.toInt()].toString(),
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey[400]))
                              : const SizedBox();
                        },
                        showTitles: true,
                        interval: 1,
                        reservedSize: 40,
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      color: selectionColor,
                      barWidth: 2.5,
                      belowBarData: BarAreaData(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            selectionColor.withOpacity(0.5),
                            Colors.transparent
                          ],
                        ),
                        show: true,
                      ),
                      dotData: const FlDotData(show: false),
                      spots: getFilteredData(),
                    )
                  ],
                  minX: 0,
                  maxX: selectedRange == 12
                      ? 120
                      : (selectedRange == 6 ? 60 : 30), // Ustawienie osi X
                  maxY: 105,
                  minY: -5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
