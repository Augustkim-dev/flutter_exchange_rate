class CurrencyUtils {
  static final List<Map<String, String>> allCurrencies = [
    {'code': 'USD', 'name': '미국 달러', 'country': '미국'},
    {'code': 'EUR', 'name': '유로', 'country': '유럽연합'},
    {'code': 'JPY', 'name': '일본 엔', 'country': '일본'},
    {'code': 'GBP', 'name': '영국 파운드', 'country': '영국'},
    {'code': 'KRW', 'name': '한국 원', 'country': '한국'},
    {'code': 'CNY', 'name': '중국 위안', 'country': '중국'},
    {'code': 'AUD', 'name': '호주 달러', 'country': '호주'},
    {'code': 'CAD', 'name': '캐나다 달러', 'country': '캐나다'},
    {'code': 'CHF', 'name': '스위스 프랑', 'country': '스위스'},
    {'code': 'HKD', 'name': '홍콩 달러', 'country': '홍콩'},
    {'code': 'NZD', 'name': '뉴질랜드 달러', 'country': '뉴질랜드'},
    {'code': 'SEK', 'name': '스웨덴 크로나', 'country': '스웨덴'},
    {'code': 'NOK', 'name': '노르웨이 크로나', 'country': '노르웨이'},
    {'code': 'DKK', 'name': '덴마크 크로나', 'country': '덴마크'},
    {'code': 'SGD', 'name': '싱가포르 달러', 'country': '싱가포르'},
    {'code': 'THB', 'name': '태국 바트', 'country': '태국'},
    {'code': 'MYR', 'name': '말레이시아 링깃', 'country': '말레이시아'},
    {'code': 'IDR', 'name': '인도네시아 루피아', 'country': '인도네시아'},
    {'code': 'PHP', 'name': '필리핀 페소', 'country': '필리핀'},
    {'code': 'INR', 'name': '인도 루피', 'country': '인도'},
    {'code': 'BRL', 'name': '브라질 헤알', 'country': '브라질'},
    {'code': 'MXN', 'name': '멕시코 페소', 'country': '멕시코'},
    {'code': 'ARS', 'name': '아르헨티나 페소', 'country': '아르헨티나'},
    {'code': 'CLP', 'name': '칠레 페소', 'country': '칠레'},
    {'code': 'COP', 'name': '콜롬비아 페소', 'country': '콜롬비아'},
    {'code': 'PEN', 'name': '페루 솔', 'country': '페루'},
    {'code': 'UYU', 'name': '우루과이 페소', 'country': '우루과이'},
    {'code': 'VND', 'name': '베트남 동', 'country': '베트남'},
    {'code': 'TRY', 'name': '터키 리라', 'country': '터키'},
    {'code': 'RUB', 'name': '러시아 루블', 'country': '러시아'},
    {'code': 'PLN', 'name': '폴란드 즈워티', 'country': '폴란드'},
    {'code': 'CZK', 'name': '체코 코루나', 'country': '체코'},
    {'code': 'HUF', 'name': '헝가리 포린트', 'country': '헝가리'},
    {'code': 'RON', 'name': '루마니아 레이', 'country': '루마니아'},
    {'code': 'BGN', 'name': '불가리아 레프', 'country': '불가리아'},
    {'code': 'HRK', 'name': '크로아티아 쿠나', 'country': '크로아티아'},
    {'code': 'RSD', 'name': '세르비아 디나르', 'country': '세르비아'},
    {'code': 'UAH', 'name': '우크라이나 흐리브냐', 'country': '우크라이나'},
    {'code': 'ILS', 'name': '이스라엘 세켈', 'country': '이스라엘'},
    {'code': 'EGP', 'name': '이집트 파운드', 'country': '이집트'},
    {'code': 'ZAR', 'name': '남아프리카 랜드', 'country': '남아프리카'},
    {'code': 'NGN', 'name': '나이지리아 나이라', 'country': '나이지리아'},
    {'code': 'KES', 'name': '케냐 실링', 'country': '케냐'},
    {'code': 'GHS', 'name': '가나 세디', 'country': '가나'},
    {'code': 'MAD', 'name': '모로코 디르함', 'country': '모로코'},
    {'code': 'TND', 'name': '튀니지 디나르', 'country': '튀니지'},
    {'code': 'AED', 'name': '아랍에미리트 디르함', 'country': '아랍에미리트'},
    {'code': 'SAR', 'name': '사우디아라비아 리얄', 'country': '사우디아라비아'},
    {'code': 'QAR', 'name': '카타르 리얄', 'country': '카타르'},
    {'code': 'KWD', 'name': '쿠웨이트 디나르', 'country': '쿠웨이트'},
    {'code': 'BHD', 'name': '바레인 디나르', 'country': '바레인'},
    {'code': 'OMR', 'name': '오만 리얄', 'country': '오만'},
    {'code': 'JOD', 'name': '요르단 디나르', 'country': '요르단'},
    {'code': 'LBP', 'name': '레바논 파운드', 'country': '레바논'},
    {'code': 'IRR', 'name': '이란 리얄', 'country': '이란'},
    {'code': 'IQD', 'name': '이라크 디나르', 'country': '이라크'},
    {'code': 'PKR', 'name': '파키스탄 루피', 'country': '파키스탄'},
    {'code': 'BDT', 'name': '방글라데시 타카', 'country': '방글라데시'},
    {'code': 'LKR', 'name': '스리랑카 루피', 'country': '스리랑카'},
    {'code': 'NPR', 'name': '네팔 루피', 'country': '네팔'},
    {'code': 'BTN', 'name': '부탄 눌트럼', 'country': '부탄'},
    {'code': 'MMK', 'name': '미얀마 차트', 'country': '미얀마'},
    {'code': 'LAK', 'name': '라오스 킵', 'country': '라오스'},
    {'code': 'KHR', 'name': '캄보디아 리엘', 'country': '캄보디아'},
    {'code': 'MNT', 'name': '몽골 투그릭', 'country': '몽골'},
    {'code': 'KZT', 'name': '카자흐스탄 텡게', 'country': '카자흐스탄'},
    {'code': 'UZS', 'name': '우즈베키스탄 숨', 'country': '우즈베키스탄'},
    {'code': 'TJS', 'name': '타지키스탄 소모니', 'country': '타지키스탄'},
    {'code': 'KGS', 'name': '키르기스스탄 솜', 'country': '키르기스스탄'},
    {'code': 'TMT', 'name': '투르크메니스탄 마나트', 'country': '투르크메니스탄'},
    {'code': 'GEL', 'name': '조지아 라리', 'country': '조지아'},
    {'code': 'AMD', 'name': '아르메니아 드람', 'country': '아르메니아'},
    {'code': 'AZN', 'name': '아제르바이잔 마나트', 'country': '아제르바이잔'},
    {'code': 'BYN', 'name': '벨라루스 루블', 'country': '벨라루스'},
    {'code': 'MDL', 'name': '몰도바 레이', 'country': '몰도바'},
    {'code': 'ALL', 'name': '알바니아 렉', 'country': '알바니아'},
    {'code': 'MKD', 'name': '북마케도니아 데나르', 'country': '북마케도니아'},
    {'code': 'XCD', 'name': '동카리브 달러', 'country': '동카리브'},
    {'code': 'BBD', 'name': '바베이도스 달러', 'country': '바베이도스'},
    {'code': 'BZD', 'name': '벨리즈 달러', 'country': '벨리즈'},
    {'code': 'BMD', 'name': '버뮤다 달러', 'country': '버뮤다'},
    {'code': 'FJD', 'name': '피지 달러', 'country': '피지'},
    {'code': 'WST', 'name': '사모아 탈라', 'country': '사모아'},
    {'code': 'TOP', 'name': '통가 파앙가', 'country': '통가'},
    {'code': 'VUV', 'name': '바누아투 바투', 'country': '바누아투'},
    {'code': 'SBD', 'name': '솔로몬 제도 달러', 'country': '솔로몬 제도'},
    {'code': 'PGK', 'name': '파푸아뉴기니 키나', 'country': '파푸아뉴기니'},
    {'code': 'KID', 'name': '키리바시 달러', 'country': '키리바시'},
    {'code': 'TVD', 'name': '투발루 달러', 'country': '투발루'},
    {'code': 'XPF', 'name': 'CFP 프랑', 'country': '프랑스령 폴리네시아'},
    {'code': 'XAF', 'name': '중앙아프리카 CFA 프랑', 'country': '중앙아프리카'},
    {'code': 'XOF', 'name': '서아프리카 CFA 프랑', 'country': '서아프리카'},
    {'code': 'CDF', 'name': '콩고 프랑', 'country': '콩고민주공화국'},
    {'code': 'GNF', 'name': '기니 프랑', 'country': '기니'},
    {'code': 'BIF', 'name': '부룬디 프랑', 'country': '부룬디'},
    {'code': 'RWF', 'name': '르완다 프랑', 'country': '르완다'},
    {'code': 'DJF', 'name': '지부티 프랑', 'country': '지부티'},
    {'code': 'KMF', 'name': '코모로 프랑', 'country': '코모로'},
    {'code': 'MGA', 'name': '마다가스카르 아리아리', 'country': '마다가스카르'},
    {'code': 'MUR', 'name': '모리셔스 루피', 'country': '모리셔스'},
    {'code': 'SCR', 'name': '세이셸 루피', 'country': '세이셸'},
    {'code': 'SOS', 'name': '소말리아 실링', 'country': '소말리아'},
    {'code': 'TZS', 'name': '탄자니아 실링', 'country': '탄자니아'},
    {'code': 'UGX', 'name': '우간다 실링', 'country': '우간다'},
    {'code': 'MWK', 'name': '말라위 콰차', 'country': '말라위'},
    {'code': 'ZMW', 'name': '잠비아 콰차', 'country': '잠비아'},
    {'code': 'ZWL', 'name': '짐바브웨 달러', 'country': '짐바브웨'},
    {'code': 'LSL', 'name': '레소토 로티', 'country': '레소토'},
    {'code': 'SZL', 'name': '에스와티니 릴랑게니', 'country': '에스와티니'},
    {'code': 'NAD', 'name': '나미비아 달러', 'country': '나미비아'},
    {'code': 'BWP', 'name': '보츠와나 풀라', 'country': '보츠와나'},
    {'code': 'MZN', 'name': '모잠비크 메티칼', 'country': '모잠비크'},
    {'code': 'DZD', 'name': '알제리 디나르', 'country': '알제리'},
    {'code': 'LYD', 'name': '리비아 디나르', 'country': '리비아'},
    {'code': 'SDG', 'name': '수단 파운드', 'country': '수단'},
    {'code': 'SSP', 'name': '남수단 파운드', 'country': '남수단'},
    {'code': 'ETB', 'name': '에티오피아 비르', 'country': '에티오피아'},
    {'code': 'ERN', 'name': '에리트레아 나크파', 'country': '에리트레아'},
    {'code': 'SYP', 'name': '시리아 파운드', 'country': '시리아'},
    {'code': 'YER', 'name': '예멘 리얄', 'country': '예멘'},
    {'code': 'AFN', 'name': '아프가니스탄 아프가니', 'country': '아프가니스탄'},
    {'code': 'ANG', 'name': '네덜란드 안틸레스 길더', 'country': '네덜란드 안틸레스'},
    {'code': 'AOA', 'name': '앙골라 콴자', 'country': '앙골라'},
    {'code': 'AWG', 'name': '아루바 플로린', 'country': '아루바'},
    {'code': 'BAM', 'name': '보스니아 헤르체고비나 태환 마르카', 'country': '보스니아 헤르체고비나'},
    {'code': 'BOB', 'name': '볼리비아 볼리비아노', 'country': '볼리비아'},
    {'code': 'BSD', 'name': '바하마 달러', 'country': '바하마'},
    {'code': 'CUP', 'name': '쿠바 페소', 'country': '쿠바'},
    {'code': 'CVE', 'name': '카보베르데 에스쿠도', 'country': '카보베르데'},
    {'code': 'DOP', 'name': '도미니카 페소', 'country': '도미니카 공화국'},
    {'code': 'FKP', 'name': '포클랜드 제도 파운드', 'country': '포클랜드 제도'},
    {'code': 'FOK', 'name': '페로 제도 크로나', 'country': '페로 제도'},
    {'code': 'GGP', 'name': '건지 파운드', 'country': '건지'},
    {'code': 'GIP', 'name': '지브롤터 파운드', 'country': '지브롤터'},
    {'code': 'GMD', 'name': '감비아 달라시', 'country': '감비아'},
    {'code': 'GTQ', 'name': '과테말라 케찰', 'country': '과테말라'},
    {'code': 'GYD', 'name': '가이아나 달러', 'country': '가이아나'},
    {'code': 'HNL', 'name': '온두라스 렘피라', 'country': '온두라스'},
    {'code': 'HTG', 'name': '아이티 구르드', 'country': '아이티'},
    {'code': 'IMP', 'name': '맨 섬 파운드', 'country': '맨 섬'},
    {'code': 'ISK', 'name': '아이슬란드 크로나', 'country': '아이슬란드'},
    {'code': 'JEP', 'name': '저지 파운드', 'country': '저지'},
    {'code': 'JMD', 'name': '자메이카 달러', 'country': '자메이카'},
    {'code': 'LRD', 'name': '라이베리아 달러', 'country': '라이베리아'},
    {'code': 'MOP', 'name': '마카오 파타카', 'country': '마카오'},
    {'code': 'MRU', 'name': '모리타니 우기야', 'country': '모리타니'},
    {'code': 'MVR', 'name': '몰디브 루피야', 'country': '몰디브'},
    {'code': 'NIO', 'name': '니카라과 코르도바', 'country': '니카라과'},
    {'code': 'PAB', 'name': '파나마 발보아', 'country': '파나마'},
    {'code': 'PYG', 'name': '파라과이 과라니', 'country': '파라과이'},
    {'code': 'SHP', 'name': '세인트헬레나 파운드', 'country': '세인트헬레나'},
    {'code': 'SLE', 'name': '시에라리온 레온', 'country': '시에라리온'},
    {'code': 'SLL', 'name': '시에라리온 레온 (구)', 'country': '시에라리온'},
    {'code': 'SRD', 'name': '수리남 달러', 'country': '수리남'},
    {'code': 'STN', 'name': '상투메 프린시페 도브라', 'country': '상투메 프린시페'},
    {'code': 'TTD', 'name': '트리니다드 토바고 달러', 'country': '트리니다드 토바고'},
    {'code': 'TWD', 'name': '대만 달러', 'country': '대만'},
    {'code': 'VES', 'name': '베네수엘라 볼리바르', 'country': '베네수엘라'},
    {'code': 'XCG', 'name': '동카리브 달러 (금)', 'country': '동카리브'},
    {'code': 'XDR', 'name': '특별인출권', 'country': '국제통화기금'},
  ];

  /// 통화 코드로 통화 이름을 가져오는 함수
  static String getCurrencyName(String code) {
    final currency = allCurrencies.firstWhere(
      (currency) => currency['code'] == code,
      orElse: () => {'code': code, 'name': code, 'country': ''},
    );
    return currency['name']!;
  }

  /// 통화 코드로 국가명을 가져오는 함수
  static String getCurrencyCountry(String code) {
    final currency = allCurrencies.firstWhere(
      (currency) => currency['code'] == code,
      orElse: () => {'code': code, 'name': code, 'country': ''},
    );
    return currency['country']!;
  }

  /// 통화 코드로 통화 정보를 가져오는 함수
  static Map<String, String> getCurrencyInfo(String code) {
    return allCurrencies.firstWhere(
      (currency) => currency['code'] == code,
      orElse: () => {'code': code, 'name': code, 'country': ''},
    );
  }

  /// 통화 코드로 검색 가능한 모든 통화 목록을 가져오는 함수
  static List<Map<String, String>> getAllCurrencies() {
    return List.from(allCurrencies);
  }

  /// 통화 코드를 국가 코드로 변환하는 함수
  static String getCountryCodeFromCurrency(String currencyCode) {
    // 통화 코드와 국가 코드 매핑
    final Map<String, String> currencyToCountry = {
      'USD': 'US',
      'EUR': 'EU',
      'JPY': 'JP',
      'GBP': 'GB',
      'KRW': 'KR',
      'CNY': 'CN',
      'AUD': 'AU',
      'CAD': 'CA',
      'CHF': 'CH',
      'HKD': 'HK',
      'NZD': 'NZ',
      'SEK': 'SE',
      'NOK': 'NO',
      'DKK': 'DK',
      'SGD': 'SG',
      'THB': 'TH',
      'MYR': 'MY',
      'IDR': 'ID',
      'PHP': 'PH',
      'INR': 'IN',
      'BRL': 'BR',
      'MXN': 'MX',
      'ARS': 'AR',
      'CLP': 'CL',
      'COP': 'CO',
      'PEN': 'PE',
      'UYU': 'UY',
      'VND': 'VN',
      'TRY': 'TR',
      'RUB': 'RU',
      'PLN': 'PL',
      'CZK': 'CZ',
      'HUF': 'HU',
      'RON': 'RO',
      'BGN': 'BG',
      'HRK': 'HR',
      'RSD': 'RS',
      'UAH': 'UA',
      'ILS': 'IL',
      'EGP': 'EG',
      'ZAR': 'ZA',
      'NGN': 'NG',
      'KES': 'KE',
      'GHS': 'GH',
      'MAD': 'MA',
      'TND': 'TN',
      'AED': 'AE',
      'SAR': 'SA',
      'QAR': 'QA',
      'KWD': 'KW',
      'BHD': 'BH',
      'OMR': 'OM',
      'JOD': 'JO',
      'LBP': 'LB',
      'IRR': 'IR',
      'IQD': 'IQ',
      'PKR': 'PK',
      'BDT': 'BD',
      'LKR': 'LK',
      'NPR': 'NP',
      'BTN': 'BT',
      'MMK': 'MM',
      'LAK': 'LA',
      'KHR': 'KH',
      'MNT': 'MN',
      'KZT': 'KZ',
      'UZS': 'UZ',
      'TJS': 'TJ',
      'KGS': 'KG',
      'TMT': 'TM',
      'GEL': 'GE',
      'AMD': 'AM',
      'AZN': 'AZ',
      'BYN': 'BY',
      'MDL': 'MD',
      'ALL': 'AL',
      'MKD': 'MK',
      'XCD': 'AG',
      'BBD': 'BB',
      'BZD': 'BZ',
      'BMD': 'BM',
      'FJD': 'FJ',
      'WST': 'WS',
      'TOP': 'TO',
      'VUV': 'VU',
      'SBD': 'SB',
      'PGK': 'PG',
      'KID': 'KI',
      'TVD': 'TV',
      'XPF': 'PF',
      'XAF': 'CM',
      'XOF': 'CI',
      'CDF': 'CD',
      'GNF': 'GN',
      'BIF': 'BI',
      'RWF': 'RW',
      'DJF': 'DJ',
      'KMF': 'KM',
      'MGA': 'MG',
      'MUR': 'MU',
      'SCR': 'SC',
      'SOS': 'SO',
      'TZS': 'TZ',
      'UGX': 'UG',
      'MWK': 'MW',
      'ZMW': 'ZM',
      'ZWL': 'ZW',
      'LSL': 'LS',
      'SZL': 'SZ',
      'NAD': 'NA',
      'BWP': 'BW',
      'MZN': 'MZ',
      'DZD': 'DZ',
      'LYD': 'LY',
      'SDG': 'SD',
      'SSP': 'SS',
      'ETB': 'ET',
      'ERN': 'ER',
      'SYP': 'SY',
      'YER': 'YE',
      'AFN': 'AF',
      'ANG': 'AN',
      'AOA': 'AO',
      'AWG': 'AW',
      'BAM': 'BA',
      'BOB': 'BO',
      'BSD': 'BS',
      'CUP': 'CU',
      'CVE': 'CV',
      'DOP': 'DO',
      'FKP': 'FK',
      'FOK': 'FO',
      'GGP': 'GG',
      'GIP': 'GI',
      'GMD': 'GM',
      'GTQ': 'GT',
      'GYD': 'GY',
      'HNL': 'HN',
      'HTG': 'HT',
      'IMP': 'IM',
      'ISK': 'IS',
      'JEP': 'JE',
      'JMD': 'JM',
      'LRD': 'LR',
      'MOP': 'MO',
      'MRU': 'MR',
      'MVR': 'MV',
      'NIO': 'NI',
      'PAB': 'PA',
      'PYG': 'PY',
      'SHP': 'SH',
      'SLE': 'SL',
      'SLL': 'SL',
      'SRD': 'SR',
      'STN': 'ST',
      'TTD': 'TT',
      'TWD': 'TW',
      'VES': 'VE',
      'XCG': 'AG',
      'XDR': 'IMF',
    };

    // 특별한 경우 처리
    if (currencyCode == 'EUR') {
      // TODO: 유럽연합 국기 표시 문제 해결 필요
      // flag-icons에서 EU 국기가 존재하지만 country_flags 패키지에서 지원하지 않는 것 같음
      // 가능한 해결 방법:
      // 1. EU (European Union) - 가장 일반적인 코드
      // 2. EURO - 유로 관련 코드
      // 3. EUROPEAN_UNION - 전체 이름
      // 4. EUROPE - 유럽 대륙 코드
      // 현재는 물음표로 표시되도록 원래 코드 반환
      return 'EU'; // European Union (현재 물음표로 표시됨)
    }

    if (currencyCode == 'ANG') {
      // 네덜란드 안틸레스는 해체되었으므로 네덜란드(NL) 국기를 사용
      return 'NL'; // Netherlands
    }

    if (currencyCode == 'XDR') {
      // 특별인출권은 국제기구이므로 미국(US) 국기를 대신 사용
      return 'US'; // United States (IMF 본부 소재지)
    }

    return currencyToCountry[currencyCode] ?? currencyCode;
  }

  /// 숫자를 통화 형식으로 포맷팅하는 함수 (세자리마다 쉼표 추가)
  static String formatCurrency(double amount, {int decimalPlaces = 2}) {
    if (amount.isInfinite || amount.isNaN) {
      return '0.00';
    }

    // 소수점 자릿수에 따라 포맷팅
    String formatted;
    if (decimalPlaces == 0) {
      formatted = amount.toInt().toString();
    } else {
      formatted = amount.toStringAsFixed(decimalPlaces);
    }

    // 정수 부분과 소수 부분 분리
    List<String> parts = formatted.split('.');
    String integerPart = parts[0];
    String decimalPart = parts.length > 1 ? parts[1] : '';

    // 정수 부분에 세자리마다 쉼표 추가
    String formattedInteger = '';
    for (int i = 0; i < integerPart.length; i++) {
      if (i > 0 && (integerPart.length - i) % 3 == 0) {
        formattedInteger += ',';
      }
      formattedInteger += integerPart[i];
    }

    // 소수 부분이 있으면 추가
    if (decimalPart.isNotEmpty) {
      return '$formattedInteger.$decimalPart';
    } else {
      return formattedInteger;
    }
  }

  /// 통화별로 적절한 소수점 자릿수를 반환하는 함수
  static int getDecimalPlaces(String currencyCode) {
    // 대부분의 통화는 2자리 소수점 사용
    // 하지만 일부 통화는 0자리 소수점 사용 (예: JPY, KRW)
    switch (currencyCode) {
      case 'JPY':
      case 'KRW':
      case 'VND':
      case 'IDR':
      case 'BYR':
        return 0;
      default:
        return 2;
    }
  }

  /// 통화별로 포맷팅된 금액을 반환하는 함수
  static String formatCurrencyAmount(double amount, String currencyCode) {
    int decimalPlaces = getDecimalPlaces(currencyCode);
    return formatCurrency(amount, decimalPlaces: decimalPlaces);
  }
}
