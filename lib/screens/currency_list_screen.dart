import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:country_flags/country_flags.dart';
import '../providers/onboarding_provider.dart';
import '../utils/currency_utils.dart';
import 'currency_picker_screen.dart';

class CurrencyListScreen extends StatefulWidget {
  @override
  _CurrencyListScreenState createState() => _CurrencyListScreenState();
}

class _CurrencyListScreenState extends State<CurrencyListScreen> {
  List<String> _selectedCurrencies = ['USD', 'EUR', 'JPY', 'GBP', 'KRW'];

  @override
  void initState() {
    super.initState();
    // Provider에서 기존 설정 로드
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<OnboardingProvider>();
      setState(() {
        _selectedCurrencies = List.from(provider.defaultCurrencies);
      });
    });
  }

  void _addCurrency(String currency) {
    if (!_selectedCurrencies.contains(currency)) {
      setState(() {
        _selectedCurrencies.add(currency);
      });
      context.read<OnboardingProvider>().setDefaultCurrencies(_selectedCurrencies);
    }
  }

  void _showCurrencyPicker() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            CurrencyPickerScreen(selectedCurrencies: _selectedCurrencies, onCurrencySelected: _addCurrency),
      ),
    );
  }

  void _removeCurrency(String currency) {
    if (_selectedCurrencies.length > 1) {
      setState(() {
        _selectedCurrencies.remove(currency);
      });
      context.read<OnboardingProvider>().setDefaultCurrencies(_selectedCurrencies);
    }
  }

  void _reorderCurrencies(int oldIndex, int newIndex) {
    setState(() {
      if (oldIndex < newIndex) {
        newIndex -= 1;
      }
      final item = _selectedCurrencies.removeAt(oldIndex);
      _selectedCurrencies.insert(newIndex, item);
    });
    context.read<OnboardingProvider>().setDefaultCurrencies(_selectedCurrencies);
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

              // 제목
              Text(
                '기본 환율 목록',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              SizedBox(height: 8),
              Text(
                '앱에서 기본으로 보여줄\n환율 목록을 설정해주세요.',
                style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                  height: 1.4,
                ),
              ),

              SizedBox(height: 40),

              // 선택된 통화 목록
              Text(
                '선택된 통화 (${_selectedCurrencies.length}/10)',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              SizedBox(height: 16),

              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Theme.of(context).colorScheme.outline.withOpacity(0.2)),
                  ),
                  child: ReorderableListView.builder(
                    padding: EdgeInsets.all(16),
                    itemCount: _selectedCurrencies.length,
                    onReorder: _reorderCurrencies,
                    itemBuilder: (context, index) {
                      final currency = _selectedCurrencies[index];
                      return Container(
                        key: ValueKey(currency),
                        margin: EdgeInsets.only(bottom: 8),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Theme.of(context).colorScheme.outline.withOpacity(0.2)),
                        ),
                        child: ListTile(
                          leading: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.drag_handle, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5)),
                              SizedBox(width: 8),
                              CountryFlag.fromCountryCode(
                                CurrencyUtils.getCountryCodeFromCurrency(currency),
                                height: 24,
                                width: 36,
                              ),
                            ],
                          ),
                          title: Text(
                            CurrencyUtils.getCurrencyName(currency),
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          subtitle: Text(
                            currency,
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                            ),
                          ),
                          trailing: _selectedCurrencies.length > 1
                              ? IconButton(
                                  icon: Icon(Icons.remove_circle_outline, color: Colors.red),
                                  onPressed: () => _removeCurrency(currency),
                                )
                              : null,
                        ),
                      );
                    },
                  ),
                ),
              ),

              SizedBox(height: 24),

              // 통화 추가 버튼
              if (_selectedCurrencies.length < 10)
                Container(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _showCurrencyPicker,
                    icon: Icon(Icons.add),
                    label: Text('통화 추가'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                      foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),

              SizedBox(height: 16),

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
                        '드래그하여 순서를 변경할 수 있습니다. 통화 추가 버튼을 눌러서 새로운 통화를 추가할 수 있습니다.',
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
