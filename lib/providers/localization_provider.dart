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
    Locale('vi'), // 베트남어
    Locale('th'), // 태국어
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
      case 'JPY':
        setLocale(const Locale('ja'));
        break;
      case 'CNY':
        setLocale(const Locale('zh'));
        break;
      case 'VND':
        setLocale(const Locale('vi'));
        break;
      case 'THB':
        setLocale(const Locale('th'));
        break;
      case 'USD':
      case 'GBP':
      case 'AUD':
      case 'CAD':
      case 'EUR':
        setLocale(const Locale('en'));
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
      case 'vi':
        return 'Tiếng Việt';
      case 'th':
        return 'ภาษาไทย';
      default:
        return locale.languageCode;
    }
  }
  
  String getLanguageFlag(String languageCode) {
    switch (languageCode) {
      case 'ko':
        return 'KR';
      case 'en':
        return 'US';
      case 'ja':
        return 'JP';
      case 'zh':
        return 'CN';
      case 'vi':
        return 'VN';
      case 'th':
        return 'TH';
      default:
        return 'US';
    }
  }
}