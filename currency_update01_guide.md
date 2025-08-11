# 📋 환율 데이터 로컬 캐싱 구현 계획

## 개요
환율 데이터를 하루에 1번만 서버에서 가져와 로컬 SQLite 데이터베이스에 저장하고, 이후 조회는 로컬 DB에서 처리하는 시스템 구현 계획입니다.

## Phase 1: 데이터베이스 설계 및 설정

### 1.1 필요 패키지 추가
- `sqflite`: SQLite 데이터베이스 관리
- `path`: 데이터베이스 경로 관리
- `intl`: 날짜 포맷팅 (선택사항)

```yaml
dependencies:
  sqflite: ^2.3.0
  path: ^1.8.3
  intl: ^0.18.1
```

### 1.2 데이터베이스 스키마 설계

#### exchange_rates 테이블
| 컬럼명 | 타입 | 설명 |
|--------|------|------|
| id | INTEGER PRIMARY KEY | 자동 증가 ID |
| base_currency | TEXT | 기준 통화 (USD, EUR 등) |
| rates_json | TEXT | 환율 정보 JSON 문자열 |
| last_updated | TEXT | 마지막 업데이트 시간 (ISO 8601) |
| created_at | TEXT | 레코드 생성 시간 |

#### metadata 테이블
| 컬럼명 | 타입 | 설명 |
|--------|------|------|
| key | TEXT PRIMARY KEY | 메타데이터 키 |
| value | TEXT | 메타데이터 값 |
| updated_at | TEXT | 업데이트 시간 |

### 1.3 DatabaseHelper 클래스 구조
```dart
class DatabaseHelper {
  // 싱글톤 패턴
  // DB 초기화
  // 테이블 생성
  // CRUD 메서드
}
```

## Phase 2: 데이터 모델 업데이트

### 2.1 ExchangeRate 모델 확장
- `lastUpdated` DateTime 필드 추가
- `isFromCache` bool 필드 추가
- `toMap()` 메서드: 모델을 Map으로 변환 (DB 저장용)
- `fromMap()` 팩토리 생성자: Map에서 모델 생성 (DB 조회용)

### 2.2 캐시 유효성 검증 로직
- 24시간(86400초) 경과 여부 체크
- 강제 업데이트 플래그 처리
- 네트워크 상태 확인

## Phase 3: Service 레이어 수정

### 3.1 ExchangeRateService 리팩토링
```dart
Future<ExchangeRate> getExchangeRates(String baseCurrency, {bool forceRefresh = false}) {
  // 1. forceRefresh가 false면 로컬 DB 우선 조회
  // 2. 캐시 유효성 검증 (24시간 이내)
  // 3. 캐시 미스 또는 만료 시 API 호출
  // 4. API 응답을 DB에 저장
  // 5. 데이터 반환
}
```

### 3.2 CacheService 생성
- 캐시 유효성 검증 메서드
- 자동 갱신 스케줄링
- 오래된 데이터 정리

## Phase 4: Provider 업데이트

### 4.1 ExchangeRateProvider 수정
- `isDataFromCache` bool 게터 추가
- `lastSyncTime` DateTime 게터 추가
- `forceRefreshRates()` 메서드: 강제 새로고침
- `getDataSource()` 메서드: 데이터 출처 반환 ("캐시" / "실시간")

### 4.2 상태 관리 개선
- 로딩 상태 세분화 (캐시 로딩 / 네트워크 로딩)
- 에러 처리 개선 (캐시 실패 / 네트워크 실패)

## Phase 5: UI 구현

### 5.1 Settings 화면 업데이트
```dart
ListTile(
  leading: Icon(Icons.refresh),
  title: Text('환율 데이터 새로고침'),
  subtitle: Text('마지막 업데이트: ${formatDateTime(lastSyncTime)}'),
  trailing: isLoading ? CircularProgressIndicator() : Icon(Icons.arrow_forward),
  onTap: () => _refreshExchangeRates(),
)
```

### 5.2 홈 화면 인디케이터
- 상단에 데이터 출처 표시 배너
- 캐시 데이터 사용 시 노란색 배경
- 실시간 데이터 사용 시 초록색 배경

## Phase 6: 백그라운드 처리

### 6.1 자동 업데이트 로직
- 앱 시작 시 마지막 업데이트 시간 체크
- 24시간 경과 시 백그라운드 업데이트
- 사용자 작업 방해하지 않도록 조용히 처리

### 6.2 오프라인 지원
- 네트워크 연결 상태 모니터링
- 오프라인 시 캐시 데이터만 사용
- 온라인 복귀 시 자동 동기화

## Phase 7: 테스트 및 최적화

### 7.1 테스트 시나리오
- DB 생성 및 마이그레이션 테스트
- 캐시 유효성 검증 테스트
- 강제 새로고침 테스트
- 오프라인 모드 테스트

### 7.2 성능 최적화
- DB 인덱스 추가
- 쿼리 최적화
- 메모리 캐싱 레이어 추가 (선택사항)

## 구현 우선순위

1. **필수 구현** (Phase 1-3)
   - 데이터베이스 설정
   - 기본 캐싱 로직
   - Service 레이어 수정

2. **핵심 기능** (Phase 4-5)
   - Provider 업데이트
   - UI 새로고침 버튼

3. **개선 사항** (Phase 6-7)
   - 백그라운드 처리
   - 테스트 및 최적화

## 예상 소요 시간
- Phase 1-3: 2-3시간
- Phase 4-5: 1-2시간
- Phase 6-7: 2-3시간
- 전체: 약 5-8시간

## 주의사항
1. 기존 코드와의 호환성 유지
2. 마이그레이션 경로 고려
3. 에러 처리 강화
4. 사용자 경험 저하 방지