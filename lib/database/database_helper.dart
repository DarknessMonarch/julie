import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:jolie/models/bookings.dart';
import 'package:jolie/models/date_available.dart';


class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final String path = join(await getDatabasesPath(), 'app_julie_database.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE bookings(
        id INTEGER PRIMARY KEY,
        date TEXT,
        email TEXT,
        contact TEXT
      )
    ''');
    await db.execute('''
      CREATE TABLE available_dates(
        date TEXT PRIMARY KEY
      )
    ''');
  }

  Future<void> insertBooking(BookingModel booking) async {
    final db = await database;
    await db.insert('bookings', booking.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<BookingModel>> getBookings() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('bookings');
    return List.generate(maps.length, (i) {
      return BookingModel.fromMap(maps[i]);
    });
  }

  Future<void> deleteBooking(String id) async {
    final db = await database;
    await db.delete('bookings', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> insertAvailableDate(AvailableDateModel availableDate) async {
    final db = await database;
    await db.insert('available_dates', availableDate.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<AvailableDateModel>> getAvailableDates() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('available_dates');
    return List.generate(maps.length, (i) {
      return AvailableDateModel.fromMap(maps[i]);
    });
  }

  Future<void> deleteAvailableDate(String date) async {
    final db = await database;
    await db.delete('available_dates', where: 'date = ?', whereArgs: [date]);
  }
}
