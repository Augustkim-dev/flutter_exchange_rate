// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => '為替計算機';

  @override
  String get settings => '設定';

  @override
  String get language => '言語';

  @override
  String get darkMode => 'ダークモード';

  @override
  String get refreshRates => '為替レート更新';

  @override
  String lastUpdated(String time) {
    return '最終更新: $time';
  }

  @override
  String get selectCurrency => '通貨選択';

  @override
  String get favorites => 'お気に入り';

  @override
  String get aboutApp => 'アプリについて';

  @override
  String get feedback => 'フィードバック';

  @override
  String get offlineMode => 'オフラインモード - 保存データ使用中';

  @override
  String inputAmount(String currency) {
    return '$currency金額入力';
  }

  @override
  String get noInternetConnection => 'インターネット接続を確認してください';

  @override
  String get cacheDataDeleted => 'キャッシュが削除されました';

  @override
  String get confirmDeleteCache => '保存された為替データを削除しますか？';

  @override
  String get cancel => 'キャンセル';

  @override
  String get delete => '削除';

  @override
  String get retry => '再試行';

  @override
  String get error => 'エラー';

  @override
  String get loading => '読み込み中...';

  @override
  String get welcome => 'ようこそ';

  @override
  String get getStarted => '始める';

  @override
  String get selectHomeCurrency => 'ホーム通貨を選択';

  @override
  String get selectDefaultCurrencies => 'デフォルト通貨を選択';

  @override
  String get continueButton => '続ける';

  @override
  String get skip => 'スキップ';

  @override
  String get next => '次へ';

  @override
  String get justNow => 'たった今';

  @override
  String minutesAgo(int count) {
    return '$count分前';
  }

  @override
  String hoursAgo(int count) {
    return '$count時間前';
  }

  @override
  String get realtimeExchangeRate => 'リアルタイム為替レート';

  @override
  String get developerInfo => '開発者情報';

  @override
  String get sendFeedback => 'フィードバックを送る';

  @override
  String get manageAppSettings => 'アプリ設定を管理';

  @override
  String get changeLanguage => '言語を変更';

  @override
  String get darkModeEnabled => 'ダークモードが有効';

  @override
  String get lightModeEnabled => 'ライトモードが有効';

  @override
  String get notifications => '通知設定';

  @override
  String get receiveRateAlerts => '為替レート変動通知を受信';

  @override
  String get autoRefresh => '自動更新';

  @override
  String get updateEvery5Minutes => '5分ごとに為替レートを自動更新';

  @override
  String get favoriteCurrencies => 'お気に入り通貨';

  @override
  String currentFavorites(int count) {
    return '現在$count個の通貨が保存されています';
  }

  @override
  String get usingCachedData => 'キャッシュデータ使用中';

  @override
  String get refresh => '更新';

  @override
  String get ratesUpdated => '為替レートが更新されました';

  @override
  String get updateFailed => '更新失敗';

  @override
  String get version => 'バージョン';

  @override
  String get inputting => '入力中';

  @override
  String get cacheDeletion => 'キャッシュ削除';

  @override
  String get loadingRates => '為替レートを読み込み中...';

  @override
  String get unknownError => '不明なエラーが発生しました';

  @override
  String get retryLoading => '再試行';

  @override
  String get amount => '金額';

  @override
  String get enterAmount => '金額入力';

  @override
  String get clear => 'クリア';

  @override
  String get update => '更新';

  @override
  String get currencyUSD => '米ドル';

  @override
  String get currencyEUR => 'ユーロ';

  @override
  String get currencyJPY => '日本円';

  @override
  String get currencyGBP => '英ポンド';

  @override
  String get currencyKRW => '韓国ウォン';

  @override
  String get currencyCNY => '中国人民元';

  @override
  String get currencyAUD => '豪ドル';

  @override
  String get currencyCAD => 'カナダドル';

  @override
  String get currencyCHF => 'スイスフラン';

  @override
  String get currencyHKD => '香港ドル';

  @override
  String get currencyNZD => 'ニュージーランドドル';

  @override
  String get currencySEK => 'スウェーデンクローナ';

  @override
  String get currencyNOK => 'ノルウェークローネ';

  @override
  String get currencyDKK => 'デンマーククローネ';

  @override
  String get currencySGD => 'シンガポールドル';

  @override
  String get currencyTHB => 'タイバーツ';

  @override
  String get currencyMYR => 'マレーシアリンギット';

  @override
  String get currencyIDR => 'インドネシアルピア';

  @override
  String get currencyPHP => 'フィリピンペソ';

  @override
  String get currencyINR => 'インドルピー';

  @override
  String get currencyVND => 'ベトナムドン';

  @override
  String get currencyTRY => 'トルコリラ';

  @override
  String get currencyRUB => 'ロシアルーブル';

  @override
  String get currencyBRL => 'ブラジルレアル';

  @override
  String get currencyMXN => 'メキシコペソ';

  @override
  String get addCurrency => '通貨を追加';

  @override
  String get alreadyInFavorites => '既にお気に入りに追加されています';

  @override
  String get appInfo => 'アプリ情報';

  @override
  String get versionInfo => 'バージョン 1.0.0';

  @override
  String get getLocationCurrency => '位置情報から通貨を取得';

  @override
  String get category => 'カテゴリー';

  @override
  String get general => '一般';

  @override
  String get other => 'その他';

  @override
  String get platform => 'プラットフォーム';

  @override
  String get license => 'ライセンス';

  @override
  String get developer => '開発者';

  @override
  String get contact => 'お問い合わせ';

  @override
  String get website => 'ウェブサイト';

  @override
  String get preview => 'プレビュー';

  @override
  String get start => 'スタート';

  @override
  String get manageFavoriteCurrencies => 'お気に入り通貨を管理';

  @override
  String get allCurrencies => 'すべての通貨';

  @override
  String get searchCurrencies => 'コード、名前、国で検索...';

  @override
  String get maxCurrenciesReached => '最大10通貨まで選択可能';

  @override
  String currencyAddedToFavorites(String currency) {
    return '$currencyがお気に入りに追加されました';
  }
}
