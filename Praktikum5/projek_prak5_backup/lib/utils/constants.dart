import 'package:flutter/material.dart';

// Colors
class AppColors {
  static const Color primary = Color(0xFFFFC107); // Amber
  static const Color primaryDark = Color(0xFFFFA000); // Amber dark
  static const Color accent = Color(0xFFF44336); // Red
  static const Color accentLight = Color(0xFFEF5350); // Red light
  static const Color success = Color(0xFF4CAF50); // Green
  static const Color warning = Color(0xFFFF9800); // Orange
  static const Color error = Color(0xFFD32F2F); // Dark red
  static const Color info = Color(0xFF2196F3); // Blue
  static const Color background = Color(0xFFFAFAFA);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color border = Color(0xFFBDBDBD);
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textHint = Color(0xFFBDBDBD);
}

// Transaction Categories
class TransactionCategories {
  static const List<String> categories = [
    'Makanan',
    'Transportasi',
    'Belanja',
    'Tagihan',
    'Pemasukan',
    'Hiburan',
    'Kesehatan',
    'Pendidikan',
    'Lainnya',
  ];

  static Color getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'makanan':
        return Colors.orange;
      case 'transportasi':
        return Colors.blue;
      case 'belanja':
        return Colors.purple;
      case 'tagihan':
        return Colors.yellow[700]!;
      case 'pemasukan':
        return Colors.green;
      case 'hiburan':
        return Colors.pink;
      case 'kesehatan':
        return Colors.red;
      case 'pendidikan':
        return Colors.indigo;
      default:
        return Colors.grey;
    }
  }

  static IconData getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'makanan':
        return Icons.fastfood;
      case 'transportasi':
        return Icons.directions_car;
      case 'belanja':
        return Icons.shopping_cart;
      case 'tagihan':
        return Icons.receipt;
      case 'pemasukan':
        return Icons.attach_money;
      case 'hiburan':
        return Icons.movie;
      case 'kesehatan':
        return Icons.local_hospital;
      case 'pendidikan':
        return Icons.school;
      default:
        return Icons.category;
    }
  }
}

// Validation patterns
class ValidationPatterns {
  static const String emailPattern =
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
  
  static bool isValidEmail(String email) {
    return RegExp(emailPattern).hasMatch(email);
  }

  static bool isValidPassword(String password) {
    return password.length >= 6;
  }

  static bool isValidName(String name) {
    return name.trim().isNotEmpty && name.length >= 2;
  }
}

// Database constants
class DatabaseConstants {
  static const String databaseName = 'expense_tracker.db';
  static const int databaseVersion = 1;
  
  // Users table
  static const String usersTable = 'users';
  static const String columnUserId = 'id';
  static const String columnUserEmail = 'email';
  static const String columnUserPasswordHash = 'passwordHash';
  static const String columnUserName = 'name';
  static const String columnUserCreatedAt = 'createdAt';
  
  // Transactions table
  static const String transactionsTable = 'transactions';
  static const String columnTransactionId = 'id';
  static const String columnTransactionUserId = 'userId';
  static const String columnTransactionTitle = 'title';
  static const String columnTransactionAmount = 'amount';
  static const String columnTransactionCategory = 'category';
  static const String columnTransactionDate = 'date';
  static const String columnTransactionCreatedAt = 'createdAt';
}

// Session constants
class SessionConstants {
  static const String keyUserId = 'userId';
  static const String keyUserEmail = 'userEmail';
  static const String keyUserName = 'userName';
}

// Route names
class RouteNames {
  static const String splash = '/splash';
  static const String login = '/login';
  static const String register = '/register';
  static const String main = '/main';
  static const String addTransaction = '/add';
  static const String transactionDetail = '/detail';
}
