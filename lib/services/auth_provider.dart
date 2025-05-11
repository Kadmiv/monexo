import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:monexo/models/models.dart';
import 'package:monexo/services/services.dart';
import 'package:monexo/services/user_provider.dart';

/// Сервіс авторизації користувача - використовується FirebaseAuth для авторизації користувачів
final class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;

  Future<AppUser?> get getUser async {
    try {
      final user = _auth.currentUser;
      if (user == null) return null;

      return AppUser.fromFirebaseUser(user);
    } catch (e) {
      debugPrint('Error getting user: $e');
      return null;
    }
  }

  Stream<AppUser?> get user => _auth.authStateChanges().map((user) {
        if (user == null) return null;
        try {
          return AppUser.fromFirebaseUser(user);
        } catch (e) {
          debugPrint('Error mapping user: $e');
          return null;
        }
      });

  Future<AppUser> signInWithGoogle() async {
    try {
      final googleSignIn = GoogleSignIn();
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        // User cancelled the sign-in
        throw Exception('Failed to Google auth');
      }

      final googleAuth = await googleUser.authentication;
      if (googleAuth.accessToken == null || googleAuth.idToken == null) {
        throw Exception('Failed to get Google auth tokens');
      }

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      return mapUserFromFirebaseUser(userCredential);
    } catch (e) {
      debugPrint('Error signing in with Google: $e');
      throw Exception('Failed to sign in with Google. Please try again later.');
    }
  }

  Future<AppUser> signInAnonymously() async {
    try {
      final userCredential = await _auth.signInAnonymously();

      if (userCredential.user == null) {
        throw Exception('Failed to get user from anonymous sign in');
      }

      final user = await mapUserFromFirebaseUser(userCredential);
      return user;
    } catch (e) {
      debugPrint('Error signing in anonymously: $e');
      throw Exception('Failed to sign in anonymously. Please try again later.');
    }
  }

  Future<AppUser> mapUserFromFirebaseUser(UserCredential userCredential) async {
    try {
      if (userCredential.user == null) {
        throw Exception('User credential is null');
      }

      final user = AppUser.fromFirebaseUser(userCredential.user!);
      final userService = UserProvider();
      await userService.init(user);

      return user;
    } catch (e) {
      debugPrint('Error mapping user: $e');
      throw Exception('Failed to map user data. Please try again.');
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      debugPrint('Error signing out: $e');
      throw Exception('Failed to sign out. Please try again later.');
    }
  }

  Future<void> updateProfile({String? displayName, String? photoURL}) async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        throw Exception('No user is currently signed in');
      }

      await user.updateDisplayName(displayName);
      await user.updatePhotoURL(photoURL);

      // Update user in database
      final userModel = await getUser;
      if (userModel != null) {
        final userService = UserProvider();
        await userService.updateUser(userModel.copyWith(name: displayName));
      }
    } catch (e) {
      debugPrint('Error updating profile: $e');
      throw Exception('Failed to update profile. Please try again later.');
    }
  }
}
