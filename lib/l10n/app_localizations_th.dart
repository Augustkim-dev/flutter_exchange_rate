// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Thai (`th`).
class AppLocalizationsTh extends AppLocalizations {
  AppLocalizationsTh([String locale = 'th']) : super(locale);

  @override
  String get appTitle => 'เครื่องคิดอัตราแลกเปลี่ยน';

  @override
  String get settings => 'การตั้งค่า';

  @override
  String get language => 'ภาษา';

  @override
  String get darkMode => 'โหมดมืด';

  @override
  String get refreshRates => 'รีเฟรชอัตราแลกเปลี่ยน';

  @override
  String lastUpdated(String time) {
    return 'อัปเดตล่าสุด: $time';
  }

  @override
  String get selectCurrency => 'เลือกสกุลเงิน';

  @override
  String get favorites => 'รายการโปรด';

  @override
  String get aboutApp => 'เกี่ยวกับ';

  @override
  String get feedback => 'ความคิดเห็น';

  @override
  String get offlineMode => 'โหมดออฟไลน์ - ใช้ข้อมูลที่บันทึกไว้';

  @override
  String inputAmount(String currency) {
    return 'ใส่จำนวนเงิน $currency';
  }

  @override
  String get noInternetConnection => 'กรุณาตรวจสอบการเชื่อมต่ออินเทอร์เน็ต';

  @override
  String get cacheDataDeleted => 'ลบแคชแล้ว';

  @override
  String get confirmDeleteCache =>
      'ลบข้อมูลอัตราแลกเปลี่ยนที่บันทึกไว้ทั้งหมด?';

  @override
  String get cancel => 'ยกเลิก';

  @override
  String get delete => 'ลบ';

  @override
  String get retry => 'ลองใหม่';

  @override
  String get error => 'ข้อผิดพลาด';

  @override
  String get loading => 'กำลังโหลด...';

  @override
  String get welcome => 'ยินดีต้อนรับ';

  @override
  String get getStarted => 'เริ่มต้น';

  @override
  String get selectHomeCurrency => 'เลือกสกุลเงินหลัก';

  @override
  String get selectDefaultCurrencies => 'เลือกสกุลเงินเริ่มต้น';

  @override
  String get continueButton => 'ดำเนินการต่อ';

  @override
  String get skip => 'ข้าม';

  @override
  String get next => 'ถัดไป';

  @override
  String get justNow => 'เมื่อสักครู่';

  @override
  String minutesAgo(int count) {
    return '$count นาทีที่แล้ว';
  }

  @override
  String hoursAgo(int count) {
    return '$count ชั่วโมงที่แล้ว';
  }

  @override
  String get realtimeExchangeRate => 'อัตราแลกเปลี่ยนแบบเรียลไทม์';

  @override
  String get developerInfo => 'ข้อมูลนักพัฒนา';

  @override
  String get sendFeedback => 'ส่งความคิดเห็น';

  @override
  String get manageAppSettings => 'จัดการการตั้งค่าแอป';

  @override
  String get changeLanguage => 'เปลี่ยนภาษา';

  @override
  String get darkModeEnabled => 'เปิดใช้งานโหมดมืด';

  @override
  String get lightModeEnabled => 'เปิดใช้งานโหมดสว่าง';

  @override
  String get notifications => 'การตั้งค่าการแจ้งเตือน';

  @override
  String get receiveRateAlerts => 'รับการแจ้งเตือนการเปลี่ยนแปลงอัตรา';

  @override
  String get autoRefresh => 'รีเฟรชอัตโนมัติ';

  @override
  String get updateEvery5Minutes => 'อัปเดตอัตราทุก 5 นาที';

  @override
  String get favoriteCurrencies => 'สกุลเงินโปรด';

  @override
  String currentFavorites(int count) {
    return 'ปัจจุบันมี $count สกุลเงินที่บันทึกไว้';
  }

  @override
  String get usingCachedData => 'ใช้ข้อมูลแคช';

  @override
  String get refresh => 'รีเฟรช';

  @override
  String get ratesUpdated => 'อัปเดตอัตราแลกเปลี่ยนแล้ว';

