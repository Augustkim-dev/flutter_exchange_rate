# Flutter 환율계산기 다국어 지원 구현 가이드

## 개요
Flutter 환율계산기 앱에 다국어 지원(i18n)을 구현하여 한국어, 영어를 포함한 여러 언어를 지원하도록 업데이트합니다.

## 주요 기능
1. **앱 이름 현지화**: 한국어 "환율계산기", 영어 "Exchange Rate Calculator"
2. **자동 언어 선택**: 온보딩 시 지역 설정에 따라 언어 자동 선택
3. **수동 언어 변경**: 온보딩 및 설정 화면에서 언어 변경 가능
4. **완전한 UI 번역**: 모든 UI 텍스트 다국어 지원

## Phase 1: 프로젝트 설정 및 패키지 추가

### 1.1 필요 패키지 추가 
```yaml
dependencies:
  flutter_localizations:
    sdk: flutter
  intl: ^0.19.0  # 이미 설치됨
  shared_preferences: ^2.2.2  # 이미 설치됨
```

### 1.2 pubspec.yaml에 지원 언어 설정
```yaml
flutter:
  generate: true  # l10n 자동 생성 활성화
```

### 1.3 l10n.yaml 파일 생성
프로젝트 루트에 l10n.yaml 파일 생성:
```yaml
arb-dir: lib/l10n
template-arb-file: app_en.arb
output-localization-file: app_localizations.dart
output-class: AppLocalizations
synthetic-package: false
use-deferred-loading: false
```

## Phase 2: 언어 리소스 파일 구조 생성

### 2.1 디렉토리 구조
```
lib/
  l10n/
    app_en.arb        # 영어 번역
    app_ko.arb        # 한국어 번역
    app_ja.arb        # 일본어 번역 (선택)
    app_zh.arb        # 중국어 번역 (선택)
```

### 2.2 ARB 파일 내용 예시

#### app_en.arb
```json
{
  "@@locale": "en",
  "appTitle": "Exchange Rate Calculator",
  "@appTitle": {
    "description": "The title of the application"
  },
  "settings": "Settings",
  "language": "Language",
  "darkMode": "Dark Mode",
  "refreshRates": "Refresh Exchange Rates",
  "lastUpdated": "Last updated: {time}",
  "@lastUpdated": {
    "placeholders": {
      "time": {
        "type": "String"
      }
    }
  },
  "selectCurrency": "Select Currency",
  "favorites": "Favorites",
  "aboutApp": "About",
  "feedback": "Feedback",
  "offlineMode": "Offline Mode - Using cached data",
  "inputAmount": "Enter amount for {currency}",
  "@inputAmount": {
    "placeholders": {
      "currency": {
        "type": "String"
      }
    }
  },
  "noInternetConnection": "No internet connection",
  "cacheDataDeleted": "Cache data deleted",
  "confirmDeleteCache": "Delete all cached exchange rate data?",
  "cancel": "Cancel",
  "delete": "Delete",
  "retry": "Retry",
  "error": "Error",
  "loading": "Loading...",
  "welcome": "Welcome",
  "getStarted": "Get Started",
  "selectHomeCurrency": "Select Your Home Currency",
  "selectDefaultCurrencies": "Select Default Currencies",
  "continueButton": "Continue",
  "skip": "Skip",
  "next": "Next",
  "justNow": "Just now",
  "minutesAgo": "{count} minutes ago",
  "@minutesAgo": {
    "placeholders": {
      "count": {
        "type": "int"
      }
    }
  },
  "hoursAgo": "{count} hours ago",
  "@hoursAgo": {
    "placeholders": {
      "count": {
        "type": "int"
      }
    }
  },
  "realtimeExchangeRate": "Real-time Exchange Rates",
  "developerInfo": "Developer Info",
  "sendFeedback": "Send Feedback",
  "manageAppSettings": "Manage app settings",
  "changeLanguage": "Change language",
  "darkModeEnabled": "Dark mode enabled",
  "lightModeEnabled": "Light mode enabled",
  "notifications": "Notifications",
  "receiveRateAlerts": "Receive exchange rate alerts",
  "autoRefresh": "Auto Refresh",
  "updateEvery5Minutes": "Update rates every 5 minutes",
  "favoriteCurrencies": "Favorite Currencies",
  "currentFavorites": "Currently {count} currencies saved",
  "@currentFavorites": {
    "placeholders": {
      "count": {
        "type": "int"
      }
    }
  },
  "usingCachedData": "Using Cached Data",
  "refresh": "Refresh",
  "ratesUpdated": "Exchange rates updated",
  "updateFailed": "Update failed",
  "version": "Version"
}
```

