import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:monexo/models/account.dart';
import 'package:monexo/models/models.dart';

class AccountProvider {
  static final AccountProvider _instance =
      AccountProvider._internal();

  factory AccountProvider() {
    return _instance;
  }

  AccountProvider._internal();

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  late  CollectionReference<Map<String, dynamic>> _accountCollection;

  init(AppUser user) {
    _accountCollection =
        _db.collection('users').doc(user.uid).collection('accounts');
  }

  // Stream<List<Account>> get accounts =>
  //     _accountCollection.snapshots().map((snapshot) =>
  //         snapshot.docs.map((doc) => Account.fromJson(doc.data())).toList());

  Future<void> createAccount(Account account) async {
    var doc = await _accountCollection.add(account.toJson());
    return doc.update({'id': doc.id});
  }

  Future<void> updateAccount(Account account) async {
    return _accountCollection.doc(account.id).update(account.toJson());
  }

  Future<void> deleteAccount(String accountId) async {
    return _accountCollection.doc(accountId).delete();
  }

  Future<Account> getAccount() async {
    final querySnapshot = await _accountCollection.get();
    if (querySnapshot.docs.isEmpty) {
      throw Exception('No accounts found');
    }
    final firstDoc = querySnapshot.docs.first;
    return Account.fromJson(firstDoc.data());
  }

  Stream<Account> listenAccount(String accountId) => _accountCollection
          .where('id', isEqualTo: accountId)
          .snapshots()
          .map((snapshot) {
        return Account.fromJson(snapshot.docs.first.data());
      });

  Future<bool> get hasAnyAccounts async =>
      (await _accountCollection.get()).docs.isNotEmpty;
}
