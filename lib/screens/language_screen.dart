import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

class LanguageScreen extends StatefulWidget {
  @override
  _LanguageScreenState createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String _selectedLanguage = '한국어';

  final List<Map<String, String>> _languages = [
    {'name': '한국어', 'code': 'ko', 'native': '한국어'},
    {'name': 'English', 'code': 'en', 'native': 'English'},
    {'name': '日本語', 'code': 'ja', 'native': '日本語'},
    {'name': '中文', 'code': 'zh', 'native': '中文'},
    {'name': 'Español', 'code': 'es', 'native': 'Español'},
    {'name': 'Français', 'code': 'fr', 'native': 'Français'},
    {'name': 'Deutsch', 'code': 'de', 'native': 'Deutsch'},
    {'name': 'Italiano', 'code': 'it', 'native': 'Italiano'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('언어 설정'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        elevation: 0,
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: _languages.length,
        itemBuilder: (context, index) {
          final language = _languages[index];
          final isSelected = _selectedLanguage == language['name'];

          return ListTile(
            leading: Container(
              width: 40,
              height: 30,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Center(
                child: Text(
                  language['code']!.toUpperCase(),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
              ),
            ),
            title: Text(language['name']!),
            subtitle: Text(language['native']!),
            trailing: isSelected
                ? Icon(Icons.check, color: Theme.of(context).colorScheme.primary)
                : null,
            onTap: () {
              setState(() {
                _selectedLanguage = language['name']!;
              });
              // TODO: 언어 변경 로직 구현
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('언어가 ${language['name']}로 변경되었습니다'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          );
        },
      ),
    );
  }
} 