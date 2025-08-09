import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingProvider extends ChangeNotifier {
  static const String _onboardingCompletedKey = 'onboarding_completed';
  static const String _homeCurrencyKey = 'home_currency';
  static const String _defaultCurrenciesKey = 'default_currencies';
  static const String _themeModeKey = 'theme_mode';
  
  bool _isOnboardingCompleted = false;
  String _homeCurrency = 'USD';
  List<String> _defaultCurrencies = ['USD', 'EUR', 'JPY', 'GBP', 'KRW'];
  ThemeMode _themeMode = ThemeMode.system;
  
  bool get isOnboardingCompleted => _isOnboardingCompleted;
  String get homeCurrency => _homeCurrency;
  List<String> get defaultCurrencies => List.unmodifiable(_defaultCurrencies);
  ThemeMode get themeMode => _themeMode;
  
  OnboardingProvider() {
    _loadSettings();
  }
  
  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _isOnboardingCompleted = prefs.getBool(_onboardingCompletedKey) ?? false;
    _homeCurrency = prefs.getString(_homeCurrencyKey) ?? 'USD';
    _defaultCurrencies = prefs.getStringList(_defaultCurrenciesKey) ?? ['USD', 'EUR', 'JPY', 'GBP', 'KRW'];
    
    final themeModeIndex = prefs.getInt(_themeModeKey) ?? 0;
    _themeMode = ThemeMode.values[themeModeIndex];
    
    notifyListeners();
  }
  
  Future<void> setOnboardingCompleted() async {
    _isOnboardingCompleted = true;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onboardingCompletedKey, true);
    notifyListeners();
  }
  
  Future<void> setHomeCurrency(String currency) async {
    _homeCurrency = currency;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_homeCurrencyKey, currency);
    notifyListeners();
  }
  
  Future<void> setDefaultCurrencies(List<String> currencies) async {
    _defaultCurrencies = List.from(currencies);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_defaultCurrenciesKey, currencies);
    notifyListeners();
  }
  
  Future<void> setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_themeModeKey, mode.index);
    notifyListeners();
  }
  
  void reorderCurrencies(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final item = _defaultCurrencies.removeAt(oldIndex);
    _defaultCurrencies.insert(newIndex, item);
    setDefaultCurrencies(_defaultCurrencies);
  }
} 