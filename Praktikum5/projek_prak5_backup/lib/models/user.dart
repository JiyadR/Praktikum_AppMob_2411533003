class User {
  final int? id;
  final String email;
  final String passwordHash;
  final String name;
  final DateTime createdAt;

  User({
    this.id,
    required this.email,
    required this.passwordHash,
    required this.name,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  // Convert to Map for database insert/update
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'passwordHash': passwordHash,
      'name': name,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  // Convert from Map (database result)
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      email: map['email'],
      passwordHash: map['passwordHash'],
      name: map['name'],
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  // Copy with method for creating modified copies
  User copyWith({
    int? id,
    String? email,
    String? passwordHash,
    String? name,
    DateTime? createdAt,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      passwordHash: passwordHash ?? this.passwordHash,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  String toString() {
    return 'User(id: $id, email: $email, name: $name, createdAt: $createdAt)';
  }
}
