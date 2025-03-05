import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  // Singleton instance
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  // Getter for database (initialize if null)
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('tourism_app.db');
    return _database!;
  }

  // Initialize the database
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  // Create tables in the database
  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';

    // Creating a users table
    await db.execute('''
      CREATE TABLE users (
        id $idType,
        name $textType,
        email $textType,
        password $textType
      )
    ''');

    // Creating a bookings table
    await db.execute('''
      CREATE TABLE bookings (
        id $idType,
        destinationTitle $textType,
        description $textType,
        price $textType,
        imageUrl $textType,
        location $textType,
        name $textType,
        email $textType,
        phone $textType,
        checkInDate TEXT
      )
    ''');
  }

  /////////// User CRUD Methods ///////////

  // Insert a user into the users table
  Future<int> insertUser(Map<String, dynamic> row) async {
    final db = await instance.database;
    return await db.insert('users', row);
  }

  // Query all users from the users table
  Future<List<Map<String, dynamic>>> queryAllUsers() async {
    final db = await instance.database;
    return await db.query('users');
  }

  // Update a user by id
  Future<int> updateUser(int id, Map<String, dynamic> row) async {
    final db = await instance.database;
    return await db.update('users', row, where: 'id = ?', whereArgs: [id]);
  }

  // Delete a user by id
  Future<int> deleteUser(int id) async {
    final db = await instance.database;
    return await db.delete('users', where: 'id = ?', whereArgs: [id]);
  }

  /////////// Booking CRUD Methods ///////////

  // Insert a booking into the bookings table
  Future<int> insertBooking(Map<String, dynamic> row) async {
    final db = await instance.database;
    return await db.insert('bookings', row);
  }

  // Query all bookings from the bookings table
  Future<List<Map<String, dynamic>>> queryAllBookings() async {
    final db = await instance.database;
    return await db.query('bookings');
  }

  // Update a booking by id
  Future<int> updateBooking(int id, Map<String, dynamic> row) async {
    final db = await instance.database;
    return await db.update('bookings', row, where: 'id = ?', whereArgs: [id]);
  }

  // Delete a booking by id
  Future<int> deleteBooking(int id) async {
    final db = await instance.database;
    return await db.delete('bookings', where: 'id = ?', whereArgs: [id]);
  }

  // Close the database
  Future close() async {
    final db = await instance.database;
    return db.close();
  }
}
