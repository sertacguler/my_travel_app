import 'package:flutter/material.dart';
import '../components/custom_text_field.dart';
import '../components/custom_button.dart';
import '../components/theme.dart';

class RegisterPage extends StatelessWidget {
  // TextEditingControllers for form fields
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

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
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 20),
              CustomTextField(
                hintText: "Password",
                controller: passwordController,
                obscureText: true, // Password field should obscure text
              ),
              SizedBox(height: 20),
              CustomTextField(
                hintText: "Confirm Password",
                controller: confirmPasswordController,
                obscureText: true, // Password field should obscure text
              ),
              SizedBox(height: 40),
              CustomButton(
                text: "Register",
                onPressed: () {
                  // You would typically also include form validation before navigating
                  if (passwordController.text == confirmPasswordController.text) {
                    Navigator.pushReplacementNamed(context, '/home'); // Adjust the route as needed
                  } else {
                    // Show an error message if passwords don't match
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text("Error"),
                        content: Text("Passwords do not match."),
                        actions: <Widget>[
                         TextButton(
      onPressed: () {
        Navigator.of(context).pop(); // Dismiss the dialog
      },
      child: Text("OK"),
    ),
                        ],
                      ),
                    );
                  }
                },
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/login'),
                child: Text(
                  "Already have an account? Login here",
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
}
