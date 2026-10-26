import 'package:flutter/material.dart';
import '../../models/transaction.dart' as app_transaction;
import '../../services/services.dart';
import '../../utils/constants.dart';

class TransactionDetailScreen extends StatelessWidget {
  final app_transaction.Transaction transaction;

  const TransactionDetailScreen({
    super.key,
    required this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    final transactionService = TransactionService();
    // Determine type based on amount: positive = income, negative = expense
    final isIncome = transaction.amount >= 0;
    final amountColor = isIncome ? AppColors.success : AppColors.accent;
    final statusText = isIncome ? 'Pemasukan' : 'Pengeluaran';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Transaksi'),
        backgroundColor: AppColors.accent,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.receipt_long,
              size: 80,
              color: Colors.redAccent,
            ),
            const SizedBox(height: 24),
            Text(
              transaction.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              transactionService.formatCurrency(transaction.amount),
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: amountColor,
              ),
            ),
            const Divider(height: 40, thickness: 2),
            _buildDetailRow('Kategori', transaction.category),
            const SizedBox(height: 16),
            _buildDetailRow(
              'Tanggal',
              transactionService.formatDate(transaction.date),
            ),
            const SizedBox(height: 16),
            _buildDetailRow('Tipe', statusText),
            const SizedBox(height: 16),
            _buildDetailRow('Status', 'Berhasil'),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
