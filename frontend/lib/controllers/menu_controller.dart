import 'package:flutter/material.dart';
import 'package:flutter_web_tutorial2/constants/style.dart';
import 'package:flutter_web_tutorial2/routing/routes.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../theme_provider.dart';

class MenuController extends GetxController {
  static MenuController instance = Get.find();
  var activeItem = OverViewPageDisplayName.obs;
  var hoverItem = "".obs;

  changeActiveitemTo(String itemName) {
    activeItem.value = itemName;
  }

  onHover(String itemName) {
    if (!isActive(itemName)) hoverItem.value = itemName;
  }

  isHovering(String itemName) => hoverItem.value == itemName;

  isActive(String itemName) => activeItem.value == itemName;

  Widget returnIconFor(String itemName) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        IconData icon;
        switch (itemName) {
          case OverViewPageDisplayName:
            icon = Icons.trending_up;
            break;
          case ActionViewPageDisplayName:
            icon = Icons.drive_eta;
            break;
          case EmissionsViewPageDisplayName:
            icon = Icons.people_alt_outlined;
            break;
          case AuthentitcationPageDisplayName:
            icon = Icons.exit_to_app;
            break;
          case SettingsPageDisplayName:
            icon = Icons.settings;
            break;
          default:
            icon = Icons.exit_to_app;
        }

        if (isActive(itemName)) {
          return Icon(
            icon, 
            size: 22, 
            color: themeProvider.isDarkMode ? Colors.white : dark(Get.context!)
          );
        }

        return Icon(
          icon, 
          color: isHovering(itemName) 
              ? themeProvider.isDarkMode
                  ? Colors.white 
                  : dark(Get.context!)
              : themeProvider.isDarkMode
                  ? Colors.white.withOpacity(0.7)
                  : lightGrey(Get.context!)
        );
      }
    );
  }
}