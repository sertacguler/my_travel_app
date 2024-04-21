import 'package:flutter/material.dart';
import '../components/custom_text_field.dart';
import '../components/custom_button.dart';
import '../components/theme.dart';
import '../services/loginUser.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CustomTextField(
                hintText: "Email",
                controller: _emailController,  // Kontrolcüyü bağla
              ),
              SizedBox(height: 20),
              CustomTextField(
                hintText: "Password",
                controller: _passwordController,  // Kontrolcüyü bağla
              ),
              SizedBox(height: 40),
              CustomButton(
                text: "Login",
                onPressed: () {
                  String email = _emailController.text;  // Email değerini al
                  String password = _passwordController.text;  // Şifre değerini al
                  loginUser(context, email, password);  // Giriş fonksiyonunu çağır
                },
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/register'),
                child: Text(
                  "Don't have an account? Register here",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.navyBlue,
                      fontFamily: 'Oswald'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();  // Kontrolcüleri temizle
    _passwordController.dispose();
    super.dispose();
  }
}
