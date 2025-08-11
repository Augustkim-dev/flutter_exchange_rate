import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:convert';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'exchange_rates.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE exchange_rates (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        base_currency TEXT NOT NULL,
        rates_json TEXT NOT NULL,
        last_updated TEXT NOT NULL,
        created_at TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE metadata (
        key TEXT PRIMARY KEY,
        value TEXT NOT NULL,
        updated_at TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE INDEX idx_base_currency ON exchange_rates(base_currency);
    ''');

    await db.execute('''
      CREATE INDEX idx_last_updated ON exchange_rates(last_updated);
    ''');
  }

  // 환율 데이터 저장
  Future<int> insertExchangeRate({
    required String baseCurrency,
    required Map<String, dynamic> rates,
    required DateTime lastUpdated,
  }) async {
    final db = await database;
    
    // 기존 데이터 삭제 (같은 base_currency)
    await db.delete(
      'exchange_rates',
      where: 'base_currency = ?',
      whereArgs: [baseCurrency],
    );

    return await db.insert(
      'exchange_rates',
      {
        'base_currency': baseCurrency,
        'rates_json': jsonEncode(rates),
        'last_updated': lastUpdated.toIso8601String(),
        'created_at': DateTime.now().toIso8601String(),
      },
    );
  }

  // 환율 데이터 조회
  Future<Map<String, dynamic>?> getExchangeRate(String baseCurrency) async {
    final db = await database;
    final results = await db.query(
      'exchange_rates',
      where: 'base_currency = ?',
      whereArgs: [baseCurrency],
      orderBy: 'last_updated DESC',
      limit: 1,
    );

    if (results.isEmpty) return null;

    final row = results.first;
    return {
      'base_currency': row['base_currency'],
      'rates': jsonDecode(row['rates_json'] as String),
      'last_updated': DateTime.parse(row['last_updated'] as String),
      'created_at': DateTime.parse(row['created_at'] as String),
    };
  }

  // 캐시 유효성 검증 (24시간)
  Future<bool> isCacheValid(String baseCurrency) async {
    final data = await getExchangeRate(baseCurrency);
    if (data == null) return false;

    final lastUpdated = data['last_updated'] as DateTime;
    final now = DateTime.now();
    final difference = now.difference(lastUpdated);

    // 24시간 이내인지 확인
    return difference.inHours < 24;
  }

  // 메타데이터 저장
  Future<void> setMetadata(String key, String value) async {
    final db = await database;
    await db.insert(
      'metadata',
      {
        'key': key,
        'value': value,
        'updated_at': DateTime.now().toIso8601String(),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // 메타데이터 조회
  Future<String?> getMetadata(String key) async {
    final db = await database;
    final results = await db.query(
      'metadata',
      where: 'key = ?',
      whereArgs: [key],
    );

    if (results.isEmpty) return null;
    return results.first['value'] as String;
  }

  // 마지막 동기화 시간 저장
  Future<void> setLastSyncTime(DateTime time) async {
    await setMetadata('last_sync_time', time.toIso8601String());
  }

  // 마지막 동기화 시간 조회
  Future<DateTime?> getLastSyncTime() async {
    final value = await getMetadata('last_sync_time');
    if (value == null) return null;
    return DateTime.parse(value);
  }

  // 모든 캐시된 통화 목록 조회
  Future<List<String>> getCachedCurrencies() async {
    final db = await database;
    final results = await db.query(
      'exchange_rates',
      columns: ['base_currency'],
      distinct: true,
    );

    return results.map((row) => row['base_currency'] as String).toList();
  }

  // 오래된 데이터 정리 (7일 이상)
  Future<int> cleanOldData() async {
    final db = await database;
    final sevenDaysAgo = DateTime.now().subtract(Duration(days: 7));

    return await db.delete(
      'exchange_rates',
      where: 'last_updated < ?',
      whereArgs: [sevenDaysAgo.toIso8601String()],
    );
  }

  // 모든 데이터 삭제
  Future<void> clearAllData() async {
    final db = await database;
    await db.delete('exchange_rates');
    await db.delete('metadata');
  }

  // 데이터베이스 닫기
  Future<void> close() async {
    final db = await database;
    await db.close();
    _database = null;
  }
}