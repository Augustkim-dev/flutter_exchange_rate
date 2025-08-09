# Flutter 환율 변환 앱 개발 가이드

## 📋 프로젝트 개요
ExchangeRate-API를 활용한 실시간 환율 변환 Flutter 앱 개발

---

## 🚀 Phase 1: Flutter 프로젝트 초기 설정

### 목표
- 개발 환경 구성 및 기본 구조 설정
- 필요한 의존성 패키지 추가
- 보안 설정 및 폴더 구조 구성

### ✅ 체크리스트
- [ ] Flutter 프로젝트 생성
- [ ] pubspec.yaml 의존성 추가
- [ ] .env 파일 생성 및 API 키 설정
- [ ] 기본 폴더 구조 생성

### 📝 구현 단계

#### 1.1 Flutter 프로젝트 생성
```bash
flutter create exchange_rate_app
cd exchange_rate_app
```

#### 1.2 pubspec.yaml 의존성 추가
```yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^1.1.0
  provider: ^6.1.1
  flutter_dotenv: ^5.1.0
  intl: ^0.18.1

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0
```

#### 1.3 .env 파일 생성
프로젝트 루트에 `.env` 파일 생성:
```
EXCHANGE_RATE_API_KEY=your_api_key_here
EXCHANGE_RATE_BASE_URL=https://api.exchangerate-api.com/v4/latest
```

#### 1.4 폴더 구조 생성
```
lib/
├── models/
├── services/
├── screens/
├── widgets/
├── providers/
└── main.dart
```

---

## 🔌 Phase 2: API 서비스 레이어 구현

### 목표
- ExchangeRate-API 연동
- HTTP 클라이언트 및 데이터 모델 구현
- 에러 처리 및 테스트

### ✅ 체크리스트
- [ ] API 서비스 클래스 작성
- [ ] 환율 데이터 모델 클래스 생성
- [ ] HTTP 클라이언트 구현
- [ ] 에러 처리 로직 구현
- [ ] API 호출 테스트

### 📝 구현 단계

#### 2.1 환율 데이터 모델 (lib/models/exchange_rate_model.dart)
```dart
class ExchangeRate {
  final String base;
  final DateTime date;
  final Map<String, double> rates;

  ExchangeRate({
    required this.base,
    required this.date,
    required this.rates,
  });

  factory ExchangeRate.fromJson(Map<String, dynamic> json) {
    return ExchangeRate(
      base: json['base'] ?? '',
      date: DateTime.parse(json['date'] ?? DateTime.now().toIso8601String()),
      rates: Map<String, double>.from(json['rates'] ?? {}),
    );
  }
}
```

#### 2.2 API 서비스 클래스 (lib/services/exchange_rate_service.dart)
```dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/exchange_rate_model.dart';

class ExchangeRateService {
  static const String _baseUrl = 'https://api.exchangerate-api.com/v4/latest';

  Future<ExchangeRate> getExchangeRates(String baseCurrency) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/$baseCurrency'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return ExchangeRate.fromJson(data);
      } else {
        throw Exception('Failed to load exchange rates');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
}
```

---

## 🎯 Phase 3: 상태 관리 및 비즈니스 로직

### 목표
- Provider 패턴으로 상태 관리 설정
- 기준 통화, 입력 금액, 대상 통화 관리
- 환율 계산 로직 구현

### ✅ 체크리스트
- [ ] Provider 설정
- [ ] 기준 통화 상태 관리
- [ ] 입력 금액 상태 관리
- [ ] 대상 통화 리스트 관리
- [ ] 환율 계산 로직 구현

### 📝 구현 단계

#### 3.1 환율 상태 관리 (lib/providers/exchange_rate_provider.dart)
```dart
import 'package:flutter/foundation.dart';
import '../models/exchange_rate_model.dart';
import '../services/exchange_rate_service.dart';

class ExchangeRateProvider with ChangeNotifier {
  final ExchangeRateService _service = ExchangeRateService();
  
  ExchangeRate? _exchangeRate;
  String _baseCurrency = 'USD';
  double _amount = 1.0;
  List<String> _targetCurrencies = ['EUR', 'JPY', 'GBP', 'KRW', 'CNY', 'AUD'];
  
  ExchangeRate? get exchangeRate => _exchangeRate;
  String get baseCurrency => _baseCurrency;
  double get amount => _amount;
  List<String> get targetCurrencies => _targetCurrencies;
  
  bool get isLoading => _exchangeRate == null;
  
  Future<void> fetchExchangeRates() async {
    try {
      _exchangeRate = await _service.getExchangeRates(_baseCurrency);
      notifyListeners();
    } catch (e) {
      print('Error fetching exchange rates: $e');
    }
  }
  
  void setBaseCurrency(String currency) {
    _baseCurrency = currency;
    fetchExchangeRates();
  }
  
  void setAmount(double amount) {
    _amount = amount;
    notifyListeners();
  }
  
  double calculateConversion(String targetCurrency) {
    if (_exchangeRate == null) return 0.0;
    final rate = _exchangeRate!.rates[targetCurrency] ?? 0.0;
    return _amount * rate;
  }
}
```

---

## 🎨 Phase 4: UI 화면 구현

### 목표
- 메인 화면 레이아웃 완성
- 기준 통화 선택, 금액 입력, 결과 표시
- 로딩 인디케이터 및 Material Design 적용

### ✅ 체크리스트
- [ ] 메인 화면 레이아웃 구현
- [ ] 기준 통화 선택 DropdownButton
- [ ] 금액 입력 TextField
- [ ] 환율 결과 ListView 구현
- [ ] 로딩 인디케이터 추가
- [ ] Material Design 적용

### 📝 구현 단계

