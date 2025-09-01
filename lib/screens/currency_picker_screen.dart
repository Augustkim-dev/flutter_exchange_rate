import 'package:flutter/material.dart';
import 'package:country_flags/country_flags.dart';
import '../utils/currency_utils.dart';

class CurrencyPickerScreen extends StatefulWidget {
  final List<String> selectedCurrencies;
  final Function(String) onCurrencySelected;

  const CurrencyPickerScreen({Key? key, required this.selectedCurrencies, required this.onCurrencySelected})
    : super(key: key);

  @override
  _CurrencyPickerScreenState createState() => _CurrencyPickerScreenState();
}

class _CurrencyPickerScreenState extends State<CurrencyPickerScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<String> _filteredCurrencies = [];
  List<String> _allCurrencies = [];

  @override
  void initState() {
    super.initState();
    _initializeCurrencies();
    _searchController.addListener(_filterCurrencies);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _initializeCurrencies() {
    _allCurrencies = [
      'USD',
      'EUR',
      'JPY',
      'GBP',
      'KRW',
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
      'BGN',
      'HRK',
      'RSD',
      'UAH',
      'KZT',
      'CLP',
      'COP',
      'PEN',
      'ARS',
      'UYU',
      'PYG',
      'BOB',
      'GTQ',
      'HNL',
      'NIO',
      'CRC',
      'PAB',
      'DOP',
    ];
    _filteredCurrencies = List.from(_allCurrencies);
  }

  void _filterCurrencies() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredCurrencies = List.from(_allCurrencies);
      } else {
        _filteredCurrencies = _allCurrencies.where((currency) {
          final currencyName = CurrencyUtils.getCurrencyName(currency).toLowerCase();
          return currency.toLowerCase().contains(query) || currencyName.contains(query);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('통화 추가'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        elevation: 0,
      ),
      body: SafeArea(
        bottom: true,
        child: Column(
          children: [
          // 검색 바
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              border: Border(bottom: BorderSide(color: Theme.of(context).colorScheme.outline.withOpacity(0.2))),
            ),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: '통화 코드 또는 이름으로 검색',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
          ),

          // 통화 목록
          Expanded(
            child: ListView.builder(
              itemCount: _filteredCurrencies.length,
              itemBuilder: (context, index) {
                final currency = _filteredCurrencies[index];
                final isSelected = widget.selectedCurrencies.contains(currency);

                return ListTile(
                  leading: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CountryFlag.fromCountryCode(
                        CurrencyUtils.getCountryCodeFromCurrency(currency),
                        height: 24,
                        width: 36,
                      ),
                      SizedBox(width: 12),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          currency,
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
                    CurrencyUtils.getCurrencyName(currency),
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  subtitle: Text(
                    currency,
                    style: TextStyle(fontSize: 14, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6)),
                  ),
                  trailing: isSelected
                      ? Icon(Icons.check_circle, color: Theme.of(context).colorScheme.primary, size: 24)
                      : Icon(Icons.add_circle_outline, color: Theme.of(context).colorScheme.outline, size: 24),
                  onTap: () {
                    if (!isSelected) {
                      widget.onCurrencySelected(currency);
                      Navigator.pop(context);
                    }
                  },
                );
              },
            ),
          ),
        ],
        ),
      ),
    );
  }
}
