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

// ignore: use_key_in_widget_constructors
class AuthenticationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) => Scaffold(
        body: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400),
            padding: const EdgeInsets.all(24),
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
                TextField(
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
                ),
                const SizedBox(height: 15),
                TextField(
                  obscureText: true,
                  style: TextStyle(
                    color: themeProvider.isDarkMode
                        ? Colors.white
                        : dark(context),
                  ),
                  decoration: InputDecoration(
                    labelText: "Password",
                    labelStyle: TextStyle(
                      color: themeProvider.isDarkMode
                          ? lightGrey(context)
                          : dark(context),
                    ),
                    hintText: "123",
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
                InkWell(
                  onTap: () {
                    Get.offAllNamed(rootRoute);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: active,
                      borderRadius: BorderRadius.circular(20)),
                    alignment: Alignment.center,
                    width: double.maxFinite,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: const CustomText(
                      text: "Login",
                      color: Colors.white,
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}