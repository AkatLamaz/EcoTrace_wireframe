import 'package:flutter/material.dart';

class ImpactItem {
  final IconData icon;
  final Color color;
  final String category;
  final String subCategory;
  final double amount;
  final double percentage;

  ImpactItem({
    required this.icon,
    required this.color,
    required this.category,
    required this.subCategory,
    required this.amount,
    required this.percentage,
  });
}

List<ImpactItem> getImpactItems() {
  return [
    ImpactItem(
      icon: Icons.flash_on,
      color: Colors.blue,
      category: 'Purchased Energy',
      subCategory: 'Electricity (average mix)',
      amount: 184.463,
      percentage: 37.7,
    ),
    ImpactItem(
      icon: Icons.business,
      color: Colors.green,
      category: 'Company Facilities',
      subCategory: 'Natural Gas',
      amount: 128.268,
      percentage: 26.2,
    ),
    ImpactItem(
      icon: Icons.directions_car,
      color: Colors.green,
      category: 'Company Vehicles',
      subCategory: 'Diesel',
      amount: 108.327,
      percentage: 22.2,
    ),
    ImpactItem(
      icon: Icons.directions_car,
      color: Colors.green,
      category: 'Company Vehicles',
      subCategory: 'Euro 95',
      amount: 42.745,
      percentage: 8.7,
    ),
    ImpactItem(
      icon: Icons.airplanemode_active,
      color: Colors.orange,
      category: 'Employee commuting',
      subCategory: 'Airplane Europe (700-2500 km)',
      amount: 6.116,
      percentage: 1.3,
    ),
  ];
}
