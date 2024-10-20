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
  int selectedRange = 12;

  List<FlSpot> getFilteredData() {
    if (selectedRange == 3) {
      return data.spots.sublist(0, 13);
    } else if (selectedRange == 6) {
      return data.spots.sublist(0, 25);
    }
    return data.spots;
  }

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 600),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "CO2",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedRange = 3;
                        });
                      },
                      child: const Text("3 Miesiące"),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedRange = 6;
                        });
                      },
                      child: const Text("6 Miesięcy"),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedRange = 12;
                        });
                      },
                      child: const Text("Rok"),
                    ),
                  ],
                ),
              ],
            ),
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
                      : (selectedRange == 6 ? 60 : 30),
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
