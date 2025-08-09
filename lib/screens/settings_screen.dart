import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../providers/exchange_rate_provider.dart';
import 'currency_selection_screen.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('설정'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        elevation: 0,
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return ListTile(
                leading: Icon(
                  themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: Text('다크모드'),
                subtitle: Text(themeProvider.isDarkMode ? '다크모드가 활성화되었습니다' : '라이트모드가 활성화되었습니다'),
                trailing: Switch(
                  value: themeProvider.isDarkMode,
                  onChanged: (value) {
                    themeProvider.toggleTheme();
                  },
                ),
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.notifications, color: Theme.of(context).colorScheme.primary),
            title: Text('알림 설정'),
            subtitle: Text('환율 변동 알림을 받습니다'),
            trailing: Switch(
              value: true,
              onChanged: (value) {
                // TODO: 알림 설정 구현
              },
            ),
          ),
          ListTile(
            leading: Icon(Icons.refresh, color: Theme.of(context).colorScheme.primary),
            title: Text('자동 새로고침'),
            subtitle: Text('5분마다 환율을 자동으로 업데이트합니다'),
            trailing: Switch(
              value: false,
              onChanged: (value) {
                // TODO: 자동 새로고침 설정 구현
              },
            ),
          ),
          Consumer<ExchangeRateProvider>(
            builder: (context, provider, child) {
              return ListTile(
                leading: Icon(Icons.star, color: Theme.of(context).colorScheme.primary),
                title: Text('즐겨찾기 통화'),
                subtitle: Text('현재 ${provider.favoriteCurrencies.length}개 통화가 즐겨찾기에 저장되어 있습니다'),
                trailing: Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CurrencySelectionScreen(
                        currentCurrency: 'USD', // 기본값으로 USD 사용
                        onCurrencySelected: (selectedCurrency) {
                          // 이 콜백은 설정에서 접근할 때는 사용되지 않음
                        },
                        isFromSettings: true, // 설정에서 접근함을 표시
                      ),
                    ),
                  );
                },
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.info, color: Theme.of(context).colorScheme.primary),
            title: Text('앱 정보'),
            subtitle: Text('버전 1.0.0'),
            onTap: () {
              // TODO: 앱 정보 화면으로 이동
            },
          ),
        ],
      ),
    );
  }
}
