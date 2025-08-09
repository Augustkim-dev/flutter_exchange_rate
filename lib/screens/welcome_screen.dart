import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:country_flags/country_flags.dart';
import 'package:geolocator/geolocator.dart';
import '../providers/onboarding_provider.dart';
import '../services/location_service.dart';
import '../services/permission_service.dart';
import '../utils/currency_utils.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  String? _detectedCurrency;
  bool _isDetecting = false;
  String _selectedCurrency = 'USD';

  @override
  void initState() {
    super.initState();
    _detectLocationCurrency();
  }

  Future<void> _detectLocationCurrency() async {
    setState(() {
      _isDetecting = true;
    });

    try {
      // 1. 위치 서비스가 활성화되어 있는지 확인
      bool serviceEnabled = await PermissionService.isLocationServiceEnabled();
      if (!serviceEnabled) {
        bool shouldOpenSettings = await PermissionService.showLocationServiceDialog(context);
        if (shouldOpenSettings) {
          // 사용자가 설정으로 이동을 선택한 경우, 잠시 대기 후 다시 확인
          await Future.delayed(Duration(seconds: 2));
          serviceEnabled = await PermissionService.isLocationServiceEnabled();
        }

        if (!serviceEnabled) {
          setState(() {
            _isDetecting = false;
          });
          return;
        }
      }

      // 2. 위치 권한 확인
      LocationPermission permission = await PermissionService.checkLocationPermission();

      if (permission == LocationPermission.denied) {
        // 권한 요청 다이얼로그 표시
        bool shouldRequest = await PermissionService.showPermissionRequestDialog(context);
        if (shouldRequest) {
          permission = await PermissionService.requestLocationPermission();
        } else {
          setState(() {
            _isDetecting = false;
          });
          return;
        }
      }

      if (permission == LocationPermission.denied) {
        // 권한이 거부된 경우
        await PermissionService.showPermissionDeniedDialog(context);
        setState(() {
          _isDetecting = false;
        });
        return;
      }

      if (permission == LocationPermission.deniedForever) {
        // 권한이 영구적으로 거부된 경우
        await PermissionService.showPermissionPermanentlyDeniedDialog(context);
        setState(() {
          _isDetecting = false;
        });
        return;
      }

      // 3. 위치 기반 통화 감지
      final detectedCurrency = await LocationService.detectHomeCurrency();
      setState(() {
        _detectedCurrency = detectedCurrency;
        if (detectedCurrency != null) {
          _selectedCurrency = detectedCurrency;
          // Provider에도 저장
          context.read<OnboardingProvider>().setHomeCurrency(detectedCurrency);
        }
        _isDetecting = false;
      });
    } catch (e) {
      setState(() {
        _isDetecting = false;
      });

      // 에러 발생 시 사용자에게 알림
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('위치 정보를 가져오는 중 오류가 발생했습니다.'), backgroundColor: Colors.red));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40),

              // 환영 메시지
              Text(
                '환영합니다!',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              SizedBox(height: 8),
              Text(
                '환율 변환기를 사용하기 위해\n몇 가지 설정을 도와드리겠습니다.',
                style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                  height: 1.4,
                ),
              ),

              SizedBox(height: 60),

              // 자국 통화 설정 섹션
              Text(
                '자국 통화 설정',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              SizedBox(height: 16),

              // 위치 기반 통화 감지
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Theme.of(context).colorScheme.outline.withOpacity(0.2)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.location_on, color: Theme.of(context).colorScheme.primary),
                        SizedBox(width: 8),
                        Text('위치 정보로 통화 가져오기', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                      ],
                    ),
                    SizedBox(height: 12),
                    if (_isDetecting)
                      Row(
                        children: [
                          SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2)),
                          SizedBox(width: 8),
                          Text('위치 확인 중...'),
                        ],
                      )
                    else if (_detectedCurrency != null)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CountryFlag.fromCountryCode(
                                CurrencyUtils.getCountryCodeFromCurrency(_detectedCurrency!),
                                height: 20,
                                width: 30,
                              ),
                              SizedBox(width: 8),
                              Text(
                                '감지된 통화: ${CurrencyUtils.getCurrencyName(_detectedCurrency!)} ($_detectedCurrency)',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Text(
                            '위치 정보를 기반으로 자동으로 감지되었습니다.',
                            style: TextStyle(
                              fontSize: 12,
                              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                            ),
                          ),
                        ],
                      )
                    else
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '위치 정보를 가져올 수 없습니다.',
                            style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6)),
                          ),
                          SizedBox(height: 4),
                          Text(
                            '권한을 허용하거나 수동으로 통화를 선택해주세요.',
                            style: TextStyle(
                              fontSize: 12,
                              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),
                    SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed: _detectLocationCurrency,
                      icon: Icon(Icons.refresh, size: 16),
                      label: Text('다시 시도'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                        foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24),

              // 통화 선택
              Text(
                '통화 선택',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              SizedBox(height: 12),

              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Theme.of(context).colorScheme.outline.withOpacity(0.2)),
                ),
                child: DropdownButtonFormField<String>(
                  value: _selectedCurrency,
                  isExpanded: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                  items:
                      [
                        'USD',
                        'KRW',
                        'EUR',
                        'JPY',
                        'GBP',
                        'CNY',
                        'CAD',
                        'AUD',
                        'CHF',
                        'SEK',
                        'NOK',
                        'DKK',
                        'SGD',
                        'HKD',
                        'NZD',
                        'MXN',
                        'BRL',
                        'INR',
                        'RUB',
                        'ZAR',
                        'TRY',
                        'THB',
                        'MYR',
                        'IDR',
                        'PHP',
                        'VND',
                        'AED',
                        'SAR',
                        'PLN',
                        'CZK',
                        'HUF',
                        'RON',
                      ].map((currency) {
                        return DropdownMenuItem<String>(
                          value: currency,
                          child: Row(
                            children: [
                              CountryFlag.fromCountryCode(
                                CurrencyUtils.getCountryCodeFromCurrency(currency),
                                height: 20,
                                width: 30,
                              ),
                              SizedBox(width: 12),
                              Flexible(
                                child: Text(
                                  '${CurrencyUtils.getCurrencyName(currency)} ($currency)',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _selectedCurrency = value;
                      });
                      context.read<OnboardingProvider>().setHomeCurrency(value);
                    }
                  },
                ),
              ),

              Spacer(),

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
                        '자국 통화는 환율 계산의 기준이 됩니다. 나중에 설정에서 변경할 수 있습니다.',
                        style: TextStyle(fontSize: 14, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7)),
                      ),
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
}
