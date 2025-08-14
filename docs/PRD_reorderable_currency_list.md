# 📋 PRD: 통화 목록 순서 변경 기능

## 1. 개요
- **제품명**: 환율 변환기 - 통화 목록 재정렬 기능
- **버전**: 1.0.0
- **작성일**: 2025-08-14
- **작성자**: Claude Code Assistant

## 2. 목적 및 배경

### 2.1 현재 상황
- 통화 목록이 고정된 순서로만 표시됨
- 사용자가 목록 순서를 변경할 수 없음
- 자주 사용하는 통화에 빠르게 접근하기 어려움

### 2.2 문제점
- 사용자별 선호 통화가 다름에도 불구하고 일괄적인 순서 적용
- 스크롤을 통해서만 원하는 통화에 접근 가능
- 개인화된 사용 경험 부족

### 2.3 목표
- 사용자 맞춤형 통화 순서 설정으로 사용성 향상
- 자주 사용하는 통화에 대한 빠른 접근성 제공
- 직관적인 드래그 앤 드롭 인터페이스 구현

## 3. 사용자 스토리

```
AS A 환율 앱 사용자
I WANT TO 통화 목록의 순서를 내 선호도에 맞게 조정하고 싶다
SO THAT 자주 사용하는 통화에 빠르게 접근할 수 있다
```

### 3.1 세부 시나리오
1. **비즈니스 출장자**: USD, EUR, JPY를 상단에 배치
2. **동남아 여행자**: THB, VND, SGD를 우선 배치
3. **무역 종사자**: 거래국 통화를 우선순위로 정렬

## 4. 기능 요구사항

### 4.1 핵심 기능
| 기능 | 설명 | 우선순위 |
|-----|------|---------|
| 드래그 앤 드롭 | 길게 누르고 드래그하여 통화 위치 변경 | P0 |
| 실시간 피드백 | 드래그 중 시각적/촉각적 피드백 제공 | P0 |
| 자동 저장 | 순서 변경 즉시 자동 저장 | P0 |
| 지속성 | 앱 재시작 후에도 순서 유지 | P0 |
| 순서 초기화 | 기본 순서로 되돌리기 (향후) | P2 |

### 4.2 상세 동작 명세

#### 4.2.1 드래그 시작
- **트리거**: 통화 항목 길게 누르기 (500ms)
- **피드백**: 
  - 햅틱 피드백 (진동)
  - 항목 크기 105%로 확대
  - 그림자 효과 추가
  - 배경색 약간 어둡게 변경

#### 4.2.2 드래그 중
- **시각적 표시**:
  - 선택된 항목 투명도 90%
  - 이동 가능 위치에 placeholder 표시
  - 다른 항목들 자동으로 위치 조정 (애니메이션)
- **스크롤**: 화면 상/하단 근처 드래그 시 자동 스크롤

#### 4.2.3 드래그 완료
- **동작**:
  - 새 위치에 통화 배치
  - 순서 즉시 저장 (SharedPreferences)
  - 완료 애니메이션 (200ms)
- **피드백**: 가벼운 햅틱 피드백

## 5. UI/UX 디자인

### 5.1 시각적 요소

#### 기본 상태
```
┌────────────────────────────┐
│ 🇺🇸 USD                    │
│ 미국 달러                   │
│ $100.00                    │
├────────────────────────────┤
│ 🇪🇺 EUR                    │
│ 유로                       │
│ €85.40                     │
├────────────────────────────┤
│ 🇯🇵 JPY                    │
│ 일본 엔                     │
│ ¥14,731                    │
└────────────────────────────┘
```

#### 드래그 상태
```
┌────────────────────────────┐
│ [드래그 중인 항목 - 강조]    │ <- 그림자 효과
├────────────────────────────┤
│ · · · · · · · · · · · · · ·│ <- Placeholder
├────────────────────────────┤
│ 🇪🇺 EUR                    │
│ 유로                       │
│ €85.40                     │
└────────────────────────────┘
```

### 5.2 인터랙션 가이드라인
- **드래그 핸들**: 별도 핸들 없이 전체 영역 드래그 가능
- **최소 이동 거리**: 10dp 이상 이동 시 드래그 모드 활성화
- **취소**: 원래 위치로 되돌리려면 ESC 키 또는 백 제스처

### 5.3 애니메이션
- **드래그 시작**: Scale 1.0 → 1.05 (100ms, easeOut)
- **항목 이동**: Transform translate (200ms, easeInOut)
- **드래그 종료**: Scale 1.05 → 1.0 (100ms, easeIn)

## 6. 기술 구현 방안

### 6.1 Flutter 구현 아키텍처

