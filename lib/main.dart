import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'providers/exchange_rate_provider.dart';
import 'providers/theme_provider.dart';
import 'providers/onboarding_provider.dart';
import 'providers/localization_provider.dart';
import 'screens/currency_selection_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/language_screen.dart';
import 'screens/feedback_screen.dart';
import 'screens/about_screen.dart';
import 'screens/onboarding_screen.dart';
import 'utils/currency_utils.dart';
import 'package:country_flags/country_flags.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ExchangeRateProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => OnboardingProvider()),
        ChangeNotifierProvider(create: (context) => LocalizationProvider()),
      ],
      child: Consumer3<ThemeProvider, OnboardingProvider, LocalizationProvider>(
        builder: (context, themeProvider, onboardingProvider, localizationProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: themeProvider.currentTheme,
            locale: localizationProvider.currentLocale,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: LocalizationProvider.supportedLocales,
            onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
            home: onboardingProvider.isOnboardingCompleted ? HomeScreen() : OnboardingScreen(),
          );
        },
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final exchangeProvider = context.read<ExchangeRateProvider>();
      final onboardingProvider = context.read<OnboardingProvider>();

      // 온보딩에서 설정한 기본 통화 목록 로드
      exchangeProvider.loadDefaultCurrencies(onboardingProvider.defaultCurrencies);

      // 온보딩에서 설정한 홈 통화로 기본 통화 설정
      if (onboardingProvider.homeCurrency.isNotEmpty) {
        exchangeProvider.setBaseCurrency(onboardingProvider.homeCurrency);
      }

      exchangeProvider.fetchExchangeRates();
      exchangeProvider.loadFavorites();
      exchangeProvider.loadLastSyncTime();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.appTitle),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        elevation: 0,
        centerTitle: true,
      ),
      drawer: _buildDrawer(context),
      body: Consumer<ExchangeRateProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          return Column(
            children: [
              // 캐시 상태 인디케이터 - 만료된 캐시를 사용 중일 때만 표시
              if (provider.shouldShowOfflineMode && !provider.hasError)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  color: Colors.amber[50],
                  child: Row(
                    children: [
                      Icon(Icons.offline_bolt, size: 16, color: Colors.amber[700]),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          AppLocalizations.of(context)!.offlineMode,
                          style: TextStyle(fontSize: 12, color: Colors.amber[700]),
                        ),
                      ),
                      TextButton(
                        onPressed: () => provider.forceRefreshRates(),
                        child: Text(AppLocalizations.of(context)!.refresh, style: TextStyle(fontSize: 12)),
                      ),
                    ],
                  ),
                ),
              // 에러 메시지 표시
              if (provider.hasError) _buildErrorWidget(provider),
              // 환율 데이터 로딩 상태 표시
              if (provider.exchangeRate == null && !provider.isLoading)
                Container(
                  padding: EdgeInsets.all(16),
                  margin: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.orange[50],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.orange[200]!),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.warning_amber_outlined, color: Colors.orange[700]),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          AppLocalizations.of(context)!.loadingRates,
                          style: TextStyle(color: Colors.orange[700], fontWeight: FontWeight.w500),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => provider.fetchExchangeRates(),
                        child: Text(AppLocalizations.of(context)!.refresh),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange[100],
                          foregroundColor: Colors.orange[700],
                        ),
                      ),
                    ],
                  ),
                ),
              Expanded(
                child: Padding(padding: EdgeInsets.all(16.0), child: _buildResultsList(provider)),
              ),
              _buildNumberKeyboard(provider),
            ],
          );
        },
      ),
    );
  }

  Widget _buildNumberKeyboard(ExchangeRateProvider provider) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(top: BorderSide(color: Theme.of(context).colorScheme.outline.withOpacity(0.2), width: 1)),
      ),
      child: Column(
        children: [
          // 숫자 키보드 (3x3 + 0)
          Expanded(
            flex: 4,
            child: Row(
              children: [
                // 왼쪽 숫자 키패드 (3x4)
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      // 1, 2, 3
                      Expanded(
                        child: Row(
                          children: [
                            _buildNumberKey('1', provider),
                            _buildNumberKey('2', provider),
                            _buildNumberKey('3', provider),
                          ],
                        ),
                      ),
                      // 4, 5, 6
                      Expanded(
                        child: Row(
                          children: [
                            _buildNumberKey('4', provider),
                            _buildNumberKey('5', provider),
                            _buildNumberKey('6', provider),
                          ],
                        ),
                      ),
                      // 7, 8, 9
                      Expanded(
                        child: Row(
                          children: [
                            _buildNumberKey('7', provider),
                            _buildNumberKey('8', provider),
                            _buildNumberKey('9', provider),
                          ],
                        ),
                      ),
                      // 0, ., ⌫
                      Expanded(
                        child: Row(
                          children: [
                            _buildNumberKey('0', provider),
                            _buildNumberKey('.', provider),
                            _buildNumberKey('⌫', provider),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // 오른쪽 특수 키패드 (1x4)
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      _buildSpecialKey('C', provider), // Clear
                      _buildSpecialKey('', provider), // Empty
                      _buildSpecialKey('U', provider), // Update rates
                      _buildSpecialKey('⚙️', provider), // Settings
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNumberKey(String text, ExchangeRateProvider provider) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(2),
        child: AspectRatio(
          aspectRatio: 1.0, // 정사각형 비율
          child: ElevatedButton(
            onPressed: () {
              if (provider.selectedCurrency != null) {
                if (text == '⌫') {
                  provider.backspace();
                } else {
                  provider.addDigit(text);
                }
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.surface,
              foregroundColor: Theme.of(context).colorScheme.onSurface,
              elevation: 1,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              padding: EdgeInsets.zero, // 패딩 제거로 더 정사각형에 가깝게
            ),
            child: Text(text, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
          ),
        ),
      ),
    );
  }

  Widget _buildSpecialKey(String text, ExchangeRateProvider provider) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(2),
        child: AspectRatio(
          aspectRatio: 1.0, // 정사각형 비율
          child: ElevatedButton(
            onPressed: () {
              switch (text) {
                case 'C':
                  provider.clearInput();
                  break;
                case 'U':
                  provider.fetchExchangeRates();
                  break;
                case '⚙️':
                  // 햄버거 메뉴 열기
                  Scaffold.of(context).openDrawer();
                  break;
                default:
                  // 빈 키는 아무 동작 안함
                  break;
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
              elevation: 1,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              padding: EdgeInsets.zero, // 패딩 제거로 더 정사각형에 가깝게
            ),
            child: Text(text, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          ),
        ),
      ),
    );
  }

  Widget _buildResultsList(ExchangeRateProvider provider) {
    final currencies = provider.currencies;

    return ListView.builder(
      itemCount: currencies.length,
      itemBuilder: (context, index) {
        final currency = currencies[index];
        final isSelected = provider.selectedCurrency == currency;
        final convertedAmount = provider.calculateConversion(currency);

        return Container(
          margin: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
          decoration: BoxDecoration(
            color: isSelected
                ? Theme.of(context).colorScheme.primaryContainer.withOpacity(0.5)
                : Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.outline.withOpacity(0.2),
              width: isSelected ? 3 : 1,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Column(
            children: [
              ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                leading: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CurrencySelectionScreen(
                          currentCurrency: currency,
                          onCurrencySelected: (selectedCurrency) {
                            // 선택된 통화로 현재 통화를 교체
                            _replaceCurrency(currency, selectedCurrency, provider);
                          },
                        ),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // 국기 표시
                      CountryFlag.fromCountryCode(
                        CurrencyUtils.getCountryCodeFromCurrency(currency),
                        height: 20,
                        width: 30,
                      ),
                      SizedBox(width: 8),
                      // 통화 코드
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          currency,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: isSelected
                                ? Theme.of(context).colorScheme.onPrimary
                                : Theme.of(context).colorScheme.onPrimaryContainer,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                title: Text(
                  _getCurrencyName(currency),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: isSelected ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                trailing: isSelected
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.inputting,
                            style: TextStyle(
                              fontSize: 12,
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 4),
                          Icon(Icons.keyboard_arrow_up, color: Theme.of(context).colorScheme.primary),
                        ],
                      )
                    : Text(
                        CurrencyUtils.formatCurrencyAmount(convertedAmount, currency),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                onTap: () {
                  if (isSelected) {
                    provider.setSelectedCurrency(null);
                  } else {
                    provider.setSelectedCurrency(currency);
                  }
                },
              ),
              if (isSelected)
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.2),
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.edit, size: 16, color: Theme.of(context).colorScheme.primary),
                          SizedBox(width: 8),
                          Text(
                            AppLocalizations.of(context)!.inputAmount(currency),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      TextField(
                        controller: TextEditingController(
                          text: provider.currentInput.isNotEmpty
                              ? CurrencyUtils.formatCurrencyAmount(
                                  double.tryParse(provider.currentInput) ?? 0.0,
                                  currency,
                                )
                              : '',
                        ),
                        keyboardType: TextInputType.number,
                        readOnly: true,
                        enableInteractiveSelection: false,
                        showCursor: false,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        decoration: InputDecoration(
                          hintText: '0.00',
                          hintStyle: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 2),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 2),
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          filled: true,
                          fillColor: Theme.of(context).colorScheme.surface,
                        ),
                        onTap: () {
                          // TextField를 탭해도 키보드가 올라오지 않도록 함
                        },
                      ),
                    ],
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  void _replaceCurrency(String oldCurrency, String newCurrency, ExchangeRateProvider provider) {
    provider.replaceCurrency(oldCurrency, newCurrency);
  }

  String _getCurrencyName(String code) {
    return CurrencyUtils.getCurrencyNameWithContext(context, code);
  }

  // Drawer 위젯
  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Drawer 헤더
          DrawerHeader(
            decoration: BoxDecoration(color: Theme.of(context).colorScheme.primaryContainer),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Icon(Icons.currency_exchange, size: 30, color: Theme.of(context).colorScheme.primaryContainer),
                ),
                SizedBox(height: 12),
                Text(
                  AppLocalizations.of(context)!.appTitle,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  AppLocalizations.of(context)!.realtimeExchangeRate,
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),

          // 메뉴 항목들
          ListTile(
            leading: Icon(Icons.settings, color: Theme.of(context).colorScheme.primary),
            title: Text(AppLocalizations.of(context)!.settings),
            subtitle: Text(AppLocalizations.of(context)!.manageAppSettings),
            onTap: () {
              Navigator.pop(context); // Drawer 닫기
              Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsScreen()));
            },
          ),

          ListTile(
            leading: Icon(Icons.language, color: Theme.of(context).colorScheme.primary),
            title: Text(AppLocalizations.of(context)!.language),
            subtitle: Text(AppLocalizations.of(context)!.changeLanguage),
            onTap: () {
              Navigator.pop(context); // Drawer 닫기
              Navigator.push(context, MaterialPageRoute(builder: (context) => LanguageScreen()));
            },
          ),

          ListTile(
            leading: Icon(Icons.feedback, color: Theme.of(context).colorScheme.primary),
            title: Text(AppLocalizations.of(context)!.feedback),
            subtitle: Text(AppLocalizations.of(context)!.sendFeedback),
            onTap: () {
              Navigator.pop(context); // Drawer 닫기
              Navigator.push(context, MaterialPageRoute(builder: (context) => FeedbackScreen()));
            },
          ),

          Divider(),

          ListTile(
            leading: Icon(Icons.info, color: Theme.of(context).colorScheme.primary),
            title: Text(AppLocalizations.of(context)!.developerInfo),
            subtitle: Text(AppLocalizations.of(context)!.aboutApp),
            onTap: () {
              Navigator.pop(context); // Drawer 닫기
              Navigator.push(context, MaterialPageRoute(builder: (context) => AboutScreen()));
            },
          ),
        ],
      ),
    );
  }

  // 에러 위젯
  Widget _buildErrorWidget(ExchangeRateProvider provider) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.red[200]!),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.error_outline, color: Colors.red[700]),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  provider.errorMessage ?? AppLocalizations.of(context)!.unknownError,
                  style: TextStyle(color: Colors.red[700], fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: () => provider.fetchExchangeRates(),
                icon: Icon(Icons.refresh, size: 16),
                label: Text(AppLocalizations.of(context)!.retryLoading),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red[100], foregroundColor: Colors.red[700]),
              ),
              ElevatedButton.icon(
                onPressed: () => provider.fetchExchangeRatesWithRetry(),
                icon: Icon(Icons.replay, size: 16),
                label: Text(AppLocalizations.of(context)!.retry),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red[100], foregroundColor: Colors.red[700]),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
