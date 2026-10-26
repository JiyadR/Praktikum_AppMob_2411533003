import 'package:flutter/material.dart';
import '../../services/services.dart';
import '../../models/transaction.dart' as app_transaction;
import '../../utils/constants.dart';
import '../transaction/transaction_detail_screen.dart';

class HistoryScreen extends StatefulWidget {
  final int userId;

  const HistoryScreen({super.key, required this.userId});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final TransactionService _transactionService = TransactionService();
  List<app_transaction.Transaction> _transactions = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTransactions();
  }

  Future<void> _loadTransactions() async {
    setState(() => _isLoading = true);

    final transactions = await _transactionService.getTransactions(widget.userId);

    setState(() {
      _transactions = transactions;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Transaksi'),
        backgroundColor: AppColors.accent,
        foregroundColor: Colors.white,
      ),
      body: RefreshIndicator(
        onRefresh: _loadTransactions,
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _transactions.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.history,
                          size: 64,
                          color: AppColors.textSecondary,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Belum ada riwayat transaksi',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  )
                : SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Semua Transaksi (${_transactions.length})',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildTransactionHistoryList(),
                      ],
                    ),
                  ),
      ),
    );
  }

  Widget _buildTransactionHistoryList() {
    return Column(
      children: List.generate(
        _transactions.length,
        (index) {
          final transaction = _transactions[index];
          final isIncome = transaction.amount >= 0;
          final amountColor = isIncome ? AppColors.success : AppColors.accent;
          final amountText = _transactionService.formatCurrency(transaction.amount);
          final categoryColor = TransactionCategories.getCategoryColor(transaction.category);
          final categoryIcon = TransactionCategories.getCategoryIcon(transaction.category);

          return GestureDetector(
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
            child: Card(
              elevation: 2,
              margin: const EdgeInsets.only(bottom: 12),
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
                    color: amountColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
