import 'package:firebase_auth/firebase_auth.dart';

/// Клас сутності користувача - описує дані про користувача
final class AppUser {
  final String uid;
  final String name;
  final String email;

  const AppUser({
    required this.uid,
    required this.name,
    required this.email,
  });

  factory AppUser.empty() {
    return AppUser(
      uid: '',
      name: '',
      email: '',
    );
  }

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      uid: json['uid'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
    );
  }

  factory AppUser.fromFirebaseUser(User user) => AppUser(
        uid: user.uid ?? '',
        name: user.displayName ?? '',
        email: user.email ?? '',
      );

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'name': name,
        'email': email,
      };

  AppUser copyWith({
    String? uid,
    String? name,
    String? email,
  }) {
    return AppUser(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }
}
