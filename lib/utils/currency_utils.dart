import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class CurrencyUtils {
  // 통화 코드에 대한 기본 정보 (국가 코드 매핑용)
  static final List<Map<String, String>> allCurrencies = [
    {'code': 'USD', 'country': 'US'},
    {'code': 'EUR', 'country': 'EU'},
    {'code': 'JPY', 'country': 'JP'},
    {'code': 'GBP', 'country': 'GB'},
    {'code': 'KRW', 'country': 'KR'},
    {'code': 'CNY', 'country': 'CN'},
    {'code': 'AUD', 'country': 'AU'},
    {'code': 'CAD', 'country': 'CA'},
    {'code': 'CHF', 'country': 'CH'},
    {'code': 'HKD', 'country': 'HK'},
    {'code': 'NZD', 'country': 'NZ'},
    {'code': 'SEK', 'country': 'SE'},
    {'code': 'NOK', 'country': 'NO'},
    {'code': 'DKK', 'country': 'DK'},
    {'code': 'SGD', 'country': 'SG'},
    {'code': 'THB', 'country': 'TH'},
    {'code': 'MYR', 'country': 'MY'},
    {'code': 'IDR', 'country': 'ID'},
    {'code': 'PHP', 'country': 'PH'},
    {'code': 'INR', 'country': 'IN'},
    {'code': 'BRL', 'country': 'BR'},
    {'code': 'MXN', 'country': 'MX'},
    {'code': 'ARS', 'country': 'AR'},
    {'code': 'CLP', 'country': 'CL'},
    {'code': 'COP', 'country': 'CO'},
    {'code': 'PEN', 'country': 'PE'},
    {'code': 'UYU', 'country': 'UY'},
    {'code': 'VND', 'country': 'VN'},
    {'code': 'TRY', 'country': 'TR'},
    {'code': 'RUB', 'country': 'RU'},
    {'code': 'PLN', 'country': 'PL'},
    {'code': 'CZK', 'country': 'CZ'},
    {'code': 'HUF', 'country': 'HU'},
    {'code': 'RON', 'country': 'RO'},
    {'code': 'BGN', 'country': 'BG'},
    {'code': 'HRK', 'country': 'HR'},
    {'code': 'RSD', 'country': 'RS'},
    {'code': 'UAH', 'country': 'UA'},
    {'code': 'ILS', 'country': 'IL'},
    {'code': 'EGP', 'country': 'EG'},
    {'code': 'ZAR', 'country': 'ZA'},
    {'code': 'NGN', 'country': 'NG'},
    {'code': 'KES', 'country': 'KE'},
    {'code': 'GHS', 'country': 'GH'},
    {'code': 'MAD', 'country': 'MA'},
    {'code': 'TND', 'country': 'TN'},
    {'code': 'AED', 'country': 'AE'},
    {'code': 'SAR', 'country': 'SA'},
    {'code': 'QAR', 'country': 'QA'},
    {'code': 'OMR', 'country': 'OM'},
    {'code': 'KWD', 'country': 'KW'},
    {'code': 'BHD', 'country': 'BH'},
    {'code': 'JOD', 'country': 'JO'},
    {'code': 'LBP', 'country': 'LB'},
    {'code': 'IRR', 'country': 'IR'},
    {'code': 'IQD', 'country': 'IQ'},
    {'code': 'AFN', 'country': 'AF'},
    {'code': 'PKR', 'country': 'PK'},
    {'code': 'LKR', 'country': 'LK'},
    {'code': 'BDT', 'country': 'BD'},
    {'code': 'NPR', 'country': 'NP'},
    {'code': 'MMK', 'country': 'MM'},
    {'code': 'LAK', 'country': 'LA'},
    {'code': 'KHR', 'country': 'KH'},
    {'code': 'BND', 'country': 'BN'},
    {'code': 'MNT', 'country': 'MN'},
    {'code': 'KZT', 'country': 'KZ'},
    {'code': 'UZS', 'country': 'UZ'},
    {'code': 'GEL', 'country': 'GE'},
    {'code': 'AMD', 'country': 'AM'},
    {'code': 'AZN', 'country': 'AZ'},
    {'code': 'TWD', 'country': 'TW'},
    {'code': 'MMK', 'country': 'MM'},
    {'code': 'KHR', 'country': 'KH'},
    {'code': 'LAK', 'country': 'LA'},
    {'code': 'BND', 'country': 'BN'},
  ];

  // getAllCurrencies 메서드 추가 (CurrencySelectionScreen에서 사용)
  static List<Map<String, String>> getAllCurrencies() {
    // 하위 호환성을 위해 기본값 반환 (한국어)
    return getAllCurrenciesWithContext(null);
  }

  // Context를 받아서 현지화된 통화 목록을 반환
  static List<Map<String, String>> getAllCurrenciesWithContext(BuildContext? context) {
    final currencyCodes = [
      'USD', 'EUR', 'JPY', 'GBP', 'KRW', 'CNY', 'AUD', 'CAD', 'CHF', 'HKD',
      'NZD', 'SEK', 'NOK', 'DKK', 'SGD', 'THB', 'MYR', 'IDR', 'PHP', 'INR',
      'BRL', 'MXN', 'VND', 'TRY', 'RUB', 'TWD', 'MMK', 'KHR', 'LAK', 'BND'
    ];

    final countryNames = {
      'USD': '미국',
      'EUR': '유럽연합',
      'JPY': '일본',
      'GBP': '영국',
      'KRW': '한국',
      'CNY': '중국',
      'AUD': '호주',
      'CAD': '캐나다',
      'CHF': '스위스',
      'HKD': '홍콩',
      'NZD': '뉴질랜드',
      'SEK': '스웨덴',
      'NOK': '노르웨이',
      'DKK': '덴마크',
      'SGD': '싱가포르',
      'THB': '태국',
      'MYR': '말레이시아',
      'IDR': '인도네시아',
      'PHP': '필리핀',
      'INR': '인도',
      'BRL': '브라질',
      'MXN': '멕시코',
      'VND': '베트남',
      'TRY': '터키',
      'RUB': '러시아',
      'TWD': '대만',
      'MMK': '미얀마',
      'KHR': '캄보디아',
      'LAK': '라오스',
      'BND': '브루나이'
    };

    return currencyCodes.map((code) {
      String name;
      if (context != null) {
        name = getCurrencyNameWithContext(context, code);
      } else {
        name = getCurrencyName(code);
      }
      return {
        'code': code,
        'name': name,
        'country': countryNames[code] ?? '',
      };
    }).toList();
  }

  // Context를 받아서 현지화된 통화 이름을 반환
  static String getCurrencyNameWithContext(BuildContext context, String code) {
    final l10n = AppLocalizations.of(context);
    if (l10n == null) {
      return getCurrencyName(code); // fallback
    }
    
    // 주요 통화들의 현지화된 이름 반환
    switch (code) {
      case 'USD':
        return l10n.currencyUSD;
      case 'EUR':
        return l10n.currencyEUR;
      case 'JPY':
        return l10n.currencyJPY;
      case 'GBP':
        return l10n.currencyGBP;
      case 'KRW':
        return l10n.currencyKRW;
      case 'CNY':
        return l10n.currencyCNY;
      case 'AUD':
        return l10n.currencyAUD;
      case 'CAD':
        return l10n.currencyCAD;
      case 'CHF':
        return l10n.currencyCHF;
      case 'HKD':
        return l10n.currencyHKD;
      case 'NZD':
        return l10n.currencyNZD;
      case 'SEK':
        return l10n.currencySEK;
      case 'NOK':
        return l10n.currencyNOK;
      case 'DKK':
        return l10n.currencyDKK;
      case 'SGD':
        return l10n.currencySGD;
      case 'THB':
        return l10n.currencyTHB;
      case 'MYR':
        return l10n.currencyMYR;
      case 'IDR':
        return l10n.currencyIDR;
      case 'PHP':
        return l10n.currencyPHP;
      case 'INR':
        return l10n.currencyINR;
      case 'VND':
        return l10n.currencyVND;
      case 'TRY':
        return l10n.currencyTRY;
      case 'RUB':
        return l10n.currencyRUB;
      case 'BRL':
        return l10n.currencyBRL;
      case 'MXN':
        return l10n.currencyMXN;
      case 'TWD':
        return getCurrencyName(code); // fallback to default name
      case 'MMK':
        return getCurrencyName(code); // fallback to default name
      case 'KHR':
        return getCurrencyName(code); // fallback to default name
      case 'LAK':
        return getCurrencyName(code); // fallback to default name
      case 'BND':
        return getCurrencyName(code); // fallback to default name
      default:
        return getCurrencyName(code); // 다른 통화는 기본 이름 사용
    }
  }

  // 기존 메서드 (하위 호환성을 위해 유지)
  static String getCurrencyName(String code) {
    final currencyNames = {
      'USD': '미국 달러',
      'EUR': '유로',
      'JPY': '일본 엔',
      'GBP': '영국 파운드',
      'KRW': '한국 원',
      'CNY': '중국 위안',
      'AUD': '호주 달러',
      'CAD': '캐나다 달러',
      'CHF': '스위스 프랑',
      'HKD': '홍콩 달러',
      'NZD': '뉴질랜드 달러',
      'SEK': '스웨덴 크로나',
      'NOK': '노르웨이 크로나',
      'DKK': '덴마크 크로나',
      'SGD': '싱가포르 달러',
      'THB': '태국 바트',
      'MYR': '말레이시아 링깃',
      'IDR': '인도네시아 루피아',
      'PHP': '필리핀 페소',
      'INR': '인도 루피',
      'BRL': '브라질 헤알',
      'MXN': '멕시코 페소',
      'ARS': '아르헨티나 페소',
      'CLP': '칠레 페소',
      'COP': '콜롬비아 페소',
      'PEN': '페루 솔',
      'UYU': '우루과이 페소',
      'VND': '베트남 동',
      'TRY': '터키 리라',
      'RUB': '러시아 루블',
      'PLN': '폴란드 즈워티',
      'CZK': '체코 코루나',
      'HUF': '헝가리 포린트',
      'RON': '루마니아 레이',
      'BGN': '불가리아 레프',
      'HRK': '크로아티아 쿠나',
      'RSD': '세르비아 디나르',
      'UAH': '우크라이나 흐리브냐',
      'ILS': '이스라엘 세켈',
      'EGP': '이집트 파운드',
      'ZAR': '남아프리카 랜드',
      'NGN': '나이지리아 나이라',
      'KES': '케냐 실링',
      'GHS': '가나 세디',
      'MAD': '모로코 디르함',
      'TND': '튀니지 디나르',
      'AED': '아랍에미리트 디르함',
      'SAR': '사우디아라비아 리얄',
      'TWD': '대만 달러',
      'MMK': '미얀마 짜트',
      'KHR': '캄보디아 리엘',
      'LAK': '라오스 킵',
      'BND': '브루나이 달러',
    };
    
    return currencyNames[code] ?? code;
  }

  static String getCountryCodeFromCurrency(String currencyCode) {
    final currency = allCurrencies.firstWhere(
      (c) => c['code'] == currencyCode,
      orElse: () => {'code': currencyCode, 'country': 'US'},
    );
    return currency['country'] ?? 'US';
  }

  static String formatCurrencyAmount(double amount, String currencyCode) {
    // 통화별 소수점 자리수 설정
    int decimalDigits = 2; // 기본값
    
    // 소수점이 없는 통화들
    if (['JPY', 'KRW', 'VND', 'IDR', 'CLP', 'PYG', 'UGX', 'RWF', 'VUV', 'XPF', 'KMF', 'GNF', 'BIF', 'DJF', 'XAF', 'XOF'].contains(currencyCode)) {
      decimalDigits = 0;
    }
    // 3자리 소수점을 사용하는 통화들
    else if (['BHD', 'IQD', 'JOD', 'KWD', 'LYD', 'OMR', 'TND'].contains(currencyCode)) {
      decimalDigits = 3;
    }
    
    // 통화 기호 매핑
    final currencySymbols = {
      'USD': '\$',
      'EUR': '€',
      'JPY': '¥',
      'GBP': '£',
      'KRW': '₩',
      'CNY': '¥',
      'INR': '₹',
      'RUB': '₽',
      'BRL': 'R\$',
      'MXN': '\$',
      'CAD': 'C\$',
      'AUD': 'A\$',
      'NZD': 'NZ\$',
      'HKD': 'HK\$',
      'SGD': 'S\$',
      'CHF': 'Fr',
      'SEK': 'kr',
      'NOK': 'kr',
      'DKK': 'kr',
      'PLN': 'zł',
      'CZK': 'Kč',
      'HUF': 'Ft',
      'RON': 'lei',
      'BGN': 'лв',
      'HRK': 'kn',
      'RSD': 'дин',
      'UAH': '₴',
      'ILS': '₪',
      'EGP': 'E£',
      'ZAR': 'R',
      'NGN': '₦',
      'KES': 'KSh',
      'GHS': 'GH₵',
      'MAD': 'د.م.',
      'TND': 'د.ت',
      'AED': 'د.إ',
      'SAR': 'ر.س',
      'THB': '฿',
      'VND': '₫',
      'PHP': '₱',
      'MYR': 'RM',
      'IDR': 'Rp',
      'TRY': '₺',
      'TWD': 'NT\$',
      'MMK': 'K',
      'KHR': '៛',
      'LAK': '₭',
      'BND': 'B\$',
    };
    
    // 숫자 포맷팅
    String formatted = amount.toStringAsFixed(decimalDigits);
    
    // 천 단위 구분자 추가
    List<String> parts = formatted.split('.');
    String integerPart = parts[0];
    String decimalPart = parts.length > 1 ? parts[1] : '';
    
    // 정규식을 사용하여 천 단위 구분자 추가
    integerPart = integerPart.replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
    
    // 결과 조합
    String result = integerPart;
    if (decimalPart.isNotEmpty && decimalDigits > 0) {
      result += '.$decimalPart';
    }
    
    // 통화 기호 추가
    String symbol = currencySymbols[currencyCode] ?? currencyCode + ' ';
    
    // 일부 통화는 기호를 뒤에 표시
    if (['SEK', 'NOK', 'DKK', 'CZK', 'PLN', 'HUF', 'RON', 'BGN', 'HRK', 'RSD'].contains(currencyCode)) {
      return '$result $symbol';
    }
    
    return '$symbol$result';
  }
}