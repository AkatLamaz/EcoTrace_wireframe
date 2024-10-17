import 'package:flutter/material.dart';
import 'package:flutter_web_tutorial2/constants/controllers.dart';
import 'package:flutter_web_tutorial2/helpers/responsiveness.dart';
import 'package:flutter_web_tutorial2/widgets/custom_text.dart';
import '../constants/style.dart';
import '../routing/routes.dart'; // Import routes
import 'package:get/get.dart';
import '../pages/settings/settings.dart'; // Upewnij się, że importujesz swój plik settings.dart
import 'package:provider/provider.dart';
import '../theme_provider.dart';

Consumer<ThemeProvider> topNavigationBar(BuildContext context, GlobalKey<ScaffoldState> key) {
  final SettingsController settingsController = Get.find<SettingsController>();

  return Consumer<ThemeProvider>(
    builder: (context, themeProvider, child) {
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
                text: "Dashboard",
                color: themeProvider.isDarkMode ? light(context) : dark(context),
                size: 20,
                weight: FontWeight.bold,
              ),
            ),
            Expanded(child: Container()),
            IconButton(
              icon: Icon(
                Icons.settings,
                color: themeProvider.isDarkMode ? light(context) : dark(context).withOpacity(0.7),
              ),
              onPressed: () {
                navigationController.navigateTo(SettingsPageRoute);
              },
            ),
            IconButton(
              icon: Icon(
                themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                color: themeProvider.isDarkMode ? light(context) : dark(context).withOpacity(0.7),
              ),
              onPressed: () {
                themeProvider.toggleTheme(!themeProvider.isDarkMode);
              },
            ),
            Stack(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.notifications,
                    color: themeProvider.isDarkMode ? light(context) : dark(context),
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
                      border: Border.all(color: themeProvider.isDarkMode ? light(context) : dark(context), width: 2),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              width: 1,
              height: 22,
              color: themeProvider.isDarkMode ? dark(context) : lightGrey(context),
            ),
            const SizedBox(
              width: 24,
            ),
            Obx(() => CustomText(
              text: settingsController.name.value, // Pobieranie nazwy użytkownika z kontrolera
              color: themeProvider.isDarkMode ? dark(context) : lightGrey(context),
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
                  backgroundColor: themeProvider.isDarkMode ? dark(context) : light(context),
                  child: Icon(
                    Icons.person_outline,
                    color: themeProvider.isDarkMode ? light(context) : dark(context),
                  ),
                ),
              ),
            ),
          ],
        ),
        iconTheme: IconThemeData(color: themeProvider.isDarkMode ? light(context) : dark(context)),
        backgroundColor: themeProvider.isDarkMode ? dark(context) : light(context),
      );
    },
  );
}