```dart
// main.dart - ReorderableListView 구현
ReorderableListView.builder(
  onReorder: (int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final String item = currencies.removeAt(oldIndex);
      currencies.insert(newIndex, item);
      provider.reorderCurrencies(currencies);
    });
  },
  itemCount: currencies.length,
  itemBuilder: (context, index) {
    return Card(
      key: ValueKey(currencies[index]),
      child: ListTile(
        leading: CountryFlag(currencies[index]),
        title: Text(getCurrencyName(currencies[index])),
        subtitle: Text(getConvertedAmount(currencies[index])),
        trailing: ReorderableDragStartListener(
          index: index,
          child: Icon(Icons.drag_handle),
        ),
      ),
    );
  },
)
```

### 6.2 상태 관리 (Provider)

```dart
// exchange_rate_provider.dart
class ExchangeRateProvider {
  // 통화 순서 변경
  Future<void> reorderCurrencies(List<String> newOrder) async {
    _currencies = newOrder;
    await _saveCurrencyOrder();
    notifyListeners();
  }
  
  // SharedPreferences에 순서 저장
  Future<void> _saveCurrencyOrder() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('currency_order', _currencies);
  }
  
  // 저장된 순서 불러오기
  Future<void> _loadCurrencyOrder() async {
    final prefs = await SharedPreferences.getInstance();
    final savedOrder = prefs.getStringList('currency_order');
    if (savedOrder != null) {
      _currencies = savedOrder;
    }
  }
}
```

### 6.3 데이터 저장 구조

```json
{
  "currency_order": ["USD", "KRW", "EUR", "JPY", "GBP"],
  "last_modified": "2025-08-14T10:30:00Z",
  "version": "1.0.0"
}
```

## 7. 제약사항 및 고려사항

### 7.1 기술적 제약
- **최소 통화 수**: 최소 1개 이상 유지 필수
- **최대 통화 수**: 성능 고려하여 30개로 제한
- **드래그 응답성**: 60fps 유지 (16.67ms/frame)

### 7.2 플랫폼별 고려사항
- **iOS**: 네이티브 드래그 제스처와 충돌 방지
- **Android**: Material Design 가이드라인 준수
- **태블릿**: 큰 화면에서도 적절한 드래그 영역

### 7.3 접근성
- **스크린 리더**: 순서 변경 동작 음성 안내
- **키보드 네비게이션**: 방향키로 순서 변경 가능
- **색맹 사용자**: 색상에만 의존하지 않는 피드백

## 8. 성공 지표 (KPI)

| 지표 | 목표값 | 측정 방법 |
|-----|--------|----------|
| 드래그 응답 시간 | < 100ms | Performance monitoring |
| 순서 저장 성공률 | > 99.9% | Error tracking |
| 기능 사용률 | > 30% (MAU) | Analytics |
| 사용자 만족도 | > 4.5/5.0 | In-app survey |

## 9. 테스트 계획

### 9.1 기능 테스트
- [ ] 단일 항목 드래그 앤 드롭
- [ ] 여러 항목 연속 재정렬
- [ ] 스크롤 영역에서 드래그
- [ ] 앱 재시작 후 순서 유지
- [ ] 통화 추가/삭제 후 순서 유지

### 9.2 엣지 케이스
- [ ] 1개 항목만 있을 때
- [ ] 30개 항목 있을 때
- [ ] 네트워크 오류 시 순서 저장
- [ ] 저장 공간 부족 시

### 9.3 성능 테스트
- [ ] 30개 항목 드래그 시 프레임 드롭
- [ ] 메모리 사용량 모니터링
- [ ] 배터리 소모량 측정

## 10. 향후 개선사항 (Phase 2)

1. **스마트 정렬**
   - 사용 빈도 기반 자동 정렬
   - 최근 사용 통화 상단 배치 옵션

2. **그룹화 기능**
   - 즐겨찾기 그룹
   - 지역별 그룹 (아시아, 유럽, 미주 등)

3. **백업 및 복원**
   - 클라우드 동기화
   - 설정 내보내기/가져오기

4. **고급 제스처**
   - 스와이프로 빠른 순서 변경
   - 멀티 선택 후 일괄 이동

## 11. 개발 일정

| 단계 | 작업 내용 | 예상 시간 | 담당 |
|-----|----------|----------|------|
| Phase 1 | 현재 코드 분석 및 설계 | 30분 | Dev |
| Phase 2 | ReorderableListView 기본 구현 | 2시간 | Dev |
| Phase 3 | 상태 저장 및 복원 | 1시간 | Dev |
| Phase 4 | UI/UX 개선 및 애니메이션 | 1시간 | Dev |
| Phase 5 | 테스트 및 버그 수정 | 1시간 | QA |
| Phase 6 | 문서화 및 배포 | 30분 | Dev |

**총 예상 시간**: 6시간

## 12. 참고 자료
- [Flutter ReorderableListView Documentation](https://api.flutter.dev/flutter/material/ReorderableListView-class.html)
- [Material Design - Lists](https://material.io/components/lists)
- [iOS Human Interface Guidelines - Lists](https://developer.apple.com/design/human-interface-guidelines/lists)

---

**문서 버전 이력**
- v1.0.0 (2025-08-14): 초기 작성