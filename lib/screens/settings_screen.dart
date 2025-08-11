import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
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
          // 환율 데이터 새로고침 섹션
          Consumer<ExchangeRateProvider>(
            builder: (context, provider, child) {
              final lastSync = provider.lastSyncTime;
              String lastSyncText = '데이터 없음';
              
              if (lastSync != null) {
                final now = DateTime.now();
                final difference = now.difference(lastSync);
                
                if (difference.inMinutes < 1) {
                  lastSyncText = '방금 전';
                } else if (difference.inHours < 1) {
                  lastSyncText = '${difference.inMinutes}분 전';
                } else if (difference.inHours < 24) {
                  lastSyncText = '${difference.inHours}시간 전';
                } else {
                  lastSyncText = DateFormat('MM월 dd일 HH:mm').format(lastSync);
                }
              }
              
              return Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.sync, color: Theme.of(context).colorScheme.primary),
                    title: Text('환율 데이터 새로고침'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('마지막 업데이트: $lastSyncText'),
                        if (provider.isFromCache)
                          Container(
                            margin: EdgeInsets.only(top: 4),
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.orange[100],
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              '캐시 데이터 사용 중',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.orange[800],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                      ],
                    ),
                    trailing: provider.isLoading
                        ? SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : IconButton(
                            icon: Icon(Icons.refresh, color: Theme.of(context).colorScheme.primary),
                            onPressed: () async {
                              // 강제 새로고침
                              await provider.forceRefreshRates();
                              
                              // 성공 메시지 표시
                              if (!provider.hasError) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('환율 데이터가 업데이트되었습니다'),
                                    backgroundColor: Colors.green,
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(provider.errorMessage ?? '업데이트 실패'),
                                    backgroundColor: Colors.red,
                                    duration: Duration(seconds: 3),
                                  ),
                                );
                              }
                            },
                          ),
                  ),
                  if (provider.isFromCache)
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.blue[200]!),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.info_outline, size: 20, color: Colors.blue[700]),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              '오프라인 모드: 저장된 환율 데이터를 사용 중입니다',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.blue[700],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.delete_sweep, color: Colors.red),
            title: Text('캐시 데이터 삭제'),
            subtitle: Text('저장된 모든 환율 데이터를 삭제합니다'),
            onTap: () async {
              // 확인 다이얼로그 표시
              final confirmed = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('캐시 삭제'),
                  content: Text('저장된 모든 환율 데이터를 삭제하시겠습니까?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: Text('취소'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: Text('삭제', style: TextStyle(color: Colors.red)),
                    ),
                  ],
                ),
              );
              
              if (confirmed == true) {
                final provider = context.read<ExchangeRateProvider>();
                await provider.cleanCache();
                
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('캐시가 삭제되었습니다'),
                    duration: Duration(seconds: 2),
                  ),
                );
              }
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
