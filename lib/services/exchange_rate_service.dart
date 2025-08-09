import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;
import '../models/exchange_rate_model.dart';

class ExchangeRateService {
  static const String _baseUrl = 'https://api.exchangerate-api.com/v4/latest';

  Future<ExchangeRate> getExchangeRates(String baseCurrency) async {
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
}
