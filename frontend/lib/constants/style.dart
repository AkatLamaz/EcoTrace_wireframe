import 'package:flutter/material.dart';

Color light(BuildContext context) => Theme.of(context).brightness == Brightness.light ? const Color(0xFFF0F1F5) : const Color(0xFF2A2A2A);
Color dark(BuildContext context) => Theme.of(context).brightness == Brightness.light ? const Color(0xFF363740) : const Color(0xFFE0E0E0);
Color active = const Color(0xFF3C19C0);
Color lightGrey(BuildContext context) => Theme.of(context).brightness == Brightness.light ? const Color(0xFFA4A6B3) : const Color(0xFF6D6D6D);
Color colorPages(BuildContext context) => Theme.of(context).brightness == Brightness.light ? const Color(0xFFE8EAF6) : const Color(0xFF1C1C1C);
Color shadowColor(BuildContext context) => Theme.of(context).brightness == Brightness.light ? const Color(0x29000000) : const Color(0xD6FFFFFF); 


//const colors
const cardBackgroundColor = Color(0xFF21222D);
const primaryColor = Color(0xFF2697FF);
const secondaryColor = Color(0xFFFFFFFF);
const backgroundColor = Color(0xFF15131C);
const selectionColor = Color(0xFF88B2AC);

const defaultPadding = 20.0;