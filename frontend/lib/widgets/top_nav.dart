import 'package:flutter/material.dart';
import 'package:flutter_web_tutorial2/constants/controllers.dart';
import 'package:flutter_web_tutorial2/helpers/responsiveness.dart';
import 'package:flutter_web_tutorial2/widgets/custom_text.dart';
import '../constants/style.dart';
import '../routing/routes.dart'; // Import routes
import 'package:get/get.dart';
import '../pages/settings/settings.dart'; // Upewnij się, że importujesz swój plik settings.dart

AppBar topNavigationBar(BuildContext context, GlobalKey<ScaffoldState> key) {
  final SettingsController settingsController = Get.find<SettingsController>();

  return AppBar(
    leading: !ResponsiveWidget.isSmallScreen(context)
        ? Row(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 14),
                child: Image.asset(
                  "assets/icons/logo_64.png",
                  width: 28,
                  height: 28,
                  cacheHeight: 28,
                  cacheWidth: 28,
                ),
              ),
            ],
          )
        : IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              key.currentState?.openDrawer();
            },
          ),
    elevation: 0,
    title: Row(
      children: [
        Visibility(
          visible: true,
          child: CustomText(
            text: "Dash",
            color: lightGrey(context),
            size: 20,
            weight: FontWeight.bold,
          ),
        ),
        Expanded(child: Container()),
        IconButton(
          icon: Icon(
            Icons.settings,
            color: dark(context).withOpacity(0.7),
          ),
          onPressed: () {
            navigationController.navigateTo(SettingsPageRoute);
          },
        ),
        IconButton(
          icon: Icon(
            Icons.dark_mode,
            color: dark(context).withOpacity(0.7),
          ),
          onPressed: () {
            // Toggle theme here
          },
        ),
        Stack(
          children: [
            IconButton(
              icon: Icon(
                Icons.notifications,
                color: dark(context),
              ),
              onPressed: () {},
            ),
            Positioned(
              top: 7,
              right: 7,
              child: Container(
                width: 12,
                height: 12,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: active,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: light(context), width: 2),
                ),
              ),
            ),
          ],
        ),
        Container(
          width: 1,
          height: 22,
          color: lightGrey(context),
        ),
        const SizedBox(
          width: 24,
        ),
        Obx(() => CustomText(
          text: settingsController.name.value, // Pobieranie nazwy użytkownika z kontrolera
          color: lightGrey(context),
        )),
        const SizedBox(
          width: 16,
        ),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Container(
            padding: const EdgeInsets.all(2),
            margin: const EdgeInsets.all(2),
            child: CircleAvatar(
              backgroundColor: light(context),
              child: Icon(
                Icons.person_outline,
                color: dark(context),
              ),
            ),
          ),
        ),
      ],
    ),
    iconTheme: IconThemeData(color: dark(context)), // Corrected iconTheme syntax
    backgroundColor: light(context) //Colors.transparent, // Added missing comma
  );
}
