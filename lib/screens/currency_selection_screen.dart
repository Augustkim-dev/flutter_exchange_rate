import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/exchange_rate_provider.dart';
import '../utils/currency_utils.dart';
import 'package:country_flags/country_flags.dart';
import '../l10n/app_localizations.dart';

class CurrencySelectionScreen extends StatefulWidget {
  final String currentCurrency;
  final Function(String) onCurrencySelected;
  final bool isFromSettings; // 설정에서 접근했는지 여부

  const CurrencySelectionScreen({
    Key? key,
    required this.currentCurrency,
    required this.onCurrencySelected,
    this.isFromSettings = false, // 기본값은 false
  }) : super(key: key);

  @override
  _CurrencySelectionScreenState createState() => _CurrencySelectionScreenState();
}

class _CurrencySelectionScreenState extends State<CurrencySelectionScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> _filteredCurrencies = [];
  List<Map<String, String>> _allCurrencies = [];
  bool _showFavoritesOnly = false;

  @override
  void initState() {
    super.initState();
    // initState에서는 context를 사용할 수 없으므로 didChangeDependencies에서 초기화
    // 대신 기본값을 사용
    _allCurrencies = CurrencyUtils.getAllCurrencies();
    _filterCurrencies('');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // context가 사용 가능한 시점에 다국어 지원 데이터로 업데이트
    _initializeCurrencies();
  }

  void _initializeCurrencies() {
    _allCurrencies = CurrencyUtils.getAllCurrenciesWithContext(context);
    _filterCurrencies(_searchController.text);
  }

  void _filterCurrencies(String query) {
    setState(() {
      List<Map<String, String>> baseList = _allCurrencies;

      // 즐겨찾기 필터 적용
      if (_showFavoritesOnly) {
        final provider = context.read<ExchangeRateProvider>();
        baseList = _allCurrencies.where((currency) {
          return provider.isFavorite(currency['code']!);
        }).toList();
      }

      // 검색 필터 적용
      if (query.isEmpty) {
        _filteredCurrencies = baseList;
      } else {
        _filteredCurrencies = baseList.where((currency) {
          return currency['code']!.toLowerCase().contains(query.toLowerCase()) ||
              currency['name']!.toLowerCase().contains(query.toLowerCase()) ||
              currency['country']!.toLowerCase().contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  void _toggleFavoritesFilter() {
    setState(() {
      _showFavoritesOnly = !_showFavoritesOnly;
      _filterCurrencies(_searchController.text);
    });
  }

  Widget _buildFilterButton(String text, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.surfaceVariant,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: isSelected
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.outline.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isSelected
                ? Theme.of(context).colorScheme.onPrimary
                : Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isFromSettings 
            ? AppLocalizations.of(context)!.manageFavoriteCurrencies 
            : AppLocalizations.of(context)!.selectCurrency),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          // 필터 버튼
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Expanded(child: _buildFilterButton(AppLocalizations.of(context)!.allCurrencies, !_showFavoritesOnly, _toggleFavoritesFilter)),
                SizedBox(width: 12),
                Expanded(child: _buildFilterButton(AppLocalizations.of(context)!.favorites, _showFavoritesOnly, _toggleFavoritesFilter)),
              ],
            ),
          ),
          // 검색창
          Container(
            padding: EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.searchCurrencies,
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: Theme.of(context).colorScheme.surfaceVariant,
              ),
              onChanged: _filterCurrencies,
            ),
          ),
          // 통화 목록
          Expanded(
            child: ListView.builder(
              itemCount: _filteredCurrencies.length,
              itemBuilder: (context, index) {
                final currency = _filteredCurrencies[index];
                final isSelected = currency['code'] == widget.currentCurrency;

                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3)
                        : Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.outline.withOpacity(0.2),
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    leading: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // 국기 표시
                        CountryFlag.fromCountryCode(
                          CurrencyUtils.getCountryCodeFromCurrency(currency['code']!),
                          height: 24,
                          width: 36,
                        ),
                        SizedBox(width: 8),
                        // 통화 코드
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            currency['code']!,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Theme.of(context).colorScheme.onPrimaryContainer,
                            ),
                          ),
                        ),
                      ],
                    ),
                    title: Text(
                      currency['name']!,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    subtitle: Text(
                      currency['country']!,
                      style: TextStyle(fontSize: 14, color: Theme.of(context).colorScheme.onSurfaceVariant),
                    ),
                    trailing: Consumer<ExchangeRateProvider>(
                      builder: (context, provider, child) {
                        final isFavorite = provider.isFavorite(currency['code']!);

                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // 즐겨찾기 토글 버튼
                            GestureDetector(
                              onTap: () async {
                                if (!isFavorite && provider.favoriteCurrencies.length >= 10) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(AppLocalizations.of(context)!.maxCurrenciesReached),
                                      duration: Duration(seconds: 2),
                                      backgroundColor: Theme.of(context).colorScheme.error,
                                    ),
                                  );
                                  return;
                                }
                                await provider.toggleFavorite(currency['code']!);
                                // 필터가 즐겨찾기 모드라면 목록을 다시 필터링
                                if (_showFavoritesOnly) {
                                  _filterCurrencies(_searchController.text);
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: isFavorite
                                      ? Colors.amber.withOpacity(0.1)
                                      : Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(
                                  isFavorite ? Icons.star : Icons.star_border,
                                  size: 20,
                                  color: isFavorite ? Colors.amber : Theme.of(context).colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ),
                            SizedBox(width: 8),
                            // 선택 상태 표시 (즐겨찾기보다 우선순위 낮음)
                            if (isSelected)
                              Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(Icons.check_circle, size: 20, color: Theme.of(context).colorScheme.primary),
                              ),
                          ],
                        );
                      },
                    ),
                    onTap: () {
                      if (widget.isFromSettings) {
                        // 설정에서 접근한 경우: 즐겨찾기에 추가
                        final provider = context.read<ExchangeRateProvider>();
                        if (!provider.currencies.contains(currency['code']!)) {
                          provider.addCurrency(currency['code']!);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(AppLocalizations.of(context)!.currencyAddedToFavorites(currency['code']!)),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text(AppLocalizations.of(context)!.alreadyInFavorites), duration: Duration(seconds: 2)));
                        }
                      } else {
                        // 메인 화면에서 접근한 경우: 기존 동작
                        widget.onCurrencySelected(currency['code']!);
                        Navigator.pop(context);
                      }
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
