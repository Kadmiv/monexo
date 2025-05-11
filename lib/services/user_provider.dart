import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:monexo/models/models.dart';

class UserProvider {
  static final UserProvider _instance = UserProvider._internal();

  factory UserProvider() {
    return _instance;
  }

  UserProvider._internal();

  FirebaseFirestore _db = FirebaseFirestore.instance;

  late DocumentReference<Map<String, dynamic>> _userDocument;

  late AppUser _user;

  AppUser getCurrentUser() => _user;

  init(AppUser user) {
    _userDocument = _db.collection('users').doc(user.uid);
    this._user = user;
  }

  Future<AppUser> getUserInfo() async {
    final doc = await _userDocument.get();
    final data = doc.data() ?? {};
    if (data.isEmpty) {
      return AppUser.empty().copyWith(uid: doc.id);
    }
    return AppUser.fromJson(data);
  }

  Stream<AppUser> get userDocument => _userDocument
      .snapshots()
      .map((doc) => AppUser.fromJson(doc.data() ?? {}));

  Future<bool> get checkIfUserExists async {
    try {
      var snapshot = await _userDocument.get();
      return snapshot.exists;
    } catch (e) {
      return false;
    }
  }

  Future<void> createUser(AppUser user) async {
    final userData = user.toJson();
    return await _userDocument.set(userData, SetOptions(merge: true));
  }

  Future<void> updateUser(AppUser user) async {
    final userData = user.toJson();
    return _userDocument.update(userData);
  }
}
