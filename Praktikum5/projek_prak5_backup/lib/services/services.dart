import 'package:bcrypt/bcrypt.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import '../models/transaction.dart';
import '../database/database.dart';
import '../utils/constants.dart';

// ============================================================================
// AUTH SERVICE
// ============================================================================

class AuthService {
  final UserDAO _userDAO = UserDAO();

  // Register user
  Future<Map<String, dynamic>> register({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      // Validate input
      if (!ValidationPatterns.isValidEmail(email)) {
        return {'success': false, 'message': 'Format email tidak valid'};
      }

      if (!ValidationPatterns.isValidPassword(password)) {
        return {
          'success': false,
          'message': 'Password minimal 6 karakter'
        };
      }

      if (!ValidationPatterns.isValidName(name)) {
        return {'success': false, 'message': 'Nama minimal 2 karakter'};
      }

      // Check if email already exists
      final exists = await _userDAO.emailExists(email);
      if (exists) {
        return {'success': false, 'message': 'Email sudah terdaftar'};
      }

      // Hash password
      final passwordHash = BCrypt.hashpw(password, BCrypt.gensalt());

      // Create user
      final user = User(
        email: email,
        passwordHash: passwordHash,
        name: name,
      );

      final userId = await _userDAO.insertUser(user);

      return {
        'success': true,
        'message': 'Registrasi berhasil',
        'userId': userId,
        'user': user.copyWith(id: userId),
      };
    } catch (e) {
      return {'success': false, 'message': 'Error: ${e.toString()}'};
    }
  }

  // Login user
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      // Validate input
      if (!ValidationPatterns.isValidEmail(email)) {
        return {'success': false, 'message': 'Format email tidak valid'};
      }

      if (password.isEmpty) {
        return {'success': false, 'message': 'Password tidak boleh kosong'};
      }

      // Get user by email
      final user = await _userDAO.getUserByEmail(email);
      if (user == null) {
        return {'success': false, 'message': 'Email tidak terdaftar'};
      }

      // Verify password
      final isPasswordValid = BCrypt.checkpw(password, user.passwordHash);
      if (!isPasswordValid) {
        return {'success': false, 'message': 'Password salah'};
      }

      return {
        'success': true,
        'message': 'Login berhasil',
        'userId': user.id!,
        'user': user,
      };
    } catch (e) {
      return {'success': false, 'message': 'Error: ${e.toString()}'};
    }
  }
}

// ============================================================================
// SESSION SERVICE
// ============================================================================

class SessionService {
  // Save user session
  Future<void> saveSession({
    required int userId,
    required String email,
    required String name,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(SessionConstants.keyUserId, userId);
    await prefs.setString(SessionConstants.keyUserEmail, email);
    await prefs.setString(SessionConstants.keyUserName, name);
  }

  // Get user ID from session
  Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(SessionConstants.keyUserId);
  }

  // Get user email from session
  Future<String?> getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(SessionConstants.keyUserEmail);
  }

  // Get user name from session
  Future<String?> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(SessionConstants.keyUserName);
  }

  // Get all session data
  Future<Map<String, dynamic>?> getSession() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt(SessionConstants.keyUserId);
    
    if (userId == null) return null;

    return {
      'userId': userId,
      'email': prefs.getString(SessionConstants.keyUserEmail),
      'name': prefs.getString(SessionConstants.keyUserName),
    };
  }

  // Check if user is logged in
  Future<bool> isLoggedIn() async {
    final userId = await getUserId();
    return userId != null;
  }

  // Clear session (logout)
  Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(SessionConstants.keyUserId);
    await prefs.remove(SessionConstants.keyUserEmail);
    await prefs.remove(SessionConstants.keyUserName);
  }
}

// ============================================================================
// TRANSACTION SERVICE
// ============================================================================

class TransactionService {
  final TransactionDAO _transactionDAO = TransactionDAO();

  // Add transaction
  Future<Map<String, dynamic>> addTransaction({
    required int userId,
    required String title,
    required double amount,
    required String category,
    required DateTime date,
  }) async {
    try {
      if (title.trim().isEmpty) {
        return {'success': false, 'message': 'Judul tidak boleh kosong'};
      }

      if (amount <= 0) {
        return {'success': false, 'message': 'Nominal harus lebih dari 0'};
      }

      if (category.isEmpty) {
        return {'success': false, 'message': 'Kategori harus dipilih'};
      }

      // Determine if this is income or expense based on category
      final isIncome = category.toLowerCase() == 'pemasukan';
      
      // Set amount: positive for income, negative for expense
      // No balance validation - allow negative balance (debt tracking)
      final finalAmount = isIncome ? amount : -amount;

      final transaction = Transaction(
        userId: userId,
        title: title.trim(),
        amount: finalAmount,
        category: category,
        date: date,
      );

      final transactionId = await _transactionDAO.insertTransaction(transaction);

      return {
        'success': true,
        'message': 'Transaksi berhasil ditambahkan',
        'transactionId': transactionId,
      };
    } catch (e) {
      return {'success': false, 'message': 'Error: ${e.toString()}'};
    }
  }

  // Get transactions for user
  Future<List<Transaction>> getTransactions(int userId) async {
    try {
      return await _transactionDAO.getTransactionsByUserId(userId);
    } catch (e) {
      return [];
    }
  }

  // Get recent transactions
  Future<List<Transaction>> getRecentTransactions(int userId, {int limit = 5}) async {
    try {
      return await _transactionDAO.getRecentTransactionsByUserId(userId, limit: limit);
    } catch (e) {
      return [];
    }
  }

  // Calculate balance
  Future<double> calculateBalance(int userId) async {
    try {
      final transactions = await _transactionDAO.getTransactionsByUserId(userId);
      double balance = 0;
      for (var transaction in transactions) {
        balance += transaction.amount;
      }
      return balance;
    } catch (e) {
      return 0.0;
    }
  }

  // Format currency
  String formatCurrency(double amount) {
    final isNegative = amount < 0;
    final absoluteAmount = amount.abs();
    final formattedAmount = absoluteAmount.toStringAsFixed(0).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    );
    return '${isNegative ? '-' : ''}Rp $formattedAmount';
  }

  // Format date
  String formatDate(DateTime date) {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
      'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des'
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }
}