#### app_ko.arb
```json
{
  "@@locale": "ko",
  "appTitle": "환율계산기",
  "settings": "설정",
  "language": "언어",
  "darkMode": "다크모드",
  "refreshRates": "환율 데이터 새로고침",
  "lastUpdated": "마지막 업데이트: {time}",
  "selectCurrency": "통화 선택",
  "favorites": "즐겨찾기",
  "aboutApp": "개발자 정보",
  "feedback": "의견보내기",
  "offlineMode": "오프라인 모드 - 저장된 데이터 사용 중",
  "inputAmount": "{currency} 금액 입력",
  "noInternetConnection": "인터넷 연결을 확인해주세요",
  "cacheDataDeleted": "캐시가 삭제되었습니다",
  "confirmDeleteCache": "저장된 모든 환율 데이터를 삭제하시겠습니까?",
  "cancel": "취소",
  "delete": "삭제",
  "retry": "재시도",
  "error": "오류",
  "loading": "로딩 중...",
  "welcome": "환영합니다",
  "getStarted": "시작하기",
  "selectHomeCurrency": "홈 통화를 선택하세요",
  "selectDefaultCurrencies": "기본 통화를 선택하세요",
  "continueButton": "계속",
  "skip": "건너뛰기",
  "next": "다음",
  "justNow": "방금 전",
  "minutesAgo": "{count}분 전",
  "hoursAgo": "{count}시간 전",
  "realtimeExchangeRate": "실시간 환율 정보",
  "developerInfo": "개발자 정보",
  "sendFeedback": "의견보내기",
  "manageAppSettings": "앱 설정을 관리합니다",
  "changeLanguage": "언어를 변경합니다",
  "darkModeEnabled": "다크모드가 활성화되었습니다",
  "lightModeEnabled": "라이트모드가 활성화되었습니다",
  "notifications": "알림 설정",
  "receiveRateAlerts": "환율 변동 알림을 받습니다",
  "autoRefresh": "자동 새로고침",
  "updateEvery5Minutes": "5분마다 환율을 자동으로 업데이트합니다",
  "favoriteCurrencies": "즐겨찾기 통화",
  "currentFavorites": "현재 {count}개 통화가 즐겨찾기에 저장되어 있습니다",
  "usingCachedData": "캐시 데이터 사용 중",
  "refresh": "새로고침",
  "ratesUpdated": "환율 데이터가 업데이트되었습니다",
  "updateFailed": "업데이트 실패",
  "version": "버전"
}
```

## Phase 3: LocalizationProvider 구현

### 3.1 LocalizationProvider 클래스 생성
```dart
// lib/providers/localization_provider.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalizationProvider extends ChangeNotifier {
  static const String _localeKey = 'selected_locale';
  
  Locale _currentLocale = const Locale('ko'); // 기본값 한국어
  
  Locale get currentLocale => _currentLocale;
  
  // 지원 언어 목록
  static const List<Locale> supportedLocales = [
    Locale('ko'), // 한국어
    Locale('en'), // 영어
    Locale('ja'), // 일본어
    Locale('zh'), // 중국어
  ];
  
  LocalizationProvider() {
    _loadSavedLocale();
  }
  
  Future<void> _loadSavedLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final localeCode = prefs.getString(_localeKey);
    if (localeCode != null) {
      _currentLocale = Locale(localeCode);
      notifyListeners();
    }
  }
  
  Future<void> setLocale(Locale locale) async {
    if (!supportedLocales.contains(locale)) return;
    
    _currentLocale = locale;
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_localeKey, locale.languageCode);
    
    notifyListeners();
  }
  
  // 통화 코드로부터 언어 자동 감지
  void detectLanguageFromCurrency(String currencyCode) {
    switch (currencyCode) {
      case 'KRW':
        setLocale(const Locale('ko'));
        break;
      case 'USD':
      case 'GBP':
      case 'AUD':
      case 'CAD':
        setLocale(const Locale('en'));
        break;
      case 'JPY':
        setLocale(const Locale('ja'));
        break;
      case 'CNY':
        setLocale(const Locale('zh'));
        break;
      default:
        // 기본값 유지
        break;
    }
  }
  
  String getLanguageName(Locale locale) {
    switch (locale.languageCode) {
      case 'ko':
        return '한국어';
      case 'en':
        return 'English';
      case 'ja':
        return '日本語';
      case 'zh':
        return '中文';
      default:
        return locale.languageCode;
    }
  }
}
```

