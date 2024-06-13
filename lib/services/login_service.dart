import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> login(String email, String password) async {
    try {
      // Attempt to sign in with email and password
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Get the user ID
      String userId = userCredential.user!.uid;

      // Check if the user exists in the "users" collection
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(userId).get();

      if (!userDoc.exists) {
        // User is not in the "users" collection, sign out and throw an exception
        await _auth.signOut();
        throw Exception('User does not have access. Please contact support.');
      }

      // User is in the "users" collection, proceed with login
    } on FirebaseAuthException catch (e) {
      String message;
      if (e.code == 'user-not-found') {
        message =
            'Pengguna tidak ditemukan. Pastikan email sudah benar atau daftar akun baru.';
      } else if (e.code == 'wrong-password') {
        message = 'Kata sandi salah. Silakan coba lagi.';
      } else if (e.code == 'invalid-email') {
        message =
            'Format email tidak valid. Pastikan kamu memasukkan email dengan benar.';
      } else {
        message = 'Terjadi kesalahan. Silakan coba lagi.';
      }
      throw Exception(message);
    } catch (e) {
      throw Exception('Terjadi kesalahan. Silakan coba lagi.');
    }
  }
}
