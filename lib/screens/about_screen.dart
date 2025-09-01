import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'dart:io' show Platform;
import '../providers/theme_provider.dart';

class AboutScreen extends StatefulWidget {
  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  String appVersion = '로딩 중...';
  String buildNumber = '로딩 중...';
  String flutterVersion = '';
  String dartVersion = '';
  String platformInfo = '';

  @override
  void initState() {
    super.initState();
    _loadAppInfo();
  }

  Future<void> _loadAppInfo() async {
    try {
      // 앱 버전 정보 가져오기
      final PackageInfo packageInfo = await PackageInfo.fromPlatform();
      
      // Flutter 및 Dart 버전 정보
      const flutterVer = String.fromEnvironment('flutter.version', defaultValue: '3.32.8');
      const dartVer = String.fromEnvironment('dart.version', defaultValue: '3.8.1');
      
      // 플랫폼 정보 동적으로 구성
      List<String> platforms = [];
      if (!kIsWeb) {
        if (Platform.isAndroid) platforms.add('Android');
        if (Platform.isIOS) platforms.add('iOS');
        if (Platform.isWindows) platforms.add('Windows');
        if (Platform.isMacOS) platforms.add('macOS');
        if (Platform.isLinux) platforms.add('Linux');
      } else {
        platforms.add('Web');
      }
      
      setState(() {
        appVersion = packageInfo.version;
        buildNumber = packageInfo.buildNumber;
        flutterVersion = flutterVer.isEmpty ? '3.32.8' : flutterVer;
        dartVersion = dartVer.isEmpty ? '3.8.1' : dartVer;
        platformInfo = platforms.isEmpty ? 'Android, iOS' : platforms.join(', ');
      });
    } catch (e) {
      print('Error loading app info: $e');
      setState(() {
        appVersion = '1.0.4';
        buildNumber = '5';
        flutterVersion = '3.32.8';
        dartVersion = '3.8.1';
        platformInfo = 'Android, iOS';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('개발자 정보'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        bottom: true,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
          children: [
            // 앱 아이콘 및 정보
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(Icons.currency_exchange, size: 60, color: Theme.of(context).colorScheme.onPrimaryContainer),
            ),
            SizedBox(height: 24),

            Text(
              '환율 변환기',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 8),

            Text('버전 $appVersion', style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.onSurfaceVariant)),
            SizedBox(height: 32),

            // 개발자 정보
            _buildInfoCard(context, '개발자', 'Flutter 개발자', Icons.person),
            SizedBox(height: 16),

            _buildInfoCard(context, '연락처', 'augustkim.dev@gmail.com', Icons.email),
            SizedBox(height: 16),

            _buildInfoCard(context, '웹사이트', 'https://www.accu86.com', Icons.language),
            SizedBox(height: 32),

            // 앱 정보
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Theme.of(context).colorScheme.outline.withOpacity(0.2)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '앱 정보',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  SizedBox(height: 16),

                  _buildInfoRow(context, '빌드 번호', buildNumber),
                  _buildInfoRow(context, 'Flutter 버전', flutterVersion),
                  _buildInfoRow(context, 'Dart 버전', dartVersion),
                  _buildInfoRow(context, '플랫폼', platformInfo),
                ],
              ),
            ),
            SizedBox(height: 24),

            // 라이선스 정보
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Theme.of(context).colorScheme.outline.withOpacity(0.2)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '라이선스',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '이 앱은 MIT 라이선스 하에 배포됩니다.',
                    style: TextStyle(fontSize: 14, color: Theme.of(context).colorScheme.onSurfaceVariant),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),

            // 감사 인사
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Icon(Icons.favorite, color: Theme.of(context).colorScheme.primary, size: 32),
                  SizedBox(height: 8),
                  Text(
                    '감사합니다!',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '환율 변환기를 사용해주셔서 감사합니다.\n더 나은 서비스를 위해 계속 노력하겠습니다.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Theme.of(context).colorScheme.onSurfaceVariant),
                  ),
                ],
              ),
            ),
          ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context, String title, String value, IconData icon) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Theme.of(context).colorScheme.outline.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.primary, size: 24),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontSize: 14, color: Theme.of(context).colorScheme.onSurfaceVariant)),
                SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 14, color: Theme.of(context).colorScheme.onSurfaceVariant)),
          Text(
            value,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.onSurface),
          ),
        ],
      ),
    );
  }
}
