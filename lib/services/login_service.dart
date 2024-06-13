import 'package:firebase_auth/firebase_auth.dart';

class LoginService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
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
