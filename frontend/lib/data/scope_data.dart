import 'package:flutter/material.dart';
import '../constants/style.dart';
import '../widgets/side_menu.dart';

class ScopeData {
  final String category;
  final double amount;
  final Color color;

  ScopeData(this.category, this.amount, this.color);
}

List<ScopeData> getSampleData(BuildContext context) {
  return [
    ScopeData('Scope 1', 298.04, scopeColor(context)),
    ScopeData('Scope 2', 184.46, scopeColor(context)),
    ScopeData('Scope 3', 60.41, scopeColor(context)),
  ];
}
