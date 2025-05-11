import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:monexo/models/models.dart';

/// Клас сутності транзакції - описує дані про транзакцію
final class TransactionModel {
  final String id;
  final String accountId;
  final CategoryModel? category;
  final String? description;
  final DateTime timestamp;
  final double amount;

  const TransactionModel({
    required this.id,
    required this.accountId,
    required this.category,
    required this.description,
    required this.timestamp,
    required this.amount,
  });

  factory TransactionModel.empty() => TransactionModel(
        id: '',
        accountId: '',
        category: null,
        description: '',
        timestamp: DateTime.now(),
        amount: 0,
      );

  factory TransactionModel.fromJson(Map<String, dynamic> json) => TransactionModel(
        id: json['id'] as String,
        accountId: json['accountId'] as String,
        category: json['category'] == null
            ? null
            : CategoryModel.fromJson(json['category'] as Map<String, dynamic>),
        description: json['description'],
        timestamp: (json['timestamp'] as Timestamp).toDate(),
        amount: double.parse(json['amount']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'accountId': accountId,
        'category': category?.toJson(),
        'description': description,
        'timestamp': timestamp,
        'amount': amount.toString(),
      };

  TransactionModel copyWith({
    String? id,
    String? accountId,
    CategoryModel? category,
    String? description,
    DateTime? timestamp,
    double? amount,
  }) {
    return TransactionModel(
      id: id ?? this.id,
      accountId: accountId ?? this.accountId,
      category: category ?? this.category,
      description: description ?? this.description,
      timestamp: timestamp ?? this.timestamp,
      amount: amount ?? this.amount,
    );
  }

  bool get isIncome => category?.type == CategoryType.income;
}
