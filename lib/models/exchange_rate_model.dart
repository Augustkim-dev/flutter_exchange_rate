class ExchangeRate {
  final String base;
  final Map<String, double> rates;
  final DateTime? lastUpdated;
  final bool isFromCache;

  ExchangeRate({
    required this.base,
    required this.rates,
    this.lastUpdated,
    this.isFromCache = false,
  });

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
    
    return ExchangeRate(
      base: json['base'] ?? '',
      rates: rates,
      lastUpdated: json['date'] != null ? DateTime.parse(json['date']) : DateTime.now(),
      isFromCache: false,
    );
  }

  // 데이터베이스 저장용 Map 변환
  Map<String, dynamic> toMap() {
    return {
      'base': base,
      'rates': rates,
      'lastUpdated': lastUpdated?.toIso8601String() ?? DateTime.now().toIso8601String(),
      'isFromCache': isFromCache,
    };
  }

  // 데이터베이스에서 불러오기용 팩토리 생성자
  factory ExchangeRate.fromMap(Map<String, dynamic> map) {
    final ratesMap = map['rates'] as Map<String, dynamic>? ?? {};
    final rates = ratesMap.map<String, double>((key, value) {
      if (value is int) {
        return MapEntry(key, value.toDouble());
      } else if (value is double) {
        return MapEntry(key, value);
      } else {
        return MapEntry(key, 0.0);
      }
    });

    return ExchangeRate(
      base: map['base'] ?? '',
      rates: rates,
      lastUpdated: map['lastUpdated'] != null 
          ? DateTime.parse(map['lastUpdated']) 
          : DateTime.now(),
      isFromCache: map['isFromCache'] ?? true,
    );
  }

  // 캐시 데이터에서 생성할 때 사용
  factory ExchangeRate.fromCache({
    required String base,
    required Map<String, dynamic> rates,
    required DateTime lastUpdated,
  }) {
    final convertedRates = rates.map<String, double>((key, value) {
      if (value is int) {
        return MapEntry(key, value.toDouble());
      } else if (value is double) {
        return MapEntry(key, value);
      } else {
        return MapEntry(key, 0.0);
      }
    });

    return ExchangeRate(
      base: base,
      rates: convertedRates,
      lastUpdated: lastUpdated,
      isFromCache: true,
    );
  }

  // 캐시 유효성 검증 (24시간)
  bool isCacheValid() {
    if (lastUpdated == null) return false;
    final now = DateTime.now();
    final difference = now.difference(lastUpdated!);
    return difference.inHours < 24;
  }
}