## Phase 4: 온보딩 화면 언어 자동 선택 구현

### 4.1 OnboardingScreen 수정
```dart
// lib/screens/onboarding_screen.dart 수정사항
// 홈 통화 선택 시 언어 자동 감지 추가

onCurrencySelected: (currency) {
  // 기존 코드
  onboardingProvider.setHomeCurrency(currency);
  
  // 언어 자동 감지 추가
  final localizationProvider = context.read<LocalizationProvider>();
  localizationProvider.detectLanguageFromCurrency(currency);
  
  // 언어 선택 다이얼로그 표시 (선택적)
  _showLanguageConfirmDialog(context);
}

// 언어 확인 다이얼로그
Future<void> _showLanguageConfirmDialog(BuildContext context) async {
  final l10n = AppLocalizations.of(context)!;
  final localizationProvider = context.read<LocalizationProvider>();
  
  await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(l10n.language),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('선택된 언어: ${localizationProvider.getLanguageName(localizationProvider.currentLocale)}'),
          SizedBox(height: 16),
          Text('다른 언어로 변경하시겠습니까?'),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.continueButton),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            _showLanguageSelectionDialog(context);
          },
          child: Text(l10n.changeLanguage),
        ),
      ],
    ),
  );
}
```

## Phase 5: 설정 화면 언어 변경 기능

### 5.1 LanguageScreen 업데이트
```dart
// lib/screens/language_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/localization_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LanguageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final localizationProvider = context.watch<LocalizationProvider>();
    
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.language),
      ),
      body: ListView.builder(
        itemCount: LocalizationProvider.supportedLocales.length,
        itemBuilder: (context, index) {
          final locale = LocalizationProvider.supportedLocales[index];
          final isSelected = localizationProvider.currentLocale == locale;
          
          return ListTile(
            leading: _getLanguageFlag(locale.languageCode),
            title: Text(localizationProvider.getLanguageName(locale)),
            trailing: isSelected ? Icon(Icons.check, color: Theme.of(context).colorScheme.primary) : null,
            selected: isSelected,
            onTap: () {
              localizationProvider.setLocale(locale);
              Navigator.pop(context);
            },
          );
        },
      ),
    );
  }
  
  Widget _getLanguageFlag(String languageCode) {
    String countryCode;
    switch (languageCode) {
      case 'ko':
        countryCode = 'KR';
        break;
      case 'en':
        countryCode = 'US';
        break;
      case 'ja':
        countryCode = 'JP';
        break;
      case 'zh':
        countryCode = 'CN';
        break;
      default:
        countryCode = 'US';
    }
    
    return CountryFlag.fromCountryCode(
      countryCode,
      height: 24,
      width: 36,
    );
  }
}
```

## Phase 6: Main.dart 수정

### 6.1 MaterialApp 설정 업데이트
```dart
// lib/main.dart
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'providers/localization_provider.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ExchangeRateProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => OnboardingProvider()),
        ChangeNotifierProvider(create: (context) => LocalizationProvider()), // 추가
      ],
      child: Consumer3<ThemeProvider, OnboardingProvider, LocalizationProvider>(
        builder: (context, themeProvider, onboardingProvider, localizationProvider, child) {
          return MaterialApp(
            title: '환율계산기',
            debugShowCheckedModeBanner: false,
            theme: themeProvider.currentTheme,
            locale: localizationProvider.currentLocale,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: LocalizationProvider.supportedLocales,
            onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
            home: onboardingProvider.isOnboardingCompleted 
                ? HomeScreen() 
                : OnboardingScreen(),
          );
        },
      ),
    );
  }
}
```

## Phase 7: 모든 UI 텍스트 다국어 적용

