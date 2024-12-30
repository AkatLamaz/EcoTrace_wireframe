import 'package:flutter/material.dart';

Color light(BuildContext context) => Theme.of(context).brightness == Brightness.light ? const Color(0xFFEEF2F6) : const Color(0xFF2A2A2A);
Color dark(BuildContext context) => Theme.of(context).brightness == Brightness.light ? const Color(0xFF363740) : const Color(0xFFE0E0E0);
Color active = const Color(0xFF3C19C0);
Color lightGrey(BuildContext context) => Theme.of(context).brightness == Brightness.light ? const Color(0xFFA4A6B3) : const Color(0xFFBDBDBD);
Color ultrawhite(BuildContext context) => Theme.of(context).brightness == Brightness.light ? const Color(0xFFF0F1F5) : const Color(0xFFF0F1F5); //for test purposes
Color colorPages(BuildContext context) => Theme.of(context).brightness == Brightness.light ? const Color(0xFFE8EAF6) : const Color(0xFF1C1C1C);
Color shadowColor(BuildContext context) => Theme.of(context).brightness == Brightness.light ? const Color(0x29000000) : const Color(0xD6FFFFFF); 


Color linkColor(BuildContext context) => Theme.of(context).brightness == Brightness.light ? const Color.fromARGB(255, 19, 57, 226) : const Color(0xFF81D4FA);  // Jasny indygo w trybie ciemnym
Color secondaryLinkColor(BuildContext context) => Theme.of(context).brightness == Brightness.light ? const Color.fromARGB(255, 19, 57, 226) : const Color(0xFFB39DDB);  // Jasny niebieski dla trybu ciemnego


//const colors
const cardBackgroundColor = Color(0xFF21222D);
const primaryColor = Color(0xFF2697FF);
const secondaryColor = Color(0xFFFFFFFF);
const backgroundColor = Color(0xFF15131C);
const selectionColor = Color(0xFF88B2AC);
const navBackgroundColor = Color.fromARGB(160, 215, 214, 214);

const defaultPadding = 20.0;

Color scopeColor(BuildContext context) => Theme.of(context).brightness == Brightness.light 
    ? const Color(0xFFE8E8E8)  // Bardzo jasny szary dla trybu jasnego
    : const Color(0xFF3C19C0); // Pozostawiony ciemny kolor dla trybu ciemnego

