class ExchangeRate {
  final String base;
  final Map<String, double> rates;

  ExchangeRate({required this.base, required this.rates});

  factory ExchangeRate.fromJson(Map<String, dynamic> json) {
    final ratesMap = json['rates'] as Map<String, dynamic>? ?? {};
    final rates = ratesMap.map<String, double>((key, value) {
      // int나 double 모두 처리
      if (value is int) {
        return MapEntry(key, value.toDouble());
      } else if (value is double) {
        return MapEntry(key, value);
      } else {
        return MapEntry(key, 0.0);
      }
    });
    
    return ExchangeRate(base: json['base'] ?? '', rates: rates);
  }
}
