import 'package:flutter/material.dart';
import '../../services/services.dart';
import '../../utils/constants.dart';

class AddTransactionScreen extends StatefulWidget {
  final int userId;

  const AddTransactionScreen({super.key, required this.userId});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final _dateController = TextEditingController();
  final TransactionService _transactionService = TransactionService();

  String _selectedCategory = TransactionCategories.categories[0];
  DateTime _selectedDate = DateTime.now();
  bool _isLoading = false;

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null) {
      setState(() {
        _selectedDate = selectedDate;
        _dateController.text =
            '${selectedDate.day.toString().padLeft(2, '0')}/'
            '${selectedDate.month.toString().padLeft(2, '0')}/'
            '${selectedDate.year}';
      });
    }
  }

  Future<void> _handleSave() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final result = await _transactionService.addTransaction(
      userId: widget.userId,
      title: _titleController.text.trim(),
      amount: double.parse(_amountController.text),
      category: _selectedCategory,
      date: _selectedDate,
    );

    setState(() => _isLoading = false);

    if (!mounted) return;

    if (result['success']) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Transaksi Berhasil Disimpan!'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context, true); // Return true to refresh dashboard
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result['message']),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catat Transaksi'),
        backgroundColor: AppColors.accent,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Title field
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'Judul',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.title),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? 'Judul tidak boleh kosong' : null,
                ),
                const SizedBox(height: 16),
                // Amount field
                TextFormField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Nominal',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.attach_money),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) return 'Nominal tidak boleh kosong';
                    if (double.tryParse(value) == null) {
                      return 'Nominal harus berupa angka';
                    }
                    if (double.parse(value) == 0) {
                      return 'Nominal harus lebih dari 0';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                // Category dropdown
                DropdownButtonFormField<String>(
                  initialValue: _selectedCategory,
                  decoration: const InputDecoration(
                    labelText: 'Kategori',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.category),
                  ),
                  items: TransactionCategories.categories.map((category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Row(
                        children: [
                          Icon(
                            TransactionCategories.getCategoryIcon(category),
                            size: 20,
                            color: TransactionCategories.getCategoryColor(category),
                          ),
                          const SizedBox(width: 8),
                          Text(category),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() => _selectedCategory = value!);
                  },
                  validator: (value) =>
                      value == null ? 'Kategori harus dipilih' : null,
                ),
                const SizedBox(height: 16),
                // Date field
                TextFormField(
                  controller: _dateController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Tanggal',
                    hintText: 'DD/MM/YYYY',
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.calendar_today),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: _selectDate,
                    ),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? 'Tanggal wajib diisi!' : null,
                ),
                const SizedBox(height: 32),
                // Save button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: _isLoading ? null : _handleSave,
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : const Text(
                          'Simpan',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
