import 'package:flutter/material.dart';
import 'package:flutter_web_tutorial2/constants/style.dart';
import 'package:flutter_web_tutorial2/routing/routes.dart';
import 'package:get/get.dart';

class MenuController extends GetxController {
  static MenuController instance = Get.find();
  var activeItem = OverViewPageRoute.obs;
  var hoverItem = "".obs;

  changeActiveitemTo(String itemName) {
    activeItem.value = itemName;
  }

  onHover(String itemName) {
    if (!isActive(itemName)) hoverItem.value = itemName;
  }

  bool isActive(String itemName) => activeItem.value == itemName; // Poprawiono

  bool isHovering(String itemName) => hoverItem.value == itemName;

  Widget returnIconFor(String itemName) {
    switch (itemName) {
      case OverViewPageRoute:
        return _customIcon(Icons.trending_up, itemName);
      case DriversViewPageRoute:
        return _customIcon(Icons.drive_eta, itemName);
      case ClientsViewPageRoute:
        return _customIcon(Icons.people_alt_outlined, itemName);
      case AuthentitcationPageRoute:
        return _customIcon(Icons.exit_to_app, itemName);
      default:
        return _customIcon(Icons.exit_to_app, itemName);
    }
  }

  Widget _customIcon(IconData icon, String itemName) {
    if (isActive(itemName)) return Icon(icon, size: 22, color: dark);

    return Icon(icon, color: isHovering(itemName) ? dark : lightGrey);
  }
}