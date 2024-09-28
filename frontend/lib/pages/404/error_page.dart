import 'package:flutter/material.dart';
import 'package:flutter_web_tutorial2/widgets/custom_text.dart';

class PageNotFound extends StatelessWidget {
  const PageNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/error_404.jpg", width: 650), // Zwiększono szerokość
            const SizedBox(height: 20), // Zwiększono odstęp
            const CustomText(
              text: "Page not found",
              size: 32, // Zwiększono rozmiar tekstu
              weight: FontWeight.bold,
            ),
          ],
        ),
      ),
    );
  }
}
