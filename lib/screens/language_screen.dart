import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:country_flags/country_flags.dart';
import '../l10n/app_localizations.dart';
import '../providers/localization_provider.dart';

class LanguageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final localizationProvider = context.watch<LocalizationProvider>();
    
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.language),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        bottom: true,
        child: ListView.builder(
          itemCount: LocalizationProvider.supportedLocales.length,
          itemBuilder: (context, index) {
          final locale = LocalizationProvider.supportedLocales[index];
          final isSelected = localizationProvider.currentLocale == locale;
          
          return ListTile(
            leading: CountryFlag.fromCountryCode(
              localizationProvider.getLanguageFlag(locale.languageCode),
              height: 24,
              width: 36,
            ),
            title: Text(
              localizationProvider.getLanguageName(locale),
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            trailing: isSelected 
                ? Icon(Icons.check, color: Theme.of(context).colorScheme.primary) 
                : null,
            selected: isSelected,
            onTap: () {
              localizationProvider.setLocale(locale);
              
              // 언어 변경 완료 메시지
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${localizationProvider.getLanguageName(locale)}'),
                  duration: Duration(seconds: 2),
                ),
              );
              
              // 잠시 후 이전 화면으로 돌아가기
              Future.delayed(Duration(milliseconds: 500), () {
                if (context.mounted) {
                  Navigator.pop(context);
                }
              });
            },
          );
        },
        ),
      ),
    );
  }
}