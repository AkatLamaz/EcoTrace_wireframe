import 'package:flutter/material.dart';
import '../data/latest_impact_items_data.dart';
import '../helpers/responsiveness.dart'; // Importujemy plik z wartościami

class LatestImpactItems extends StatelessWidget {
  final List<ImpactItem> items;

  const LatestImpactItems({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
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
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Latest impact items',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...items.map((item) => _buildImpactItemRow(item)).toList(),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        'Jun 2021',
                        style: TextStyle(
                          color: Colors.grey[600],
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
  }

  Widget _buildImpactItemRow(ImpactItem item) {
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
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  item.subCategory,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '${item.amount.toStringAsFixed(3)} ton CO2-eq',
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '${item.percentage.toStringAsFixed(1)}% of total',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
