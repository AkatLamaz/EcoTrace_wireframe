import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_web_tutorial2/constants/style.dart';
import 'package:flutter_web_tutorial2/data/line_chart_data.dart';
import 'custom_card.dart';
import 'package:provider/provider.dart';
import 'package:flutter_web_tutorial2/theme_provider.dart';
import 'dart:math';

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

  List<FlSpot> getFilteredAverageData() {
    if (selectedRange == 3) {
      return data.averageSpots.sublist(0, 4);
    } else if (selectedRange == 6) {
      return data.averageSpots.sublist(0, 7);
    }
    return data.averageSpots;
  }

  double getMaxValue() {
    double maxFromSpots = data.spots.map((spot) => spot.y).reduce(max);
    double maxFromAverage = data.averageSpots.map((spot) => spot.y).reduce(max);
    return max(maxFromSpots, maxFromAverage);
  }

  Map<int, String> generateLeftTitles() {
    double maxValue = getMaxValue();
    int roundedMax = ((maxValue + 99) ~/ 100) * 100;
    int interval = roundedMax ~/ 5;

    Map<int, String> titles = {};
    for (int i = 0; i <= 5; i++) {
      int value = (interval * i);
      if (value >= 1000) {
        titles[value] = '${(value ~/ 1000)}K';
      } else {
        titles[value] = value.toString();
      }
    }
    return titles;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        final leftTitles = generateLeftTitles();
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
                        color: themeProvider.isDarkMode
                            ? lightGrey(context)
                            : dark(context),
                      ),
                    ),
                    Row(
                      children: [
                        _buildRangeButton("3 Miesiące", 3),
                        const SizedBox(width: 10),
                        _buildRangeButton("6 Miesięcy", 6),
                        const SizedBox(width: 10),
                        _buildRangeButton("Rok", 12),
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
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: false,
                        horizontalInterval: getMaxValue() / 5,
                        getDrawingHorizontalLine: (value) {
                          return FlLine(
                            color: themeProvider.isDarkMode 
                                ? Colors.grey.withOpacity(0.2)
                                : Colors.grey.withOpacity(0.1),
                            strokeWidth: 1,
                          );
                        },
                      ),
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
                                          fontSize: 12,
                                          color: themeProvider.isDarkMode
                                              ? Colors.grey[400]
                                              : Colors.grey[600],
                                        ),
                                      ),
                                    )
                                  : const SizedBox();
                            },
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            getTitlesWidget: (double value, TitleMeta meta) {
                              return leftTitles[value.toInt()] != null
                                  ? Text(
                                      leftTitles[value.toInt()].toString(),
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: themeProvider.isDarkMode
                                            ? Colors.grey[400]
                                            : Colors.grey[600],
                                      ),
                                    )
                                  : const SizedBox();
                            },
                            showTitles: true,
                            interval: getMaxValue() / 5,
                            reservedSize: 40,
                          ),
                        ),
                      ),
                      borderData: FlBorderData(show: false),
                      lineBarsData: [
                        LineChartBarData(
                          color: themeProvider.isDarkMode
                              ? Colors.greenAccent
                              : Colors.green,
                          barWidth: 2.5,
                          belowBarData: BarAreaData(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                (themeProvider.isDarkMode
                                    ? Colors.greenAccent
                                    : Colors.green)
                                    .withOpacity(0.3),
                                Colors.transparent
                              ],
                            ),
                            show: true,
                          ),
                          dotData: const FlDotData(show: false),
                          spots: getFilteredData(),
                        ),
                        LineChartBarData(
                          color: themeProvider.isDarkMode
                              ? Colors.redAccent
                              : Colors.red,
                          barWidth: 2.5,
                          belowBarData: BarAreaData(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                (themeProvider.isDarkMode
                                    ? Colors.redAccent
                                    : Colors.red)
                                    .withOpacity(0.3),
                                Colors.transparent
                              ],
                            ),
                            show: true,
                          ),
                          dotData: const FlDotData(show: false),
                          spots: getFilteredAverageData(),
                        ),
                      ],
                      minX: 0,
                      maxX: selectedRange == 12
                          ? 120
                          : (selectedRange == 6 ? 60 : 30),
                      maxY: getMaxValue() * 1.1,
                      minY: 0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildLegendItem("Twoje zużycie", themeProvider.isDarkMode
                          ? Colors.greenAccent
                          : Colors.green),
                      const SizedBox(width: 20),
                      _buildLegendItem("Średnia światowa", themeProvider.isDarkMode
                          ? Colors.redAccent
                          : Colors.red),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildRangeButton(String text, int range) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) => ElevatedButton(
        onPressed: () {
          setState(() {
            selectedRange = range;
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: selectedRange == range
              ? active
              : (themeProvider.isDarkMode ? cardBackgroundColor : Colors.white),
          foregroundColor: selectedRange == range
              ? Colors.white
              : (themeProvider.isDarkMode ? Colors.white : dark(context)),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(
              color: selectedRange == range
                  ? active
                  : (themeProvider.isDarkMode
                      ? Colors.white.withOpacity(0.2)
                      : lightGrey(context)),
            ),
          ),
          elevation: selectedRange == range ? 2 : 0,
        ),
        child: Text(text),
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) => Row(
        children: [
          Container(
            width: 16,
            height: 3,
            color: color,
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: themeProvider.isDarkMode
                  ? lightGrey(context)
                  : dark(context),
            ),
          ),
        ],
      ),
    );
  }
}
