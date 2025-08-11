import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;
import '../models/exchange_rate_model.dart';
import '../helpers/database_helper.dart';

class ExchangeRateService {
  static const String _baseUrl = 'https://api.exchangerate-api.com/v4/latest';
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<ExchangeRate> getExchangeRates(String baseCurrency, {bool forceRefresh = false}) async {
    // 1. 강제 새로고침이 아니면 캐시 확인
    if (!forceRefresh) {
      final cachedData = await _getCachedExchangeRate(baseCurrency);
      if (cachedData != null && cachedData.isCacheValid()) {
        print('환율 데이터를 캐시에서 불러왔습니다 (${baseCurrency})');
        return cachedData;
      }
    }

    // 2. 캐시가 없거나 만료되었으면 API 호출
    try {
      print('API에서 환율 데이터를 가져옵니다 (${baseCurrency})');
      final exchangeRate = await _fetchFromApi(baseCurrency);
      
      // 3. 새로운 데이터를 캐시에 저장
      await _saveToCache(exchangeRate);
      
      return exchangeRate;
    } catch (e) {
      // 4. API 호출 실패 시 캐시 데이터 사용 (만료되었더라도)
      final cachedData = await _getCachedExchangeRate(baseCurrency);
      if (cachedData != null) {
        print('API 호출 실패, 캐시 데이터를 사용합니다 (${baseCurrency})');
        return cachedData;
      }
      
      // 5. 캐시도 없으면 에러 전파
      rethrow;
    }
  }

  // API에서 데이터 가져오기
  Future<ExchangeRate> _fetchFromApi(String baseCurrency) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/$baseCurrency'),
        headers: {'Content-Type': 'application/json'},
      ).timeout(Duration(seconds: 10)); // 10초 타임아웃

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return ExchangeRate.fromJson(data);
      } else if (response.statusCode == 404) {
        throw Exception('지원하지 않는 통화입니다: $baseCurrency');
      } else if (response.statusCode == 429) {
        throw Exception('API 요청 한도를 초과했습니다. 잠시 후 다시 시도해주세요');
      } else if (response.statusCode >= 500) {
        throw Exception('서버 오류가 발생했습니다. 잠시 후 다시 시도해주세요');
      } else {
        throw Exception('환율 정보를 가져오는데 실패했습니다 (상태 코드: ${response.statusCode})');
      }
    } on SocketException {
      throw Exception('인터넷 연결을 확인해주세요');
    } on TimeoutException {
      throw Exception('요청 시간이 초과되었습니다. 다시 시도해주세요');
    } on FormatException {
      throw Exception('서버 응답을 처리할 수 없습니다');
    } catch (e) {
      if (e is Exception) {
        rethrow;
      }
      throw Exception('알 수 없는 오류가 발생했습니다: $e');
    }
  }

  // 캐시에서 데이터 가져오기
  Future<ExchangeRate?> _getCachedExchangeRate(String baseCurrency) async {
    try {
      final cachedData = await _databaseHelper.getExchangeRate(baseCurrency);
      if (cachedData == null) return null;

      return ExchangeRate.fromCache(
        base: cachedData['base_currency'] as String,
        rates: cachedData['rates'] as Map<String, dynamic>,
        lastUpdated: cachedData['last_updated'] as DateTime,
      );
    } catch (e) {
      print('캐시 조회 실패: $e');
      return null;
    }
  }

  // 캐시에 데이터 저장
  Future<void> _saveToCache(ExchangeRate exchangeRate) async {
    try {
      await _databaseHelper.insertExchangeRate(
        baseCurrency: exchangeRate.base,
        rates: exchangeRate.rates,
        lastUpdated: exchangeRate.lastUpdated ?? DateTime.now(),
      );
      
      // 마지막 동기화 시간 업데이트
      await _databaseHelper.setLastSyncTime(DateTime.now());
      
      print('환율 데이터를 캐시에 저장했습니다 (${exchangeRate.base})');
    } catch (e) {
      print('캐시 저장 실패: $e');
      // 캐시 저장 실패는 무시 (API 데이터는 정상적으로 반환)
    }
  }

  // 캐시 유효성 확인
  Future<bool> isCacheValid(String baseCurrency) async {
    return await _databaseHelper.isCacheValid(baseCurrency);
  }

  // 마지막 동기화 시간 조회
  Future<DateTime?> getLastSyncTime() async {
    return await _databaseHelper.getLastSyncTime();
  }

  // 캐시된 통화 목록 조회
  Future<List<String>> getCachedCurrencies() async {
    return await _databaseHelper.getCachedCurrencies();
  }

  // 오래된 캐시 정리
  Future<void> cleanOldCache() async {
    final deletedCount = await _databaseHelper.cleanOldData();
    if (deletedCount > 0) {
      print('오래된 캐시 $deletedCount개를 삭제했습니다');
    }
  }

  // 모든 캐시 삭제
  Future<void> clearAllCache() async {
    await _databaseHelper.clearAllData();
    print('모든 캐시를 삭제했습니다');
  }
}
