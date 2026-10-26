import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/user.dart';
import '../models/transaction.dart' as app_transaction;
import '../utils/constants.dart';

// ============================================================================
// DATABASE HELPER
// ============================================================================

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  DatabaseHelper._internal();

  factory DatabaseHelper() {
    return _instance;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), DatabaseConstants.databaseName);
    
    return await openDatabase(
      path,
      version: DatabaseConstants.databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // Create users table
    await db.execute('''
      CREATE TABLE ${DatabaseConstants.usersTable}(
        ${DatabaseConstants.columnUserId} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${DatabaseConstants.columnUserEmail} TEXT UNIQUE NOT NULL,
        ${DatabaseConstants.columnUserPasswordHash} TEXT NOT NULL,
        ${DatabaseConstants.columnUserName} TEXT NOT NULL,
        ${DatabaseConstants.columnUserCreatedAt} TEXT NOT NULL
      )
    ''');

    // Create transactions table
    await db.execute('''
      CREATE TABLE ${DatabaseConstants.transactionsTable}(
        ${DatabaseConstants.columnTransactionId} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${DatabaseConstants.columnTransactionUserId} INTEGER NOT NULL,
        ${DatabaseConstants.columnTransactionTitle} TEXT NOT NULL,
        ${DatabaseConstants.columnTransactionAmount} REAL NOT NULL,
        ${DatabaseConstants.columnTransactionCategory} TEXT NOT NULL,
        ${DatabaseConstants.columnTransactionDate} TEXT NOT NULL,
        createdAt TEXT NOT NULL,
        FOREIGN KEY (${DatabaseConstants.columnTransactionUserId}) 
          REFERENCES ${DatabaseConstants.usersTable} (${DatabaseConstants.columnUserId})
      )
    ''');
  }

  Future<void> close() async {
    final db = await database;
    db.close();
  }
}

// ============================================================================
// USER DAO
// ============================================================================

