import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_tutorial2/constants/style.dart';
import 'package:flutter_web_tutorial2/routing/routes.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_web_tutorial2/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_web_tutorial2/pages/authentication/authentication.dart';

// ignore: use_key_in_widget_constructors
class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool isPasswordValid(String password) {
    // Sprawdza czy hasło zawiera co najmniej 8 znaków, wielką literę i znak specjalny
    final RegExp regex = RegExp(r'^(?=.*[A-Z])(?=.*[!@#$%^&*(),.?":{}|<>]).{8,}$');
    return regex.hasMatch(password);
  }

  void register() {
    if (_formKey.currentState!.validate()) {
      // Jeśli formularz jest poprawny, można przeprowadzić rejestrację użytkownika
      Get.snackbar('Success', 'Registration successful');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) => Scaffold(
        body: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400),
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: Image.asset("assets/icons/logo_64.png"),
                      ),
                      Expanded(child: Container())
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      Text(
                        "Register",
                        style: GoogleFonts.roboto(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: "Email",
                      hintText: "abc@domain.com",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }
                      if (!isPasswordValid(value)) {
                        return 'Password must be at least 8 characters, include an uppercase letter and a special character';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: confirmPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Confirm Password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your password';
                      }
                      if (value != passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  InkWell(
                    onTap: register,
                    child: Container(
                      decoration: BoxDecoration(
                        color: active,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      alignment: Alignment.center,
                      width: double.maxFinite,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: const Text(
                        "Register",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        color: themeProvider.isDarkMode
                            ? Colors.white
                            : dark(context),
                      ),
                      children: [
                        TextSpan(
                          text: "Already have an account? ",
                          style: TextStyle(
                            color: themeProvider.isDarkMode
                                ? Colors.white
                                : dark(context),
                          ),
                        ),
                        TextSpan(
                          text: "Login!",
                          style: TextStyle(
                            color: linkColor(context),
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Get.offAll(() => AuthenticationPage());
                            },
                        ),
                      ],
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
