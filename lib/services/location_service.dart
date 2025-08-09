import 'package:geolocator/geolocator.dart';

class LocationService {
  static final Map<String, String> _countryToCurrency = {
    'US': 'USD',
    'KR': 'KRW',
    'JP': 'JPY',
    'CN': 'CNY',
    'GB': 'GBP',
    'DE': 'EUR',
    'FR': 'EUR',
    'IT': 'EUR',
    'ES': 'EUR',
    'CA': 'CAD',
    'AU': 'AUD',
    'IN': 'INR',
    'BR': 'BRL',
    'RU': 'RUB',
    'MX': 'MXN',
    'SG': 'SGD',
    'HK': 'HKD',
    'TW': 'TWD',
    'TH': 'THB',
    'MY': 'MYR',
    'ID': 'IDR',
    'PH': 'PHP',
    'VN': 'VND',
    'AE': 'AED',
    'SA': 'SAR',
    'TR': 'TRY',
    'ZA': 'ZAR',
    'EG': 'EGP',
    'NG': 'NGN',
    'KE': 'KES',
    'GH': 'GHS',
    'MA': 'MAD',
    'TN': 'TND',
    'DZ': 'DZD',
    'LY': 'LYD',
    'SD': 'SDG',
    'ET': 'ETB',
    'TZ': 'TZS',
    'UG': 'UGX',
    'ZM': 'ZMW',
    'ZW': 'ZWL',
    'BW': 'BWP',
    'NA': 'NAD',
    'SZ': 'SZL',
    'LS': 'LSL',
    'MW': 'MWK',
    'MZ': 'MZN',
    'MG': 'MGA',
    'MU': 'MUR',
    'SC': 'SCR',
    'KM': 'KMF',
    'DJ': 'DJF',
    'SO': 'SOS',
    'ER': 'ERN',
    'SS': 'SSP',
    'CF': 'XAF',
    'TD': 'XAF',
    'CM': 'XAF',
    'GQ': 'XAF',
    'GA': 'XAF',
    'CG': 'XAF',
    'CD': 'CDF',
    'AO': 'AOA',
    'ST': 'STN',
    'GW': 'XOF',
    'GN': 'XOF',
    'BF': 'XOF',
    'CI': 'XOF',
    'ML': 'XOF',
    'NE': 'XOF',
    'SN': 'XOF',
    'TG': 'XOF',
    'BJ': 'XOF',
    'SL': 'SLL',
    'LR': 'LRD',
    'GM': 'GMD',
    'CV': 'CVE',
  };

  /// 위치 권한을 요청하고 현재 위치를 가져옵니다.
  static Future<Position?> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // 위치 서비스가 활성화되어 있는지 확인
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return null;
    }

    // 위치 권한 확인
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return null;
    }

    // 현재 위치 가져오기
    try {
      return await Geolocator.getCurrentPosition();
    } catch (e) {
      return null;
    }
  }

  /// 위치 정보를 기반으로 자국 통화를 감지합니다.
  static Future<String?> detectHomeCurrency() async {
    try {
      final position = await getCurrentLocation();
      if (position == null) return null;

      // 위치 정보를 기반으로 국가 코드를 추정
      // 실제 구현에서는 reverse geocoding API를 사용해야 하지만,
      // 여기서는 간단한 위도/경도 기반 추정을 사용합니다.

      // 한국 근처 (대략적인 위도/경도 범위)
      if (position.latitude >= 33.0 &&
          position.latitude <= 38.5 &&
          position.longitude >= 124.5 &&
          position.longitude <= 132.0) {
        return 'KRW';
      }

      // 미국 근처
      if (position.latitude >= 24.0 &&
          position.latitude <= 71.0 &&
          position.longitude >= -180.0 &&
          position.longitude <= -66.0) {
        return 'USD';
      }

      // 일본 근처
      if (position.latitude >= 24.0 &&
          position.latitude <= 46.0 &&
          position.longitude >= 122.0 &&
          position.longitude <= 146.0) {
        return 'JPY';
      }

      // 유럽 근처
      if (position.latitude >= 35.0 &&
          position.latitude <= 71.0 &&
          position.longitude >= -10.0 &&
          position.longitude <= 40.0) {
        return 'EUR';
      }

      // 중국 근처
      if (position.latitude >= 18.0 &&
          position.latitude <= 54.0 &&
          position.longitude >= 73.0 &&
          position.longitude <= 135.0) {
        return 'CNY';
      }

      // 기본값
      return 'USD';
    } catch (e) {
      return null;
    }
  }

  /// 국가 코드를 기반으로 통화 코드를 가져옵니다.
  static String? getCurrencyFromCountryCode(String? countryCode) {
    if (countryCode == null) return null;
    return _countryToCurrency[countryCode.toUpperCase()];
  }
}
