import 'dart:io';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'remote_config_service.dart';

enum UpdateType {
  none,           // 업데이트 불필요
  optional,       // 선택적 업데이트
  required,       // 강제 업데이트
  maintenance,    // 서버 점검
}

class AppUpdateService {
  static final AppUpdateService _instance = AppUpdateService._internal();
  factory AppUpdateService() => _instance;
  AppUpdateService._internal();

  final RemoteConfigService _remoteConfig = RemoteConfigService();
  PackageInfo? _packageInfo;
  
  // 업데이트 체크 상태
  UpdateType _updateType = UpdateType.none;
  String _currentVersion = '';
  String _latestVersion = '';
  String _minimumVersion = '';
  
  // 초기화
  Future<void> initialize() async {
    try {
      // Remote Config 초기화
      await _remoteConfig.initialize();
      
      // 패키지 정보 가져오기
      _packageInfo = await PackageInfo.fromPlatform();
      _currentVersion = _packageInfo?.version ?? '1.0.0';
      
      // 실시간 업데이트 리스너 설정
      _remoteConfig.addConfigUpdateListener(() {
        checkForUpdate();
      });
    } catch (e) {
      print('AppUpdateService 초기화 실패: $e');
    }
  }
  
  // 업데이트 체크
  Future<UpdateType> checkForUpdate() async {
    try {
      // 최신 Remote Config 값 가져오기
      await _remoteConfig.fetchAndActivate();
      
      // 서버 점검 모드 확인
      if (_remoteConfig.maintenanceMode) {
        _updateType = UpdateType.maintenance;
        return _updateType;
      }
      
      _latestVersion = _remoteConfig.latestVersion;
      _minimumVersion = _remoteConfig.minimumVersion;
      
      // 버전 비교
      final currentVersionParts = _parseVersion(_currentVersion);
      final latestVersionParts = _parseVersion(_latestVersion);
      final minimumVersionParts = _parseVersion(_minimumVersion);
      
      // 최소 버전보다 낮은 경우 - 강제 업데이트
      if (_compareVersions(currentVersionParts, minimumVersionParts) < 0) {
        _updateType = UpdateType.required;
      }
      // 최신 버전보다 낮은 경우 - 선택적 업데이트
      else if (_compareVersions(currentVersionParts, latestVersionParts) < 0) {
        _updateType = _remoteConfig.forceUpdate ? UpdateType.required : UpdateType.optional;
      }
      // 업데이트 불필요
      else {
        _updateType = UpdateType.none;
      }
      
      return _updateType;
    } catch (e) {
      print('업데이트 체크 실패: $e');
      return UpdateType.none;
    }
  }
  
  // 버전 문자열을 숫자 배열로 파싱
  List<int> _parseVersion(String version) {
    try {
      return version.split('.').map((e) => int.parse(e)).toList();
    } catch (e) {
      return [0, 0, 0];
    }
  }
  
  // 버전 비교 (-1: v1 < v2, 0: v1 == v2, 1: v1 > v2)
  int _compareVersions(List<int> v1, List<int> v2) {
    final maxLength = v1.length > v2.length ? v1.length : v2.length;
    
    for (int i = 0; i < maxLength; i++) {
      final num1 = i < v1.length ? v1[i] : 0;
      final num2 = i < v2.length ? v2[i] : 0;
      
      if (num1 < num2) return -1;
      if (num1 > num2) return 1;
    }
    
    return 0;
  }
  
  // 스토어로 이동
  Future<void> navigateToStore() async {
    final String url = Platform.isAndroid 
        ? _remoteConfig.updateUrlAndroid 
        : _remoteConfig.updateUrlIos;
    
    try {
      final Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
      } else {
        print('URL을 열 수 없습니다: $url');
      }
    } catch (e) {
      print('스토어 이동 실패: $e');
    }
  }
  
  // 업데이트 다이얼로그 표시 여부 결정
  bool shouldShowUpdateDialog() {
    return _updateType == UpdateType.optional || 
           _updateType == UpdateType.required ||
           _updateType == UpdateType.maintenance;
  }
  
  // Getter 메서드들
  UpdateType get updateType => _updateType;
  String get currentVersion => _currentVersion;
  String get latestVersion => _latestVersion;
  String get minimumVersion => _minimumVersion;
  String get updateMessage => _remoteConfig.updateMessage;
  String get maintenanceMessage => _remoteConfig.maintenanceMessage;
  bool get isForceUpdate => _updateType == UpdateType.required;
  bool get isMaintenanceMode => _updateType == UpdateType.maintenance;
}