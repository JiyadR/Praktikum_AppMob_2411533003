import 'package:flutter/material.dart';
import '../../services/services.dart';
import '../../models/transaction.dart' as app_transaction;
import '../../utils/constants.dart';
import '../transaction/transaction_detail_screen.dart';
import '../transaction/add_transaction_screen.dart';

class DashboardScreen extends StatefulWidget {
  final int userId;

  const DashboardScreen({super.key, required this.userId});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final TransactionService _transactionService = TransactionService();
  double _balance = 0.0;
  List<app_transaction.Transaction> _recentTransactions = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);

    final balance = await _transactionService.calculateBalance(widget.userId);
    final transactions = await _transactionService.getRecentTransactions(widget.userId, limit: 5);

    setState(() {
      _balance = balance;
      _recentTransactions = transactions;
      _isLoading = false;
    });
  }

  Future<void> _navigateToAddTransaction() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddTransactionScreen(userId: widget.userId),
      ),
    );

    // Refresh data if transaction was added
    if (result == true) {
      _loadData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Keuangan'),
        backgroundColor: AppColors.accent,
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddTransaction,
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: _loadData,
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Halo, Selamat Datang!',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    _buildBalanceCard(),
                    const SizedBox(height: 20),
                    const Text(
                      'Transaksi Terakhir',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    _recentTransactions.isEmpty
                        ? _buildEmptyState()
                        : _buildTransactionList(),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildBalanceCard() {
    return Card(
      elevation: 4,
      color: AppColors.accentLight,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Saldo Utama',
              style: TextStyle(fontSize: 16, color: Colors.white70),
            ),
            const SizedBox(height: 8),
            Text(
              _transactionService.formatCurrency(_balance),
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            Icon(
              Icons.receipt_long,
              size: 64,
              color: AppColors.textSecondary,
            ),
            const SizedBox(height: 16),
            Text(
              'Belum ada transaksi',
              style: TextStyle(
                fontSize: 16,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Tekan tombol + untuk menambah transaksi',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textHint,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionList() {
    return Column(
      children: _recentTransactions.map((transaction) {
        final isIncome = transaction.amount >= 0;
        final color = isIncome ? AppColors.success : AppColors.accent;
        final amountText = _transactionService.formatCurrency(transaction.amount);
        final categoryColor = TransactionCategories.getCategoryColor(transaction.category);
        final categoryIcon = TransactionCategories.getCategoryIcon(transaction.category);

        return Card(
          elevation: 2,
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: categoryColor,
              child: Icon(categoryIcon, color: Colors.white),
            ),
            title: Text(
              transaction.title,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
              _transactionService.formatDate(transaction.date),
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            trailing: Text(
              amountText,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TransactionDetailScreen(
                    transaction: transaction,
                  ),
                ),
              );
            },
          ),
        );
      }).toList(),
    );
  }
}
