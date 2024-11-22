import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_tutorial2/constants/style.dart';
import 'package:flutter_web_tutorial2/routing/routes.dart';
import 'package:flutter_web_tutorial2/widgets/custom_text.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_web_tutorial2/pages/authentication/forgot_password.dart';
import 'package:flutter_web_tutorial2/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_web_tutorial2/services/auth_service.dart';

// ignore: use_key_in_widget_constructors
class AuthenticationPage extends StatefulWidget {
  @override
  _AuthenticationPageState createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      try {
        final authService = AuthService();
        await authService.login(
          emailController.text,
          passwordController.text,
        );
        
        // After successful login
        Get.offAllNamed(rootRoute);
        Get.snackbar(
          'Success',
          'Login successful',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } catch (e) {
        Get.snackbar(
          'Error',
          e.toString(),
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) => Scaffold(
        body: Stack(
          children: [
            Center(
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
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          Text(
                            "Login",
                            style: GoogleFonts.roboto(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: themeProvider.isDarkMode
                                  ? Colors.white
                                  : dark(context),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          CustomText(
                            text: "Welcome back!",
                            color: lightGrey(context),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: "Email",
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
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: true, 
                                onChanged: (value) {},
                                fillColor: MaterialStateProperty.resolveWith<Color>((states) {
                                  if (themeProvider.isDarkMode) {
                                    return active;
                                  }
                                  return active;
                                }),
                              ),
                              CustomText(
                                text: "Remember Me",
                                color: themeProvider.isDarkMode
                                    ? Colors.white
                                    : dark(context),
                              )
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              Get.to(() => ForgotPasswordPage());
                            },
                            child: CustomText(
                              text: "Forgot Password?",
                              color: linkColor(context),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      ElevatedButton(
                        onPressed: _login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: active,
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
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
                              text: "Do not have account? ",
                              style: TextStyle(
                                color: themeProvider.isDarkMode
                                    ? Colors.white
                                    : dark(context),
                              ),
                            ),
                            TextSpan(
                              text: "Create account!",
                              style: TextStyle(
                                color: secondaryLinkColor(context),
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Get.offAllNamed(RegisterPageRoute);
                                }
                            )
                          ]
                        )
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 20,
              right: 20,
              child: ElevatedButton(
                onPressed: () => Get.offAllNamed(rootRoute),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: themeProvider.isDarkMode ? Colors.white : dark(context),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(
                      color: themeProvider.isDarkMode ? Colors.white : dark(context),
                    ),
                  ),
                ),
                child: const Text("Go to Main Page"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}