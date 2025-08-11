// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appTitle => '환율계산기';

  @override
  String get settings => '설정';

  @override
  String get language => '언어';

  @override
  String get darkMode => '다크모드';

  @override
  String get refreshRates => '환율 데이터 새로고침';

  @override
  String lastUpdated(String time) {
    return '마지막 업데이트: $time';
  }

  @override
  String get selectCurrency => '통화 선택';

  @override
  String get favorites => '즐겨찾기';

  @override
  String get aboutApp => '개발자 정보';

  @override
  String get feedback => '의견보내기';

  @override
  String get offlineMode => '오프라인 모드 - 저장된 데이터 사용 중';

  @override
  String inputAmount(String currency) {
    return '$currency 금액 입력';
  }

  @override
  String get noInternetConnection => '인터넷 연결을 확인해주세요';

  @override
  String get cacheDataDeleted => '캐시가 삭제되었습니다';

  @override
  String get confirmDeleteCache => '저장된 모든 환율 데이터를 삭제하시겠습니까?';

  @override
  String get cancel => '취소';

  @override
  String get delete => '삭제';

  @override
  String get retry => '재시도';

  @override
  String get error => '오류';

  @override
  String get loading => '로딩 중...';

  @override
  String get welcome => '환영합니다';

  @override
  String get getStarted => '시작하기';

  @override
  String get selectHomeCurrency => '홈 통화를 선택하세요';

  @override
  String get selectDefaultCurrencies => '기본 통화를 선택하세요';

  @override
  String get continueButton => '계속';

  @override
  String get skip => '건너뛰기';

  @override
  String get next => '다음';

  @override
  String get justNow => '방금 전';

  @override
  String minutesAgo(int count) {
    return '$count분 전';
  }

  @override
  String hoursAgo(int count) {
    return '$count시간 전';
  }

  @override
  String get realtimeExchangeRate => '실시간 환율 정보';

  @override
  String get developerInfo => '개발자 정보';

  @override
  String get sendFeedback => '의견보내기';

  @override
  String get manageAppSettings => '앱 설정을 관리합니다';

  @override
  String get changeLanguage => '언어를 변경합니다';

  @override
  String get darkModeEnabled => '다크모드가 활성화되었습니다';

  @override
  String get lightModeEnabled => '라이트모드가 활성화되었습니다';

  @override
  String get notifications => '알림 설정';

  @override
  String get receiveRateAlerts => '환율 변동 알림을 받습니다';

  @override
  String get autoRefresh => '자동 새로고침';

  @override
  String get updateEvery5Minutes => '5분마다 환율을 자동으로 업데이트합니다';

  @override
  String get favoriteCurrencies => '즐겨찾기 통화';

  @override
  String currentFavorites(int count) {
    return '현재 $count개 통화가 즐겨찾기에 저장되어 있습니다';
  }

  @override
  String get usingCachedData => '캐시 데이터 사용 중';

  @override
  String get refresh => '새로고침';

  @override
  String get ratesUpdated => '환율 데이터가 업데이트되었습니다';

  @override
  String get updateFailed => '업데이트 실패';

  @override
  String get version => '버전';

  @override
  String get inputting => '입력 중';

  @override
  String get cacheDeletion => '캐시 삭제';

  @override
  String get loadingRates => '환율 정보를 불러오는 중입니다...';

  @override
  String get unknownError => '알 수 없는 오류가 발생했습니다';

  @override
  String get retryLoading => '다시 시도';

  @override
  String get amount => '금액';

  @override
  String get enterAmount => '금액 입력';

  @override
  String get clear => '지우기';

  @override
  String get update => '업데이트';

  @override
  String get currencyUSD => '미국 달러';

  @override
  String get currencyEUR => '유로';

  @override
  String get currencyJPY => '일본 엔';

  @override
  String get currencyGBP => '영국 파운드';

  @override
  String get currencyKRW => '한국 원';

  @override
  String get currencyCNY => '중국 위안';

  @override
  String get currencyAUD => '호주 달러';

  @override
  String get currencyCAD => '캐나다 달러';

  @override
  String get currencyCHF => '스위스 프랑';

  @override
  String get currencyHKD => '홍콩 달러';

  @override
  String get currencyNZD => '뉴질랜드 달러';

  @override
  String get currencySEK => '스웨덴 크로나';

  @override
  String get currencyNOK => '노르웨이 크로나';

  @override
  String get currencyDKK => '덴마크 크로나';

  @override
  String get currencySGD => '싱가포르 달러';

  @override
  String get currencyTHB => '태국 바트';

  @override
  String get currencyMYR => '말레이시아 링깃';

  @override
  String get currencyIDR => '인도네시아 루피아';

  @override
  String get currencyPHP => '필리핀 페소';

  @override
  String get currencyINR => '인도 루피';

  @override
  String get currencyVND => '베트남 동';

  @override
  String get currencyTRY => '터키 리라';

  @override
  String get currencyRUB => '러시아 루블';

  @override
  String get currencyBRL => '브라질 헤알';

  @override
  String get currencyMXN => '멕시코 페소';

  @override
  String get addCurrency => '통화 추가';

  @override
  String get alreadyInFavorites => '이미 즐겨찾기에 포함되어 있습니다';

  @override
  String get appInfo => '앱 정보';

  @override
  String get versionInfo => '버전 1.0.0';

  @override
  String get getLocationCurrency => '위치 정보로 통화 가져오기';

  @override
  String get category => '카테고리';

  @override
  String get general => '일반';

  @override
  String get other => '기타';

  @override
  String get platform => '플랫폼';

  @override
  String get license => '라이선스';

  @override
  String get developer => '개발자';

  @override
  String get contact => '연락처';

  @override
  String get website => '웹사이트';

  @override
  String get preview => '미리보기';

  @override
  String get start => '시작';

  @override
  String get manageFavoriteCurrencies => '즐겨찾기 통화 관리';

  @override
  String get allCurrencies => '전체 통화';

  @override
  String get searchCurrencies => '통화 코드, 이름, 국가로 검색...';

  @override
  String get maxCurrenciesReached => '10개까지만 선택할 수 있습니다';

  @override
  String currencyAddedToFavorites(String currency) {
    return '$currency가 즐겨찾기에 추가되었습니다';
  }
}