class UserDAO {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  // CREATE - Insert user
  Future<int> insertUser(User user) async {
    final db = await _dbHelper.database;
    return await db.insert(
      DatabaseConstants.usersTable,
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // READ - Get user by email
  Future<User?> getUserByEmail(String email) async {
    final db = await _dbHelper.database;
    final result = await db.query(
      DatabaseConstants.usersTable,
      where: '${DatabaseConstants.columnUserEmail} = ?',
      whereArgs: [email],
      limit: 1,
    );
    
    if (result.isEmpty) return null;
    return User.fromMap(result.first);
  }

  // READ - Get user by id
  Future<User?> getUserById(int id) async {
    final db = await _dbHelper.database;
    final result = await db.query(
      DatabaseConstants.usersTable,
      where: '${DatabaseConstants.columnUserId} = ?',
      whereArgs: [id],
      limit: 1,
    );
    
    if (result.isEmpty) return null;
    return User.fromMap(result.first);
  }

  // READ - Get all users
  Future<List<User>> getAllUsers() async {
    final db = await _dbHelper.database;
    final result = await db.query(DatabaseConstants.usersTable);
    return result.map((map) => User.fromMap(map)).toList();
  }

  // UPDATE - Update user
  Future<int> updateUser(User user) async {
    final db = await _dbHelper.database;
    return await db.update(
      DatabaseConstants.usersTable,
      user.toMap(),
      where: '${DatabaseConstants.columnUserId} = ?',
      whereArgs: [user.id],
    );
  }

  // DELETE - Delete user
  Future<int> deleteUser(int id) async {
    final db = await _dbHelper.database;
    return await db.delete(
      DatabaseConstants.usersTable,
      where: '${DatabaseConstants.columnUserId} = ?',
      whereArgs: [id],
    );
  }

  // Check if email exists
  Future<bool> emailExists(String email) async {
    final user = await getUserByEmail(email);
    return user != null;
  }

  // Get user count
  Future<int> getUserCount() async {
    final db = await _dbHelper.database;
    final result = await db.rawQuery('SELECT COUNT(*) FROM ${DatabaseConstants.usersTable}');
    return Sqflite.firstIntValue(result) ?? 0;
  }
}

// ============================================================================
// TRANSACTION DAO
// ============================================================================

class TransactionDAO {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  // CREATE - Insert transaction
  Future<int> insertTransaction(app_transaction.Transaction transaction) async {
    final db = await _dbHelper.database;
    return await db.insert(
      DatabaseConstants.transactionsTable,
      transaction.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // READ - Get all transactions for a user
  Future<List<app_transaction.Transaction>> getTransactionsByUserId(int userId) async {
    final db = await _dbHelper.database;
    final result = await db.query(
      DatabaseConstants.transactionsTable,
      where: '${DatabaseConstants.columnTransactionUserId} = ?',
      whereArgs: [userId],
      orderBy: '${DatabaseConstants.columnTransactionDate} DESC',
    );
    
    return result.map((map) => app_transaction.Transaction.fromMap(map)).toList();
  }

  // READ - Get recent transactions for a user (limit)
  Future<List<app_transaction.Transaction>> getRecentTransactionsByUserId(int userId, {int limit = 5}) async {
    final db = await _dbHelper.database;
    final result = await db.query(
      DatabaseConstants.transactionsTable,
      where: '${DatabaseConstants.columnTransactionUserId} = ?',
      whereArgs: [userId],
      orderBy: '${DatabaseConstants.columnTransactionDate} DESC',
      limit: limit,
    );
    
    return result.map((map) => app_transaction.Transaction.fromMap(map)).toList();
  }

  // READ - Get transaction by id
  Future<app_transaction.Transaction?> getTransactionById(int id) async {
    final db = await _dbHelper.database;
    final result = await db.query(
      DatabaseConstants.transactionsTable,
      where: '${DatabaseConstants.columnTransactionId} = ?',
      whereArgs: [id],
      limit: 1,
    );
    
    if (result.isEmpty) return null;
    return app_transaction.Transaction.fromMap(result.first);
  }

  // READ - Get transactions by category
  Future<List<app_transaction.Transaction>> getTransactionsByCategory(int userId, String category) async {
    final db = await _dbHelper.database;
    final result = await db.query(
      DatabaseConstants.transactionsTable,
      where: '${DatabaseConstants.columnTransactionUserId} = ? AND ${DatabaseConstants.columnTransactionCategory} = ?',
      whereArgs: [userId, category],
      orderBy: '${DatabaseConstants.columnTransactionDate} DESC',
    );
    
    return result.map((map) => app_transaction.Transaction.fromMap(map)).toList();
  }

  // UPDATE - Update transaction
  Future<int> updateTransaction(app_transaction.Transaction transaction) async {
    final db = await _dbHelper.database;
    return await db.update(
      DatabaseConstants.transactionsTable,
      transaction.toMap(),
      where: '${DatabaseConstants.columnTransactionId} = ?',
      whereArgs: [transaction.id],
    );
  }

  // DELETE - Delete transaction
  Future<int> deleteTransaction(int id) async {
    final db = await _dbHelper.database;
    return await db.delete(
      DatabaseConstants.transactionsTable,
      where: '${DatabaseConstants.columnTransactionId} = ?',
      whereArgs: [id],
    );
  }

  // DELETE - Delete all transactions for a user
  Future<int> deleteAllTransactionsByUserId(int userId) async {
    final db = await _dbHelper.database;
    return await db.delete(
      DatabaseConstants.transactionsTable,
      where: '${DatabaseConstants.columnTransactionUserId} = ?',
      whereArgs: [userId],
    );
  }

  // Get transaction count for a user
  Future<int> getTransactionCount(int userId) async {
    final db = await _dbHelper.database;
    final result = await db.rawQuery(
      'SELECT COUNT(*) FROM ${DatabaseConstants.transactionsTable} WHERE ${DatabaseConstants.columnTransactionUserId} = ?',
      [userId],
    );
    return Sqflite.firstIntValue(result) ?? 0;
  }
}
