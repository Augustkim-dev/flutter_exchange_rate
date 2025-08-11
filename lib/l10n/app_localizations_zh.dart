// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => '汇率计算器';

  @override
  String get settings => '设置';

  @override
  String get language => '语言';

  @override
  String get darkMode => '深色模式';

  @override
  String get refreshRates => '刷新汇率';

  @override
  String lastUpdated(String time) {
    return '最后更新: $time';
  }

  @override
  String get selectCurrency => '选择货币';

  @override
  String get favorites => '收藏';

  @override
  String get aboutApp => '关于';

  @override
  String get feedback => '反馈';

  @override
  String get offlineMode => '离线模式 - 使用缓存数据';

  @override
  String inputAmount(String currency) {
    return '输入$currency金额';
  }

  @override
  String get noInternetConnection => '请检查网络连接';

  @override
  String get cacheDataDeleted => '缓存已删除';

  @override
  String get confirmDeleteCache => '删除所有缓存的汇率数据？';

  @override
  String get cancel => '取消';

  @override
  String get delete => '删除';

  @override
  String get retry => '重试';

  @override
  String get error => '错误';

  @override
  String get loading => '加载中...';

  @override
  String get welcome => '欢迎';

  @override
  String get getStarted => '开始';

  @override
  String get selectHomeCurrency => '选择本地货币';

  @override
  String get selectDefaultCurrencies => '选择默认货币';

  @override
  String get continueButton => '继续';

  @override
  String get skip => '跳过';

  @override
  String get next => '下一步';

  @override
  String get justNow => '刚刚';

  @override
  String minutesAgo(int count) {
    return '$count分钟前';
  }

  @override
  String hoursAgo(int count) {
    return '$count小时前';
  }

  @override
  String get realtimeExchangeRate => '实时汇率';

  @override
  String get developerInfo => '开发者信息';

  @override
  String get sendFeedback => '发送反馈';

  @override
  String get manageAppSettings => '管理应用设置';

  @override
  String get changeLanguage => '更改语言';

  @override
  String get darkModeEnabled => '深色模式已启用';

  @override
  String get lightModeEnabled => '浅色模式已启用';

  @override
  String get notifications => '通知设置';

  @override
  String get receiveRateAlerts => '接收汇率变动通知';

  @override
  String get autoRefresh => '自动刷新';

  @override
  String get updateEvery5Minutes => '每5分钟自动更新汇率';

  @override
  String get favoriteCurrencies => '收藏货币';

  @override
  String currentFavorites(int count) {
    return '当前已收藏$count个货币';
  }

  @override
  String get usingCachedData => '使用缓存数据';

  @override
  String get refresh => '刷新';

  @override
  String get ratesUpdated => '汇率已更新';

  @override
  String get updateFailed => '更新失败';

  @override
  String get version => '版本';

  @override
  String get inputting => '输入中';

  @override
  String get cacheDeletion => '缓存删除';

  @override
  String get loadingRates => '正在加载汇率...';

  @override
  String get unknownError => '发生未知错误';

  @override
  String get retryLoading => '重试';

  @override
  String get amount => '金额';

  @override
  String get enterAmount => '输入金额';

  @override
  String get clear => '清除';

  @override
  String get update => '更新';

  @override
  String get currencyUSD => '美元';

  @override
  String get currencyEUR => '欧元';

  @override
  String get currencyJPY => '日元';

  @override
  String get currencyGBP => '英镑';

  @override
  String get currencyKRW => '韩元';

  @override
  String get currencyCNY => '人民币';

  @override
  String get currencyAUD => '澳元';

  @override
  String get currencyCAD => '加元';

  @override
  String get currencyCHF => '瑞士法郎';

  @override
  String get currencyHKD => '港币';

  @override
  String get currencyNZD => '新西兰元';

  @override
  String get currencySEK => '瑞典克朗';

  @override
  String get currencyNOK => '挪威克朗';

  @override
  String get currencyDKK => '丹麦克朗';

  @override
  String get currencySGD => '新加坡元';

  @override
  String get currencyTHB => '泰铢';

  @override
  String get currencyMYR => '马来西亚令吉';

  @override
  String get currencyIDR => '印尼盾';

  @override
  String get currencyPHP => '菲律宾比索';

  @override
  String get currencyINR => '印度卢比';

  @override
  String get currencyVND => '越南盾';

  @override
  String get currencyTRY => '土耳其里拉';

  @override
  String get currencyRUB => '俄罗斯卢布';

  @override
  String get currencyBRL => '巴西雷亚尔';

  @override
  String get currencyMXN => '墨西哥比索';

  @override
  String get addCurrency => '添加货币';

  @override
  String get alreadyInFavorites => '已在收藏夹中';

  @override
  String get appInfo => '应用信息';

  @override
  String get versionInfo => '版本 1.0.0';

  @override
  String get getLocationCurrency => '从位置获取货币';

  @override
  String get category => '类别';

  @override
  String get general => '常规';

  @override
  String get other => '其他';

  @override
  String get platform => '平台';

  @override
  String get license => '许可证';

  @override
  String get developer => '开发者';

  @override
  String get contact => '联系方式';

  @override
  String get website => '网站';

  @override
  String get preview => '预览';

  @override
  String get start => '开始';

  @override
  String get manageFavoriteCurrencies => '管理收藏货币';

  @override
  String get allCurrencies => '所有货币';

  @override
  String get searchCurrencies => '按代码、名称或国家搜索...';

  @override
  String get maxCurrenciesReached => '最多只能选择10个货币';

  @override
  String currencyAddedToFavorites(String currency) {
    return '$currency已添加到收藏夹';
  }
}
