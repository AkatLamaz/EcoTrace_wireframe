import 'package:flutter/material.dart';
import 'package:flutter_web_tutorial2/constants/style.dart';
import 'package:flutter_web_tutorial2/widgets/custom_text.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_web_tutorial2/theme_provider.dart';
import 'package:provider/provider.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _codeController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _codeSent = false;
  bool _codeVerified = false;

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
                      Text(
                        "Forgot Password",
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
                  const SizedBox(height: 15),
                  if (!_codeSent) _buildEmailField(),
                  if (_codeSent && !_codeVerified) _buildCodeVerificationField(),
                  if (_codeVerified) ...[
                    _buildPasswordField(),
                    const SizedBox(height: 15),
                    _buildConfirmPasswordField(),
                  ],
                  const SizedBox(height: 15),
                  _buildActionButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmailField() {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) => TextFormField(
        controller: _emailController,
        style: TextStyle(
          color: themeProvider.isDarkMode
              ? Colors.white
              : dark(context),
        ),
        decoration: InputDecoration(
          labelText: "Email",
          labelStyle: TextStyle(
            color: themeProvider.isDarkMode
                ? lightGrey(context)
                : dark(context),
          ),
          hintText: "abc@domain.com",
          hintStyle: TextStyle(
            color: themeProvider.isDarkMode
                ? Colors.grey[400]
                : Colors.grey[600],
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: themeProvider.isDarkMode
                  ? Colors.white.withOpacity(0.2)
                  : lightGrey(context),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: active),
          ),
          fillColor: themeProvider.isDarkMode
              ? cardBackgroundColor
              : Colors.white,
          filled: true,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your email';
          }
          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
            return 'Please enter a valid email';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildCodeVerificationField() {
    return TextFormField(
      controller: _codeController,
      decoration: InputDecoration(
        labelText: "Verification Code",
        hintText: "Enter the code sent to your email",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter the verification code';
        }
        return null;
      },
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: true,
      decoration: InputDecoration(
        labelText: "New Password",
        hintText: "Enter your new password",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a new password';
        }
        if (value.length < 8) {
          return 'Password must be at least 8 characters long';
        }
        return null;
      },
    );
  }

  Widget _buildConfirmPasswordField() {
    return TextFormField(
      controller: _confirmPasswordController,
      obscureText: true,
      decoration: InputDecoration(
        labelText: "Confirm New Password",
        hintText: "Confirm your new password",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please confirm your new password';
        }
        if (value != _passwordController.text) {
          return 'Passwords do not match';
        }
        return null;
      },
    );
  }

  Widget _buildActionButton() {
    return InkWell(
      onTap: () {
        if (_formKey.currentState!.validate()) {
          if (!_codeSent) {
            // TODO: Implement sending verification code to email
            setState(() {
              _codeSent = true;
            });
          } else if (!_codeVerified) {
            // TODO: Implement code verification
            setState(() {
              _codeVerified = true;
            });
          } else {
            // TODO: Implement password reset
            Get.snackbar(
              "Success",
              "Password has been reset successfully",
              snackPosition: SnackPosition.BOTTOM,
            );
            Get.offAllNamed('/login');
          }
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: active,
          borderRadius: BorderRadius.circular(20),
        ),
        alignment: Alignment.center,
        width: double.maxFinite,
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: CustomText(
          text: !_codeSent
              ? "Send Verification Code"
              : !_codeVerified
                  ? "Verify Code"
                  : "Reset Password",
          color: Colors.white,
        ),
      ),
    );
  }
}