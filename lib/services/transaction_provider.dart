import 'package:cloud_firestore/cloud_firestore.dart' hide Transaction;
import 'package:collection/collection.dart';
import 'package:monexo/models/models.dart';

class TransactionProvider {
  static final TransactionProvider _instance =
      TransactionProvider._internal();

  factory TransactionProvider() {
    return _instance;
  }

  TransactionProvider._internal();

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  late CollectionReference<Map<String, dynamic>> _transactionCollection;

  init(AppUser user) {
    _transactionCollection =
        _db.collection('users').doc(user.uid).collection('transactions');
  }


  Future<void> addTransaction(TransactionModel transaction) async {
    var doc = await _transactionCollection.add(transaction.toJson());
    return doc.update({'id': doc.id});
  }

  Future<void> updateTransaction(TransactionModel transaction) {
    return _transactionCollection
        .doc(transaction.id)
        .update(transaction.toJson());
  }

  Future<void> deleteTransaction(TransactionModel transaction) async {
    await _transactionCollection.doc(transaction.id).delete();
  }

  Map<DateTime, List<TransactionModel>> groupTransactionsByDate(
    List<TransactionModel> transactions,
  ) {
    return groupBy<TransactionModel, DateTime>(transactions, (txn) {
      return DateTime(txn.timestamp.year, txn.timestamp.month, txn.timestamp.day);
    });
  }

  Future<List<TransactionModel>> getAccountTransactions(String accountId) async {
    final snapshot = await _transactionCollection
        .where('accountId', isEqualTo: accountId)
        .orderBy('timestamp', descending: true)
        .get();

    return snapshot.docs.map((doc) {
      return TransactionModel.fromJson(doc.data());
    }).toList();
  }

  double calculateAccountBalance(List<TransactionModel> transactions) {
    if (transactions.isEmpty) {
      return 0;
    }
    return transactions.map((item) => item.amount).reduce((a, b) => a + b);
  }

  Stream<List<TransactionModel>> accountTransactionsStream(String accountId) =>
      _transactionCollection
          .where('accountId', isEqualTo: accountId)
          .orderBy('timestamp', descending: true)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs.map((doc) {
          return TransactionModel.fromJson(doc.data());
        }).toList();
      });

}
