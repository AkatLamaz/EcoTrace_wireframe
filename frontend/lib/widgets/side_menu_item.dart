import 'package:flutter/material.dart';
import 'package:flutter_web_tutorial2/helpers/responsiveness.dart';
import 'package:flutter_web_tutorial2/widgets/horizontal_menu_item.dart';
import 'package:flutter_web_tutorial2/widgets/vertical_menu_item.dart';

class SideMenuItem extends StatelessWidget {
  final String itemName;
  final Function() onTap;

  const SideMenuItem({Key? key, required this.itemName, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("Building SideMenuItem for: $itemName");
    
    final screenWidth = MediaQuery.of(context).size.width;
    final isCustomScreen = ResponsiveWidget.isCustomScreen(context);
    print("Screen width: $screenWidth");
    print("isCustomScreen for $itemName: $isCustomScreen");
    
    if (isCustomScreen) {
      print("Rendering VerticalMenuItem for: $itemName");
      return VerticalMenuItem(
        itemName: itemName,
        onTap: onTap,
      );
    } else {
      print("Rendering HorizontalMenuItem for: $itemName");
      return HorizontalMenuItem(
        itemName: itemName,
        onTap: onTap,
      );
    }
  }
}