  @override
  String get updateFailed => 'อัปเดตล้มเหลว';

  @override
  String get version => 'เวอร์ชัน';

  @override
  String get inputting => 'กำลังใส่';

  @override
  String get cacheDeletion => 'ลบแคช';

  @override
  String get loadingRates => 'กำลังโหลดอัตราแลกเปลี่ยน...';

  @override
  String get unknownError => 'เกิดข้อผิดพลาดที่ไม่ทราบสาเหตุ';

  @override
  String get retryLoading => 'ลองใหม่';

  @override
  String get amount => 'จำนวนเงิน';

  @override
  String get enterAmount => 'ใส่จำนวนเงิน';

  @override
  String get clear => 'ล้าง';

  @override
  String get update => 'อัปเดต';

  @override
  String get currencyUSD => 'ดอลลาร์สหรัฐ';

  @override
  String get currencyEUR => 'ยูโร';

  @override
  String get currencyJPY => 'เยนญี่ปุ่น';

  @override
  String get currencyGBP => 'ปอนด์อังกฤษ';

  @override
  String get currencyKRW => 'วอนเกาหลี';

  @override
  String get currencyCNY => 'หยวนจีน';

  @override
  String get currencyAUD => 'ดอลลาร์ออสเตรเลีย';

  @override
  String get currencyCAD => 'ดอลลาร์แคนาดา';

  @override
  String get currencyCHF => 'ฟรังก์สวิส';

  @override
  String get currencyHKD => 'ดอลลาร์ฮ่องกง';

  @override
  String get currencyNZD => 'ดอลลาร์นิวซีแลนด์';

  @override
  String get currencySEK => 'โครนาสวีเดน';

  @override
  String get currencyNOK => 'โครนนอร์เวย์';

  @override
  String get currencyDKK => 'โครนเดนมาร์ก';

  @override
  String get currencySGD => 'ดอลลาร์สิงคโปร์';

  @override
  String get currencyTHB => 'บาทไทย';

  @override
  String get currencyMYR => 'ริงกิตมาเลเซีย';

  @override
  String get currencyIDR => 'รูเปียห์อินโดนีเซีย';

  @override
  String get currencyPHP => 'เปโซฟิลิปปินส์';

  @override
  String get currencyINR => 'รูปีอินเดีย';

  @override
  String get currencyVND => 'ด่องเวียดนาม';

  @override
  String get currencyTRY => 'ลีราตุรกี';

  @override
  String get currencyRUB => 'รูเบิลรัสเซีย';

  @override
  String get currencyBRL => 'เรอัลบราซิล';

  @override
  String get currencyMXN => 'เปโซเม็กซิโก';

  @override
  String get addCurrency => 'เพิ่มสกุลเงิน';

  @override
  String get alreadyInFavorites => 'มีอยู่ในรายการโปรดแล้ว';

  @override
  String get appInfo => 'ข้อมูลแอป';

  @override
  String get versionInfo => 'เวอร์ชัน 1.0.0';

  @override
  String get getLocationCurrency => 'รับสกุลเงินจากตำแหน่ง';

  @override
  String get category => 'หมวดหมู่';

  @override
  String get general => 'ทั่วไป';

  @override
  String get other => 'อื่นๆ';

  @override
  String get platform => 'แพลตฟอร์ม';

  @override
  String get license => 'ใบอนุญาต';

  @override
  String get developer => 'นักพัฒนา';

  @override
  String get contact => 'ติดต่อ';

  @override
  String get website => 'เว็บไซต์';

  @override
  String get preview => 'ดูตัวอย่าง';

  @override
  String get start => 'เริ่ม';

  @override
  String get manageFavoriteCurrencies => 'จัดการสกุลเงินโปรด';

  @override
  String get allCurrencies => 'สกุลเงินทั้งหมด';

  @override
  String get searchCurrencies => 'ค้นหาด้วยรหัส ชื่อ หรือประเทศ...';

  @override
  String get maxCurrenciesReached => 'เลือกได้สูงสุด 10 สกุลเงิน';

  @override
  String currencyAddedToFavorites(String currency) {
    return '$currency ถูกเพิ่มเข้ารายการโปรดแล้ว';
  }
}
