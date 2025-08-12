import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigService {
  static final RemoteConfigService _instance = RemoteConfigService._internal();
  factory RemoteConfigService() => _instance;
  RemoteConfigService._internal();

  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;

  // Remote Config Keys
  static const String keyMinimumVersion = 'minimum_version';
  static const String keyLatestVersion = 'latest_version';
  static const String keyForceUpdate = 'force_update';
  static const String keyUpdateMessage = 'update_message';
  static const String keyUpdateUrlAndroid = 'update_url_android';
  static const String keyUpdateUrlIos = 'update_url_ios';
  static const String keyMaintenanceMode = 'maintenance_mode';
  static const String keyMaintenanceMessage = 'maintenance_message';

  // 기본값 설정
  final Map<String, dynamic> _defaults = {
    keyMinimumVersion: '1.0.0',
    keyLatestVersion: '1.0.0',
    keyForceUpdate: false,
    keyUpdateMessage: '새로운 버전이 출시되었습니다. 업데이트하시겠습니까?',
    keyUpdateUrlAndroid: 'https://play.google.com/store/apps/details?id=com.accu.exchange_rate',
    keyUpdateUrlIos: 'https://apps.apple.com/app/id123456789',
    keyMaintenanceMode: false,
    keyMaintenanceMessage: '서버 점검 중입니다. 잠시 후 다시 시도해주세요.',
  };

  // Remote Config 초기화
  Future<void> initialize() async {
    try {
      // 기본값 설정
      await _remoteConfig.setDefaults(_defaults);

      // 설정값 적용
      await _remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: const Duration(hours: 1), // 프로덕션에서는 1시간, 테스트 시에는 Duration.zero
      ));

      // 최신 값 가져오기 및 활성화
      await fetchAndActivate();
    } catch (e) {
      print('RemoteConfig 초기화 실패: $e');
    }
  }

  // 최신 값 가져오기 및 활성화
  Future<bool> fetchAndActivate() async {
    try {
      final bool updated = await _remoteConfig.fetchAndActivate();
      return updated;
    } catch (e) {
      print('RemoteConfig fetch 실패: $e');
      return false;
    }
  }

  // Getter 메서드들
  String get minimumVersion => _remoteConfig.getString(keyMinimumVersion);
  String get latestVersion => _remoteConfig.getString(keyLatestVersion);
  bool get forceUpdate => _remoteConfig.getBool(keyForceUpdate);
  String get updateMessage => _remoteConfig.getString(keyUpdateMessage);
  String get updateUrlAndroid => _remoteConfig.getString(keyUpdateUrlAndroid);
  String get updateUrlIos => _remoteConfig.getString(keyUpdateUrlIos);
  bool get maintenanceMode => _remoteConfig.getBool(keyMaintenanceMode);
  String get maintenanceMessage => _remoteConfig.getString(keyMaintenanceMessage);

  // 실시간 업데이트 리스너 설정
  void addConfigUpdateListener(Function() onConfigUpdated) {
    _remoteConfig.onConfigUpdated.listen((event) async {
      await _remoteConfig.activate();
      onConfigUpdated();
    });
  }
}