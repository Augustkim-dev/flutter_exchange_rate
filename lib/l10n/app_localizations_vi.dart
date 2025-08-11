// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get appTitle => 'Máy Tính Tỷ Giá';

  @override
  String get settings => 'Cài đặt';

  @override
  String get language => 'Ngôn ngữ';

  @override
  String get darkMode => 'Chế độ tối';

  @override
  String get refreshRates => 'Làm mới tỷ giá';

  @override
  String lastUpdated(String time) {
    return 'Cập nhật lần cuối: $time';
  }

  @override
  String get selectCurrency => 'Chọn tiền tệ';

  @override
  String get favorites => 'Yêu thích';

  @override
  String get aboutApp => 'Giới thiệu';

  @override
  String get feedback => 'Phản hồi';

  @override
  String get offlineMode => 'Chế độ ngoại tuyến - Đang dùng dữ liệu đã lưu';

  @override
  String inputAmount(String currency) {
    return 'Nhập số tiền $currency';
  }

  @override
  String get noInternetConnection => 'Vui lòng kiểm tra kết nối mạng';

  @override
  String get cacheDataDeleted => 'Đã xóa bộ nhớ đệm';

  @override
  String get confirmDeleteCache => 'Xóa tất cả dữ liệu tỷ giá đã lưu?';

  @override
  String get cancel => 'Hủy';

  @override
  String get delete => 'Xóa';

  @override
  String get retry => 'Thử lại';

  @override
  String get error => 'Lỗi';

  @override
  String get loading => 'Đang tải...';

  @override
  String get welcome => 'Chào mừng';

  @override
  String get getStarted => 'Bắt đầu';

  @override
  String get selectHomeCurrency => 'Chọn tiền tệ chính';

  @override
  String get selectDefaultCurrencies => 'Chọn tiền tệ mặc định';

  @override
  String get continueButton => 'Tiếp tục';

  @override
  String get skip => 'Bỏ qua';

  @override
  String get next => 'Tiếp theo';

  @override
  String get justNow => 'Vừa xong';

  @override
  String minutesAgo(int count) {
    return '$count phút trước';
  }

  @override
  String hoursAgo(int count) {
    return '$count giờ trước';
  }

  @override
  String get realtimeExchangeRate => 'Tỷ giá thời gian thực';

  @override
  String get developerInfo => 'Thông tin nhà phát triển';

  @override
  String get sendFeedback => 'Gửi phản hồi';

  @override
  String get manageAppSettings => 'Quản lý cài đặt ứng dụng';

  @override
  String get changeLanguage => 'Thay đổi ngôn ngữ';

  @override
  String get darkModeEnabled => 'Đã bật chế độ tối';

  @override
  String get lightModeEnabled => 'Đã bật chế độ sáng';

  @override
  String get notifications => 'Cài đặt thông báo';

  @override
  String get receiveRateAlerts => 'Nhận thông báo biến động tỷ giá';

  @override
  String get autoRefresh => 'Tự động làm mới';

  @override
  String get updateEvery5Minutes => 'Tự động cập nhật tỷ giá mỗi 5 phút';

  @override
  String get favoriteCurrencies => 'Tiền tệ yêu thích';

  @override
  String currentFavorites(int count) {
    return 'Hiện có $count tiền tệ đã lưu';
  }

  @override
  String get usingCachedData => 'Đang dùng dữ liệu đã lưu';

  @override
  String get refresh => 'Làm mới';

  @override
  String get ratesUpdated => 'Đã cập nhật tỷ giá';

  @override
  String get updateFailed => 'Cập nhật thất bại';

  @override
  String get version => 'Phiên bản';

  @override
  String get inputting => 'Đang nhập';

  @override
  String get cacheDeletion => 'Xóa bộ nhớ đệm';

  @override
  String get loadingRates => 'Đang tải tỷ giá...';

  @override
  String get unknownError => 'Đã xảy ra lỗi không xác định';

  @override
  String get retryLoading => 'Thử lại';

  @override
  String get amount => 'Số tiền';

  @override
  String get enterAmount => 'Nhập số tiền';

  @override
  String get clear => 'Xóa';

  @override
  String get update => 'Cập nhật';

  @override
  String get currencyUSD => 'Đô la Mỹ';

  @override
  String get currencyEUR => 'Euro';

  @override
  String get currencyJPY => 'Yên Nhật';

  @override
  String get currencyGBP => 'Bảng Anh';

  @override
  String get currencyKRW => 'Won Hàn Quốc';

  @override
  String get currencyCNY => 'Nhân dân tệ';

  @override
  String get currencyAUD => 'Đô la Úc';

  @override
  String get currencyCAD => 'Đô la Canada';

  @override
  String get currencyCHF => 'Franc Thụy Sỹ';

  @override
  String get currencyHKD => 'Đô la Hồng Kông';

  @override
  String get currencyNZD => 'Đô la New Zealand';

  @override
  String get currencySEK => 'Krona Thụy Điển';

  @override
  String get currencyNOK => 'Krone Na Uy';

  @override
  String get currencyDKK => 'Krone Đan Mạch';

  @override
  String get currencySGD => 'Đô la Singapore';

  @override
  String get currencyTHB => 'Baht Thái';

  @override
  String get currencyMYR => 'Ringgit Malaysia';

  @override
  String get currencyIDR => 'Rupiah Indonesia';

  @override
  String get currencyPHP => 'Peso Philippines';

  @override
  String get currencyINR => 'Rupee Ấn Độ';

  @override
  String get currencyVND => 'Đồng Việt Nam';

  @override
  String get currencyTRY => 'Lira Thổ Nhĩ Kỳ';

  @override
  String get currencyRUB => 'Ruble Nga';

  @override
  String get currencyBRL => 'Real Brazil';

  @override
  String get currencyMXN => 'Peso Mexico';

  @override
  String get addCurrency => 'Thêm tiền tệ';

  @override
  String get alreadyInFavorites => 'Đã có trong danh sách yêu thích';

  @override
  String get appInfo => 'Thông tin ứng dụng';

  @override
  String get versionInfo => 'Phiên bản 1.0.0';

  @override
  String get getLocationCurrency => 'Lấy tiền tệ từ vị trí';

  @override
  String get category => 'Danh mục';

  @override
  String get general => 'Chung';

  @override
  String get other => 'Khác';

  @override
  String get platform => 'Nền tảng';

  @override
  String get license => 'Giấy phép';

  @override
  String get developer => 'Nhà phát triển';

  @override
  String get contact => 'Liên hệ';

  @override
  String get website => 'Trang web';

  @override
  String get preview => 'Xem trước';

  @override
  String get start => 'Bắt đầu';

  @override
  String get manageFavoriteCurrencies => 'Quản lý tiền tệ yêu thích';

  @override
  String get allCurrencies => 'Tất cả tiền tệ';

  @override
  String get searchCurrencies => 'Tìm theo mã, tên hoặc quốc gia...';

  @override
  String get maxCurrenciesReached => 'Chỉ có thể chọn tối đa 10 tiền tệ';

  @override
  String currencyAddedToFavorites(String currency) {
    return '$currency đã được thêm vào yêu thích';
  }
}
