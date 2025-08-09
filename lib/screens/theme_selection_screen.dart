import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/onboarding_provider.dart';

class ThemeSelectionScreen extends StatefulWidget {
  @override
  _ThemeSelectionScreenState createState() => _ThemeSelectionScreenState();
}

class _ThemeSelectionScreenState extends State<ThemeSelectionScreen> {
  ThemeMode _selectedTheme = ThemeMode.system;

  @override
  void initState() {
    super.initState();
    // Provider에서 기존 설정 로드
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<OnboardingProvider>();
      setState(() {
        _selectedTheme = provider.themeMode;
      });
    });
  }

  void _selectTheme(ThemeMode theme) {
    setState(() {
      _selectedTheme = theme;
    });
    context.read<OnboardingProvider>().setThemeMode(theme);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40),

              // 제목
              Text(
                '테마 설정',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              SizedBox(height: 8),
              Text(
                '앱의 외관을 선택해주세요.\n나중에 설정에서 변경할 수 있습니다.',
                style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                  height: 1.4,
                ),
              ),

              SizedBox(height: 40),

              // 테마 선택 옵션들
              Column(
                children: [
                  // 시스템 설정
                  _buildThemeOption(
                    context,
                    ThemeMode.system,
                    '시스템 설정',
                    '기기의 테마 설정을 따릅니다',
                    Icons.settings_system_daydream,
                  ),

                  SizedBox(height: 16),

                  // 라이트 테마
                  _buildThemeOption(context, ThemeMode.light, '라이트 테마', '밝고 깔끔한 화면', Icons.light_mode),

                  SizedBox(height: 16),

                  // 다크 테마
                  _buildThemeOption(context, ThemeMode.dark, '다크 테마', '어두운 화면으로 눈의 피로를 줄입니다', Icons.dark_mode),
                ],
              ),

              SizedBox(height: 40),

              // 미리보기 섹션
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Theme.of(context).colorScheme.outline.withOpacity(0.2)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '미리보기',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    SizedBox(height: 16),

                    // 미리보기 카드
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: _getPreviewBackgroundColor(),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: _getPreviewBorderColor()),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: _getPreviewPrimaryColor(),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Icon(Icons.currency_exchange, color: _getPreviewOnPrimaryColor(), size: 20),
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '환율 변환기',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: _getPreviewTextColor(),
                                      ),
                                    ),
                                    Text(
                                      '실시간 환율 정보',
                                      style: TextStyle(fontSize: 14, color: _getPreviewSecondaryTextColor()),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),

                          // 환율 아이템 미리보기
                          Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: _getPreviewSurfaceColor(),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: _getPreviewOutlineColor()),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 24,
                                  height: 16,
                                  decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(2)),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'USD',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: _getPreviewTextColor(),
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  '1,350.00',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: _getPreviewPrimaryColor(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24),

              // 설명 텍스트
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: Theme.of(context).colorScheme.primary, size: 20),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        '테마는 앱의 전체적인 외관에 영향을 줍니다. 언제든지 설정에서 변경할 수 있습니다.',
                        style: TextStyle(fontSize: 14, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7)),
                      ),
                    ),
                  ],
                ),
              ),

              // 하단 여백 추가
              SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildThemeOption(BuildContext context, ThemeMode theme, String title, String subtitle, IconData icon) {
    final isSelected = _selectedTheme == theme;

    return GestureDetector(
      onTap: () => _selectTheme(theme),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected ? Theme.of(context).colorScheme.primaryContainer : Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.outline.withOpacity(0.2),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: isSelected ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: isSelected
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.outline.withOpacity(0.3),
                ),
              ),
              child: Icon(
                icon,
                color: isSelected ? Theme.of(context).colorScheme.onPrimary : Theme.of(context).colorScheme.onSurface,
                size: 24,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isSelected
                          ? Theme.of(context).colorScheme.onPrimaryContainer
                          : Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: isSelected
                          ? Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.7)
                          : Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected) Icon(Icons.check_circle, color: Theme.of(context).colorScheme.primary, size: 24),
          ],
        ),
      ),
    );
  }

  // 미리보기용 색상들
  Color _getPreviewBackgroundColor() {
    switch (_selectedTheme) {
      case ThemeMode.light:
        return Colors.white;
      case ThemeMode.dark:
        return Colors.grey[900]!;
      case ThemeMode.system:
        return Theme.of(context).brightness == Brightness.light ? Colors.white : Colors.grey[900]!;
    }
  }

  Color _getPreviewBorderColor() {
    switch (_selectedTheme) {
      case ThemeMode.light:
        return Colors.grey[300]!;
      case ThemeMode.dark:
        return Colors.grey[700]!;
      case ThemeMode.system:
        return Theme.of(context).brightness == Brightness.light ? Colors.grey[300]! : Colors.grey[700]!;
    }
  }

  Color _getPreviewPrimaryColor() {
    return Theme.of(context).colorScheme.primary;
  }

  Color _getPreviewOnPrimaryColor() {
    return Theme.of(context).colorScheme.onPrimary;
  }

  Color _getPreviewTextColor() {
    switch (_selectedTheme) {
      case ThemeMode.light:
        return Colors.black87;
      case ThemeMode.dark:
        return Colors.white;
      case ThemeMode.system:
        return Theme.of(context).brightness == Brightness.light ? Colors.black87 : Colors.white;
    }
  }

  Color _getPreviewSecondaryTextColor() {
    switch (_selectedTheme) {
      case ThemeMode.light:
        return Colors.black54;
      case ThemeMode.dark:
        return Colors.white70;
      case ThemeMode.system:
        return Theme.of(context).brightness == Brightness.light ? Colors.black54 : Colors.white70;
    }
  }

  Color _getPreviewSurfaceColor() {
    switch (_selectedTheme) {
      case ThemeMode.light:
        return Colors.grey[50]!;
      case ThemeMode.dark:
        return Colors.grey[800]!;
      case ThemeMode.system:
        return Theme.of(context).brightness == Brightness.light ? Colors.grey[50]! : Colors.grey[800]!;
    }
  }

  Color _getPreviewOutlineColor() {
    switch (_selectedTheme) {
      case ThemeMode.light:
        return Colors.grey[200]!;
      case ThemeMode.dark:
        return Colors.grey[600]!;
      case ThemeMode.system:
        return Theme.of(context).brightness == Brightness.light ? Colors.grey[200]! : Colors.grey[600]!;
    }
  }
}
