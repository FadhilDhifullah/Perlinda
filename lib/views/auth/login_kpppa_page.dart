import 'package:flutter/material.dart';
import 'package:flutter_perlinda/views/kpppa_home_page.dart';
import 'package:flutter_perlinda/services/login_kpppa_service.dart'; // Import the KPPPA LoginService

class LoginKPPAPage extends StatefulWidget {
  const LoginKPPAPage({Key? key}) : super(key: key);

  @override
  State<LoginKPPAPage> createState() => _LoginKPPAPageState();
}

class _LoginKPPAPageState extends State<LoginKPPAPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final LoginKPPPAService _loginService =
      LoginKPPPAService(); // Create an instance of LoginKPPPAService

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _showNotification(String message, bool isSuccess) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: isSuccess ? Colors.green : Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      try {
        await _loginService.login(
          _emailController.text,
          _passwordController.text,
        );
        _showNotification('Berhasil masuk!', true);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => KPPPAHomePage()),
        );
      } catch (e) {
        _showNotification(e.toString(), false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF4682A9),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 20.0),
                        width: 350.0,
                        height: 350.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF749BC2),
                        ),
                      ),
                      Positioned(
                        top: 70.0,
                        child: Container(
                          width: 270.0,
                          height: 270.0,
                          child: Image.asset(
                            'images/logo_perlinda.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  Container(
                    width: 430.0,
                    height: 585.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: Text(
                              'Masuk Sebagai Kemen PPPA',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                                color: Color(0xFF00355C),
                              ),
                            ),
                          ),
                          const SizedBox(height: 30.0),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: Text(
                                'Alamat Email',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF00355C),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 12.0),
                          TextFormField(
                            controller: _emailController,
                            decoration: const InputDecoration(
                              labelText: 'Masukkan alamat email',
                              border: InputBorder.none,
                              fillColor: Color(0xFFC1D9F1),
                              filled: true,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 15.0),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: Text(
                                'Kata Sandi',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF00355C),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 12.0),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: const InputDecoration(
                              labelText: 'Masukkan kata sandi',
                              border: InputBorder.none,
                              fillColor: Color(0xFFC1D9F1),
                              filled: true,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 5.0),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text(
                                        'Lupa Kata Sandi?',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF00355C),
                                        ),
                                      ),
                                      content: SingleChildScrollView(
                                        child: ListBody(
                                          children: [
                                            Text(
                                                'Masukkan alamat email Anda untuk pemulihan kata sandi.'),
                                            TextFormField(
                                              decoration: const InputDecoration(
                                                labelText: 'Email',
                                                border: OutlineInputBorder(),
                                              ),
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Please enter your email';
                                                }
                                                return null;
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Batal'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                    'Pemulihan kata sandi sedang dalam pengembangan.'),
                                              ),
                                            );
                                          },
                                          child: const Text('Kirim'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Text(
                                'Lupa Kata Sandi?',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF00355C),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          ElevatedButton(
                            onPressed: _login,
                            child: SizedBox(
                              width: 391.0,
                              height: 55.0,
                              child: Center(
                                child: const Text(
                                  'Masuk',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF4682A9),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
