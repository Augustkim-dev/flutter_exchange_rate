import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/exchange_rate_model.dart';
import '../services/exchange_rate_service.dart';

class ExchangeRateProvider with ChangeNotifier {
  // Keys for persistence
  static const String _currencyListKey = 'saved_currencies';
  static const String _amountKey = 'saved_amount';

  final ExchangeRateService _service = ExchangeRateService();

  // Constructor: load saved state
  ExchangeRateProvider() {
    _init();
  }

  void _init() {
    _loadSavedState();
  }

  // Load persisted currencies list and amount
  Future<void> _loadSavedState() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final currenciesJson = prefs.getString(_currencyListKey);
      if (currenciesJson != null) {
        _currencies = List<String>.from(jsonDecode(currenciesJson));
      } else {
        _currencies = ['USD', 'EUR', 'JPY', 'GBP', 'KRW'];
      }

      _amount = prefs.getDouble(_amountKey) ?? 0.0;
      _currentInput = _amount == 0.0 ? '' : _amount.toString();
      notifyListeners();
    } catch (e) {
      print('Error loading saved state: $e');
    }
  }

  // Persist helpers
  Future<void> _saveCurrencies() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_currencyListKey, jsonEncode(_currencies));
    } catch (e) {
      print('Error saving currencies: $e');
    }
  }

  Future<void> _saveAmount() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setDouble(_amountKey, _amount);
    } catch (e) {
      print('Error saving amount: $e');
    }
  }

  ExchangeRate? _exchangeRate;
  String _baseCurrency = 'USD';
  double _amount = 0.0;
  String? _selectedCurrency;
  String _currentInput = '';
  List<String> _currencies = [];
  List<String> _favoriteCurrencies = [];

  // 에러 상태 관리
  String? _errorMessage;
  bool _hasError = false;
  bool _isLoading = false;

  ExchangeRate? get exchangeRate => _exchangeRate;
  String get baseCurrency => _baseCurrency;
  double get amount => _amount;
  String? get selectedCurrency => _selectedCurrency;
  String get currentInput => _currentInput;
  List<String> get currencies => _currencies;
  List<String> get favoriteCurrencies => _favoriteCurrencies;

  // 에러 관련 getter
  String? get errorMessage => _errorMessage;
  bool get hasError => _hasError;
  bool get isLoading => _isLoading;

  // 즐겨찾기 관련 getter
  bool isFavorite(String currency) => _favoriteCurrencies.contains(currency);

  // 앱 초기화 시 즐겨찾기 로드
  Future<void> loadFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final favoritesJson = prefs.getString('favorite_currencies');
      if (favoritesJson != null) {
        _favoriteCurrencies = List<String>.from(jsonDecode(favoritesJson));
        notifyListeners();
      }
    } catch (e) {
      print('Error loading favorites: $e');
    }
  }

  // 온보딩에서 설정한 기본 통화 목록 로드
  void loadDefaultCurrencies(List<String> defaultCurrencies) {
    // 온보딩이나 다른 설정에서 전달된 통화 목록으로 항상 덮어쓴다.
    if (defaultCurrencies.isNotEmpty) {
      _currencies = List.from(defaultCurrencies);
    } else if (_currencies.isEmpty) {
      // 전달된 값이 없고 내부 목록도 비어 있으면 기본값 사용
      _currencies = ['USD', 'EUR', 'JPY', 'GBP', 'KRW'];
    }
    _saveCurrencies();
    notifyListeners();
  }

  // 즐겨찾기 저장
  Future<void> _saveFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('favorite_currencies', jsonEncode(_favoriteCurrencies));
    } catch (e) {
      print('Error saving favorites: $e');
    }
  }

  // 즐겨찾기 토글
  Future<void> toggleFavorite(String currency) async {
    if (_favoriteCurrencies.contains(currency)) {
      _favoriteCurrencies.remove(currency);
    } else {
      // 최대 10개까지만 즐겨찾기 가능
      if (_favoriteCurrencies.length >= 10) {
        // 여기서는 단순히 제거만 하고, UI에서 알림을 표시할 예정
        return;
      }
      _favoriteCurrencies.add(currency);
    }
    await _saveFavorites();
    notifyListeners();
  }

  // 에러 상태 관리 메서드
  void _clearError() {
    _errorMessage = null;
    _hasError = false;
    notifyListeners();
  }

  void _setError(String message) {
    _errorMessage = message;
    _hasError = true;
    notifyListeners();
  }

  // 입력값 검증 메서드
  String? validateAmount(String value) {
    if (value.isEmpty) return '금액을 입력해주세요';

    final amount = double.tryParse(value);
    if (amount == null) return '올바른 숫자를 입력해주세요';

    if (amount < 0) return '음수는 입력할 수 없습니다';

    if (amount > 999999999) return '너무 큰 숫자입니다';

    return null; // 검증 통과
  }

  bool isValidCurrencyCode(String code) {
    return _currencies.contains(code.toUpperCase());
  }

  Future<void> fetchExchangeRates() async {
    try {
      _clearError();
      _isLoading = true;
      notifyListeners();

      print('Fetching exchange rates for base currency: $_baseCurrency');
      _exchangeRate = await _service.getExchangeRates(_baseCurrency);
      print('Exchange rates loaded: $_exchangeRate');
      print('Available rates: ${_exchangeRate?.rates}');

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      print('Error fetching exchange rates: $e');
      _setError('환율 정보를 가져오는데 실패했습니다: $e');
    }
  }

  // 재시도 메커니즘
  Future<void> fetchExchangeRatesWithRetry({int maxRetries = 3}) async {
    for (int i = 0; i < maxRetries; i++) {
      try {
        await fetchExchangeRates();
        return; // 성공하면 종료
      } catch (e) {
        if (i == maxRetries - 1) {
          _setError('재시도 후에도 실패했습니다');
          return;
        }
        await Future.delayed(Duration(seconds: 2 * (i + 1))); // 지수 백오프
      }
    }
  }

  void setBaseCurrency(String currency) {
    _baseCurrency = currency;
    fetchExchangeRates();
  }

  void setAmount(double amount) {
    _amount = amount;
    _saveAmount();
    notifyListeners();
  }

  // 입력값 검증을 포함한 setAmount 메서드
  void setAmountWithValidation(String value) {
    final error = validateAmount(value);
    if (error != null) {
      _setError(error);
      return;
    }

    _clearError();
    _amount = double.parse(value);
    _currentInput = value;
    _saveAmount();
    notifyListeners();
  }

  void setSelectedCurrency(String? currency) {
    _selectedCurrency = currency;
    if (currency != null) {
      // 선택된 통화의 현재 환율 계산된 값을 표시값으로 설정
      final convertedAmount = calculateConversion(currency);
      _currentInput = convertedAmount.toString();
      // 현재 입력값을 USD 기준으로 업데이트
      if (currency != 'USD') {
        _amount = calculateReverseConversion(currency, convertedAmount);
      }
    } else {
      _currentInput = '';
    }
    _saveAmount();
    notifyListeners();
  }

  void addDigit(String digit) {
    if (_selectedCurrency == null) return;

    // 현재 입력이 0(또는 0.xxx)처럼 '0'을 의미한다면 첫 입력 시 초기화
    if (_currentInput.isEmpty || (double.tryParse(_currentInput) ?? 0) == 0) {
      if (digit == '.') {
        _currentInput = '0.'; // 소수점부터 시작
      } else {
        _currentInput = digit;
      }
    } else {
      // 중복 소수점 방지
      if (digit == '.' && _currentInput.contains('.')) return;

      // 최대 길이 제한 (소수점 포함 15자리)
      if (_currentInput.length >= 15) return;

      _currentInput += digit;
    }

    // 숫자 검증
    if (digit != '.' && digit != '0' && _currentInput.length > 1) {
      final testValue = double.tryParse(_currentInput);
      if (testValue == null || testValue > 999999999) return;
    }

    _updateAmount();
    notifyListeners();
  }

  void clearInput() {
    _currentInput = '';
    _updateAmount();
    notifyListeners();
  }

  void backspace() {
    if (_currentInput.isNotEmpty) {
      _currentInput = _currentInput.substring(0, _currentInput.length - 1);
      _updateAmount();
      notifyListeners();
    }
  }

  void _updateAmount() {
    if (_currentInput.isEmpty) {
      _amount = 0.0;
      _saveAmount();
      notifyListeners();
      return;
    }

    final inputAmount = double.tryParse(_currentInput) ?? 0.0;
    if (_selectedCurrency == 'USD') {
      _amount = inputAmount;
    } else {
      _amount = calculateReverseConversion(_selectedCurrency!, inputAmount);
    }

    // 디버깅을 위한 로그
    print('_updateAmount: inputAmount=$inputAmount, _amount=$_amount, selectedCurrency=$_selectedCurrency');
    print('Exchange rate data: $_exchangeRate');

    _saveAmount();
    notifyListeners();
  }

  double calculateConversion(String targetCurrency) {
    if (_exchangeRate == null) {
      print('calculateConversion: _exchangeRate is null for $targetCurrency');
      return 0.0;
    }

    // USD를 기준으로 하는 경우
    if (_baseCurrency == 'USD') {
      final rate = _exchangeRate!.rates[targetCurrency] ?? 0.0;
      final result = _amount * rate;
      print('calculateConversion: $targetCurrency, rate=$rate, _amount=$_amount, result=$result');
      return result;
    } else {
      // 다른 통화를 기준으로 하는 경우, USD를 거쳐서 계산
      final usdRate = _exchangeRate!.rates['USD'] ?? 0.0;
      final targetRate = _exchangeRate!.rates[targetCurrency] ?? 0.0;

      if (usdRate == 0.0) {
        print('calculateConversion: USD rate is 0 for $targetCurrency');
        return 0.0;
      }

      // 먼저 USD로 변환, 그 다음 목표 통화로 변환
      final usdAmount = _amount / usdRate;
      final result = usdAmount * targetRate;
      print(
        'calculateConversion: $targetCurrency, usdRate=$usdRate, targetRate=$targetRate, _amount=$_amount, usdAmount=$usdAmount, result=$result',
      );
      return result;
    }
  }

  void replaceCurrency(String oldCurrency, String newCurrency) {
    final index = _currencies.indexOf(oldCurrency);
    if (index != -1) {
      _currencies[index] = newCurrency;

      // 현재 선택된 통화가 교체되는 통화라면 선택 해제
      if (_selectedCurrency == oldCurrency) {
        _selectedCurrency = null;
        _currentInput = '';
      }

      _saveCurrencies();
      notifyListeners();
    }
  }

  // 새로운 통화 추가
  void addCurrency(String currency) {
    if (!_currencies.contains(currency)) {
      _currencies.add(currency);
      _saveCurrencies();
      notifyListeners();
    }
  }

  // 통화 제거
  void removeCurrency(String currency) {
    if (_currencies.length > 1) {
      // 최소 1개는 유지
      _currencies.remove(currency);

      // 현재 선택된 통화가 제거되는 통화라면 선택 해제
      if (_selectedCurrency == currency) {
        _selectedCurrency = null;
        _currentInput = '';
      }

      _saveCurrencies();
      notifyListeners();
    }
  }

  double calculateReverseConversion(String targetCurrency, double targetAmount) {
    if (_exchangeRate == null) {
      print('calculateReverseConversion: _exchangeRate is null for $targetCurrency');
      return 0.0;
    }

    // USD를 기준으로 하는 경우
    if (_baseCurrency == 'USD') {
      final rate = _exchangeRate!.rates[targetCurrency] ?? 0.0;
      if (rate == 0.0) {
        print('calculateReverseConversion: rate is 0 for $targetCurrency');
        return 0.0;
      }
      final result = targetAmount / rate;
      print('calculateReverseConversion: $targetCurrency, rate=$rate, targetAmount=$targetAmount, result=$result');
      return result;
    } else {
      // 다른 통화를 기준으로 하는 경우, USD를 거쳐서 계산
      final usdRate = _exchangeRate!.rates['USD'] ?? 0.0;
      final targetRate = _exchangeRate!.rates[targetCurrency] ?? 0.0;

      if (usdRate == 0.0 || targetRate == 0.0) {
        print('calculateReverseConversion: rate is 0 for USD or $targetCurrency');
        return 0.0;
      }

      // 먼저 USD로 변환, 그 다음 기준 통화로 변환
      final usdAmount = targetAmount / targetRate;
      final result = usdAmount * usdRate;
      print(
        'calculateReverseConversion: $targetCurrency, usdRate=$usdRate, targetRate=$targetRate, targetAmount=$targetAmount, usdAmount=$usdAmount, result=$result',
      );
      return result;
    }
  }
}
