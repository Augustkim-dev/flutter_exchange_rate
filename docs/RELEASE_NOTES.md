# 📝 Release Notes

## Version 1.0.5 (Build 6) - 2025-08-14

### 🎯 주요 업데이트

#### 1. **Android 15 완벽 지원**
- Edge-to-edge 디스플레이 지원 추가
- 시스템 인셋 처리 개선
- compileSdk 및 targetSdk 35로 업데이트
- 투명한 상태바 및 네비게이션바 적용

#### 2. **반응형 UI 개선**
- 작은 화면(< 360px)에서 통화 목록 2줄 표시
  - 첫 줄: 국기, 통화코드, 국가명
  - 둘 줄: 변환된 금액
- 화면 크기별 최적화된 레이아웃
- 가독성 및 사용성 대폭 개선

#### 3. **통화 목록 기능 강화**
- **드래그 앤 드롭**: 통화 순서를 자유롭게 변경 가능
- **5개 신규 통화 추가**:
  - 🇹🇼 TWD (대만 달러)
  - 🇲🇲 MMK (미얀마 짜트)
  - 🇰🇭 KHR (캄보디아 리엘)
  - 🇱🇦 LAK (라오스 킵)
  - 🇧🇳 BND (브루나이 달러)

#### 4. **메이저 패키지 업데이트**
- **Firebase 패키지 업그레이드**:
  - firebase_core: 3.8.0 → 4.0.0
  - firebase_analytics: 11.3.6 → 12.0.0
  - firebase_crashlytics: 4.2.0 → 5.0.0
  - firebase_remote_config: 5.2.0 → 6.0.0
- **Geolocator**: 10.1.0 → 14.0.2
- 향상된 성능 및 안정성

#### 5. **시스템 정보 동적 표시**
- AboutScreen에서 실시간 버전 정보 표시
- 앱 버전, 빌드 번호 자동 감지
- Flutter/Dart 버전 정보 표시
- 실행 중인 플랫폼 자동 감지

### 📱 최소 요구사항 변경
- **Android**: 최소 SDK 21 → 23 (Android 6.0 이상)
- Firebase Analytics v12 요구사항에 따른 변경

### 🐛 버그 수정
- Java 컴파일 버전 경고 해결
- Android 15 deprecated API 경고 해결
- 작은 화면에서 UI 겹침 문제 수정

### 🔧 기술적 개선
- Flutter SDK 3.32.8 적용
- Dart 3.8.1 사용
- 코드 최적화 및 성능 개선

---

## Version 1.0.4 (Build 5) - 이전 버전

### 주요 기능
- 기본 환율 변환 기능
- 실시간 환율 업데이트
- 오프라인 캐시 지원
- 다국어 지원 (한국어, 영어, 일본어, 중국어, 태국어, 베트남어)
- 다크 모드 지원
- 위치 기반 통화 자동 감지

### 지원 통화
- 주요 통화: USD, EUR, JPY, GBP, KRW, CNY
- 아시아: SGD, THB, MYR, IDR, PHP, INR, VND
- 미주: CAD, BRL, MXN, ARS, CLP, COP, PEN, UYU
- 유럽: CHF, SEK, NOK, DKK, PLN, CZK, HUF, RON
- 기타: AUD, NZD, HKD, TRY, RUB, ZAR 등