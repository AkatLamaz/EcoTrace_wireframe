class ScopeData {
  final String category;
  final double amount;

  ScopeData(this.category, this.amount);
}

List<ScopeData> getSampleData() {
  return [
    ScopeData('Scope 1', 298.04),
    ScopeData('Scope 2', 184.46),
    ScopeData('Scope 3', 6.41),
  ];
}
