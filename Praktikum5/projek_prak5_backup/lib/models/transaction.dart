class Transaction {
  final int? id;
  final int userId;
  final String title;
  final double amount;
  final String category;
  final DateTime date;
  final DateTime createdAt;

  Transaction({
    this.id,
    required this.userId,
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  // Convert to Map for database insert/update
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'amount': amount,
      'category': category,
      'date': date.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
    };
  }

  // Convert from Map (database result)
  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map['id'],
      userId: map['userId'],
      title: map['title'],
      amount: map['amount'],
      category: map['category'],
      date: DateTime.parse(map['date']),
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  @override
  String toString() {
    return 'Transaction(id: $id, userId: $userId, title: $title, amount: $amount, category: $category, date: $date)';
  }
}
