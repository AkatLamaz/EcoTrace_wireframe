import 'package:flutter/material.dart';
import 'package:flutter_web_tutorial2/widgets/custom_text.dart';

// ignore: use_key_in_widget_constructors
class OverViewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CustomText(text: "Overview"),
    );
  }
}