### 7.1 주요 화면별 텍스트 교체
모든 하드코딩된 텍스트를 AppLocalizations 호출로 교체:

```dart
// 예시: HomeScreen
Text('환율 변환기') → Text(AppLocalizations.of(context)!.appTitle)
Text('설정') → Text(AppLocalizations.of(context)!.settings)
Text('오프라인 모드 - 저장된 데이터 사용 중') → Text(AppLocalizations.of(context)!.offlineMode)
```

### 7.2 동적 텍스트 처리
```dart
// 시간 표시 예시
String getTimeAgoText(BuildContext context, DateTime time) {
  final l10n = AppLocalizations.of(context)!;
  final difference = DateTime.now().difference(time);
  
  if (difference.inMinutes < 1) {
    return l10n.justNow;
  } else if (difference.inHours < 1) {
    return l10n.minutesAgo(difference.inMinutes);
  } else if (difference.inHours < 24) {
    return l10n.hoursAgo(difference.inHours);
  } else {
    return DateFormat.yMd(Localizations.localeOf(context).languageCode).format(time);
  }
}
```

## Phase 8: 앱 이름 플랫폼별 현지화

### 8.1 Android (android/app/src/main/res/)
```xml
<!-- values/strings.xml (기본/영어) -->
<resources>
    <string name="app_name">Exchange Rate Calculator</string>
</resources>

<!-- values-ko/strings.xml (한국어) -->
<resources>
    <string name="app_name">환율계산기</string>
</resources>

<!-- values-ja/strings.xml (일본어) -->
<resources>
    <string name="app_name">為替計算機</string>
</resources>

<!-- values-zh/strings.xml (중국어) -->
<resources>
    <string name="app_name">汇率计算器</string>
</resources>
```

### 8.2 iOS (ios/Runner/Info.plist)
```xml
<key>CFBundleDisplayName</key>
<string>$(PRODUCT_NAME)</string>
```

InfoPlist.strings 파일 생성:
- en.lproj/InfoPlist.strings: `"CFBundleDisplayName" = "Exchange Rate Calculator";`
- ko.lproj/InfoPlist.strings: `"CFBundleDisplayName" = "환율계산기";`
- ja.lproj/InfoPlist.strings: `"CFBundleDisplayName" = "為替計算機";`
- zh.lproj/InfoPlist.strings: `"CFBundleDisplayName" = "汇率计算器";`

## Phase 9: 테스트 및 검증

### 9.1 테스트 체크리스트
- [ ] 각 언어별 앱 이름 표시 확인
- [ ] 온보딩에서 통화 선택 시 언어 자동 변경
- [ ] 설정에서 언어 수동 변경
- [ ] 모든 화면의 텍스트 번역 확인
- [ ] 날짜/시간 형식 현지화 확인
- [ ] RTL 언어 지원 (아랍어 등 추가 시)

### 9.2 디버깅 팁
```dart
// 현재 언어 확인
print('Current locale: ${Localizations.localeOf(context)}');

// 강제 언어 테스트
MaterialApp(
  locale: Locale('en'), // 테스트용 강제 설정
  ...
)
```

## 구현 우선순위

1. **필수 구현** (Phase 1-6)
   - 패키지 설정
   - 한국어/영어 번역 파일
   - LocalizationProvider
   - Main.dart 수정

2. **핵심 기능** (Phase 4-5)
   - 온보딩 자동 언어 선택
   - 설정 화면 언어 변경

3. **완성도** (Phase 7-8)
   - 전체 UI 번역
   - 앱 이름 현지화

4. **추가 언어** (선택적)
   - 일본어, 중국어 등 추가

## 주의사항

1. **번역 품질**: 전문 번역가 검토 권장
2. **문자열 길이**: 언어별 텍스트 길이 차이 고려
3. **날짜/숫자 형식**: 지역별 형식 차이 처리
4. **폰트 지원**: 모든 언어의 문자가 표시되는지 확인
5. **테스트**: 실제 기기에서 각 언어별 테스트 필수

## 참고 자료

- [Flutter Internationalization Guide](https://docs.flutter.dev/development/accessibility-and-localization/internationalization)
- [ARB File Format](https://github.com/google/app-resource-bundle)
- [flutter_localizations Package](https://api.flutter.dev/flutter/flutter_localizations/flutter_localizations-library.html)