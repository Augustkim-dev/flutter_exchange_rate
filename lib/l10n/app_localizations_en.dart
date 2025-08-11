// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Exchange Rate Calculator';

  @override
  String get settings => 'Settings';

  @override
  String get language => 'Language';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get refreshRates => 'Refresh Exchange Rates';

  @override
  String lastUpdated(String time) {
    return 'Last updated: $time';
  }

  @override
  String get selectCurrency => 'Select Currency';

  @override
  String get favorites => 'Favorites';

  @override
  String get aboutApp => 'About';

  @override
  String get feedback => 'Feedback';

  @override
  String get offlineMode => 'Offline Mode - Using cached data';

  @override
  String inputAmount(String currency) {
    return 'Enter amount for $currency';
  }

  @override
  String get noInternetConnection => 'No internet connection';

  @override
  String get cacheDataDeleted => 'Cache data deleted';

  @override
  String get confirmDeleteCache => 'Delete all cached exchange rate data?';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get retry => 'Retry';

  @override
  String get error => 'Error';

  @override
  String get loading => 'Loading...';

  @override
  String get welcome => 'Welcome';

  @override
  String get getStarted => 'Get Started';

  @override
  String get selectHomeCurrency => 'Select Your Home Currency';

  @override
  String get selectDefaultCurrencies => 'Select Default Currencies';

  @override
  String get continueButton => 'Continue';

  @override
  String get skip => 'Skip';

  @override
  String get next => 'Next';

  @override
  String get justNow => 'Just now';

  @override
  String minutesAgo(int count) {
    return '$count minutes ago';
  }

  @override
  String hoursAgo(int count) {
    return '$count hours ago';
  }

  @override
  String get realtimeExchangeRate => 'Real-time Exchange Rates';

  @override
  String get developerInfo => 'Developer Info';

  @override
  String get sendFeedback => 'Send Feedback';

  @override
  String get manageAppSettings => 'Manage app settings';

  @override
  String get changeLanguage => 'Change language';

  @override
  String get darkModeEnabled => 'Dark mode enabled';

  @override
  String get lightModeEnabled => 'Light mode enabled';

  @override
  String get notifications => 'Notifications';

  @override
  String get receiveRateAlerts => 'Receive exchange rate alerts';

  @override
  String get autoRefresh => 'Auto Refresh';

  @override
  String get updateEvery5Minutes => 'Update rates every 5 minutes';

  @override
  String get favoriteCurrencies => 'Favorite Currencies';

  @override
  String currentFavorites(int count) {
    return 'Currently $count currencies saved';
  }

  @override
  String get usingCachedData => 'Using Cached Data';

  @override
  String get refresh => 'Refresh';

  @override
  String get ratesUpdated => 'Exchange rates updated';

  @override
  String get updateFailed => 'Update failed';

  @override
  String get version => 'Version';

  @override
  String get inputting => 'Inputting';

  @override
  String get cacheDeletion => 'Cache Deletion';

  @override
  String get loadingRates => 'Loading exchange rates...';

  @override
  String get unknownError => 'Unknown error occurred';

  @override
  String get retryLoading => 'Retry';

  @override
  String get amount => 'Amount';

  @override
  String get enterAmount => 'Enter amount';

  @override
  String get clear => 'Clear';

  @override
  String get update => 'Update';

  @override
  String get currencyUSD => 'US Dollar';

  @override
  String get currencyEUR => 'Euro';

  @override
  String get currencyJPY => 'Japanese Yen';

  @override
  String get currencyGBP => 'British Pound';

  @override
  String get currencyKRW => 'Korean Won';

  @override
  String get currencyCNY => 'Chinese Yuan';

  @override
  String get currencyAUD => 'Australian Dollar';

  @override
  String get currencyCAD => 'Canadian Dollar';

  @override
  String get currencyCHF => 'Swiss Franc';

  @override
  String get currencyHKD => 'Hong Kong Dollar';

  @override
  String get currencyNZD => 'New Zealand Dollar';

  @override
  String get currencySEK => 'Swedish Krona';

  @override
  String get currencyNOK => 'Norwegian Krone';

  @override
  String get currencyDKK => 'Danish Krone';

  @override
  String get currencySGD => 'Singapore Dollar';

  @override
  String get currencyTHB => 'Thai Baht';

  @override
  String get currencyMYR => 'Malaysian Ringgit';

  @override
  String get currencyIDR => 'Indonesian Rupiah';

  @override
  String get currencyPHP => 'Philippine Peso';

  @override
  String get currencyINR => 'Indian Rupee';

  @override
  String get currencyVND => 'Vietnamese Dong';

  @override
  String get currencyTRY => 'Turkish Lira';

  @override
  String get currencyRUB => 'Russian Ruble';

  @override
  String get currencyBRL => 'Brazilian Real';

  @override
  String get currencyMXN => 'Mexican Peso';

  @override
  String get addCurrency => 'Add Currency';

  @override
  String get alreadyInFavorites => 'Already in favorites';

  @override
  String get appInfo => 'App Info';

  @override
  String get versionInfo => 'Version 1.0.0';

  @override
  String get getLocationCurrency => 'Get currency from location';

  @override
  String get category => 'Category';

  @override
  String get general => 'General';

  @override
  String get other => 'Other';

  @override
  String get platform => 'Platform';

  @override
  String get license => 'License';

  @override
  String get developer => 'Developer';

  @override
  String get contact => 'Contact';

  @override
  String get website => 'Website';

  @override
  String get preview => 'Preview';

  @override
  String get start => 'Start';

  @override
  String get manageFavoriteCurrencies => 'Manage Favorite Currencies';

  @override
  String get allCurrencies => 'All Currencies';

  @override
  String get searchCurrencies => 'Search by code, name, or country...';

  @override
  String get maxCurrenciesReached => 'Maximum 10 currencies allowed';

  @override
  String currencyAddedToFavorites(String currency) {
    return '$currency added to favorites';
  }
}