#### 4.1 메인 화면 (lib/screens/home_screen.dart)
```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/exchange_rate_provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ExchangeRateProvider>().fetchExchangeRates();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('환율 변환기'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Consumer<ExchangeRateProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return Center(child: CircularProgressIndicator());
          }
          
          return Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildCurrencySelector(provider),
                SizedBox(height: 20),
                _buildAmountInput(provider),
                SizedBox(height: 20),
                Expanded(child: _buildResultsList(provider)),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCurrencySelector(ExchangeRateProvider provider) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          children: [
            Text('기준 통화: ', style: TextStyle(fontSize: 16)),
            Expanded(
              child: DropdownButton<String>(
                value: provider.baseCurrency,
                isExpanded: true,
                items: ['USD', 'EUR', 'JPY', 'GBP', 'KRW', 'CNY', 'AUD']
                    .map((currency) => DropdownMenuItem(
                          value: currency,
                          child: Text(currency),
                        ))
                    .toList(),
                onChanged: (value) {
                  if (value != null) provider.setBaseCurrency(value);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAmountInput(ExchangeRateProvider provider) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: TextField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: '금액 입력',
            border: OutlineInputBorder(),
          ),
          onChanged: (value) {
            final amount = double.tryParse(value) ?? 0.0;
            provider.setAmount(amount);
          },
        ),
      ),
    );
  }

  Widget _buildResultsList(ExchangeRateProvider provider) {
    return ListView.builder(
      itemCount: provider.targetCurrencies.length,
      itemBuilder: (context, index) {
        final currency = provider.targetCurrencies[index];
        final convertedAmount = provider.calculateConversion(currency);
        final formatter = NumberFormat.currency(symbol: '');
        
        return Card(
          margin: EdgeInsets.only(bottom: 8.0),
          child: ListTile(
            title: Text(currency),
            subtitle: Text('${provider.baseCurrency} ${formatter.format(provider.amount)}'),
            trailing: Text(
              formatter.format(convertedAmount),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ),
        );
      },
    );
  }
}
```

---

## 🔧 Phase 5: 기능 통합 및 개선

### 목표
- 모든 기능 연결 및 사용성 향상
- 실시간 환율 업데이트 및 계산
- 입력값 검증 및 결과 포맷팅
- 에러 상황 UI 처리

### ✅ 체크리스트
- [ ] 실시간 환율 업데이트 구현
- [ ] 입력값 검증 로직 추가
- [ ] 결과 포맷팅 개선
- [ ] 에러 상황 UI 처리
- [ ] 사용자 피드백 개선

### 📝 구현 단계

#### 5.1 main.dart 업데이트
```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'providers/exchange_rate_provider.dart';
import 'screens/home_screen.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ExchangeRateProvider(),
      child: MaterialApp(
        title: '환율 변환기',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
```

#### 5.2 에러 처리 개선
```dart
// ExchangeRateProvider에 에러 상태 추가
class ExchangeRateProvider with ChangeNotifier {
  String? _error;
  String? get error => _error;
  
  Future<void> fetchExchangeRates() async {
    try {
      _error = null;
      _exchangeRate = await _service.getExchangeRates(_baseCurrency);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }
}
```

---

## 🧪 Phase 6: 테스트 및 최적화

### 목표
- 앱 안정성 확보 및 배포 준비
- 다양한 디바이스에서 테스트
- 네트워크 오류 상황 테스트
- 앱 아이콘 및 스플래시 스크린 설정

### ✅ 체크리스트
- [ ] 다양한 디바이스 해상도 테스트
- [ ] Android/iOS 실제 기기 테스트
- [ ] 네트워크 연결 오류 상황 테스트
- [ ] 앱 아이콘 설정
- [ ] 스플래시 스크린 설정
- [ ] APK/IPA 빌드 테스트

### 📝 구현 단계

#### 6.1 앱 아이콘 설정
```yaml
# pubspec.yaml에 추가
flutter_icons:
  android: "launcher_icon"
  ios: true
  image_path: "assets/icon/icon.png"
```

#### 6.2 스플래시 스크린 설정
```yaml
# pubspec.yaml에 추가
flutter_native_splash:
  color: "#ffffff"
  image: assets/splash.png
  android: true
  ios: true
```

#### 6.3 빌드 명령어
```bash
# Android APK 빌드
flutter build apk --release

# iOS 빌드 (macOS 필요)
flutter build ios --release
```

---

## 📱 최종 앱 기능

### ✅ 완성된 기능
- [x] 실시간 환율 정보 조회
- [x] 7개 주요 통화 지원 (USD, EUR, JPY, GBP, KRW, CNY, AUD)
- [x] 실시간 환율 계산
- [x] 직관적인 UI/UX
- [x] 에러 처리 및 로딩 상태
- [x] 반응형 디자인

### 🎯 사용자 경험
- 깔끔하고 직관적인 인터페이스
- 실시간 환율 업데이트
- 빠른 계산 속도
- 안정적인 에러 처리

---

## 📚 추가 개선 아이디어

### 향후 버전에서 추가할 수 있는 기능
- [ ] 환율 차트 및 그래프
- [ ] 환율 알림 기능
- [ ] 오프라인 모드
- [ ] 다크 모드 지원
- [ ] 더 많은 통화 지원
- [ ] 환율 히스토리 저장

---

## 🔗 유용한 링크

- [Flutter 공식 문서](https://flutter.dev/docs)
- [Provider 패키지](https://pub.dev/packages/provider)
- [HTTP 패키지](https://pub.dev/packages/http)
- [ExchangeRate-API](https://exchangerate-api.com/)

---

**개발 완료 후 각 Phase의 체크박스를 확인하여 진행 상황을 추적하세요!** 