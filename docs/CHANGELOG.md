# 📋 CHANGELOG

모든 주목할 만한 변경 사항이 이 파일에 문서화됩니다.

이 프로젝트는 [Semantic Versioning](https://semver.org/spec/v2.0.0.html)을 준수합니다.

## [1.0.6] - 2025-09-01

### Fixed
- 🐛 안드로이드 네비게이션 바 오버랩 문제 해결
  - 모든 화면에 SafeArea 적용
  - 하단 시스템 UI와 앱 콘텐츠 겹침 방지
  - 숫자 키패드 하단 버튼(0, ., ⌫) 터치 영역 보장
- 📱 온보딩 화면부터 적용되는 일관된 SafeArea 처리
  
### Changed
- 🎨 UI 안정성 개선
  - 11개 화면 모두 SafeArea 적용 완료
  - 시스템 제스처 네비게이션 대응
  - 다양한 디바이스 화면 비율 호환성 향상

### Technical
- Flutter SafeArea 위젯 전면 적용
- bottom: true 파라미터로 하단 영역만 보호
- 기존 레이아웃 구조 유지하며 안정성 강화

## [1.0.5] - 2025-08-14

### Added
- 🌍 5개 신규 통화 지원 추가
  - TWD (대만 달러)
  - MMK (미얀마 짜트)
  - KHR (캄보디아 리엘)
  - LAK (라오스 킵)
  - BND (브루나이 달러)
- 📱 반응형 UI 레이아웃
  - 작은 화면용 2줄 레이아웃
  - 화면 크기별 최적화
- 🔄 통화 목록 드래그 앤 드롭 기능
  - ReorderableListView 구현
  - 순서 변경 상태 저장
- 📊 시스템 정보 동적 표시
  - PackageInfo를 통한 버전 자동 감지
  - 플랫폼 정보 실시간 표시

### Changed
- 📦 메이저 패키지 업데이트
  - Firebase 패키지 v3.x → v4.x/5.x/6.x/12.x
  - Geolocator v10.1.0 → v14.0.2
- 🤖 Android 설정 업데이트
  - minSdk: 21 → 23
  - compileSdk: 34 → 35
  - targetSdk: 34 → 35
- 🎨 UI/UX 개선
  - ListTile 커스텀 위젯으로 변경
  - 드래그 핸들 아이콘 추가

### Fixed
- 🐛 Android 15 호환성 문제 해결
  - Edge-to-edge 디스플레이 지원
  - Deprecated API 경고 해결
- 🔧 Java 컴파일 버전 경고 수정
- 📱 작은 화면에서 UI 겹침 문제 해결

### Technical
- Flutter SDK: 3.32.8
- Dart: 3.8.1
- Android Gradle Plugin 업데이트
- Java 11 호환성 확인

## [1.0.4] - 2025-08-13

### Added
- 🌐 기본 환율 변환 기능
- 🔄 실시간 환율 업데이트
- 💾 오프라인 캐시 지원
- 🌏 다국어 지원 (6개 언어)
  - 한국어, 영어, 일본어
  - 중국어, 태국어, 베트남어
- 🌙 다크 모드 지원
- 📍 위치 기반 통화 자동 감지
- ⭐ 즐겨찾기 기능

### Features
- 30+ 통화 지원
- 사용자 맞춤 통화 목록
- 커스텀 숫자 키보드
- 온보딩 화면
- 앱 업데이트 알림

## [1.0.3] - 2025-08-12

### Added
- 초기 릴리즈 준비
- Google Play 스토어 등록
- Firebase 통합
  - Analytics
  - Crashlytics
  - Remote Config

## [1.0.0] - 2025-08-01

### Added
- 프로젝트 초기 설정
- 기본 UI 구조 구현
- Provider 패턴 적용
- 환율 API 연동

---

## 버전 규칙

- **Major (1.x.x)**: 주요 기능 추가 또는 breaking changes
- **Minor (x.1.x)**: 새로운 기능 추가 (backward compatible)
- **Patch (x.x.1)**: 버그 수정 및 마이너 개선

## 기여자

- Lead Developer: Flutter 개발자
- Contact: augustkim.dev@gmail.com