import 'package:flutter/material.dart';
import 'package:flutter_web_tutorial2/constants/controllers.dart';
import 'package:get/get.dart';
import '../constants/style.dart';
import 'custom_text.dart';
import 'package:provider/provider.dart';
import '../../theme_provider.dart';

class VertticalMenuItem extends StatelessWidget {
  final String? itemName;
  final Function()? onTap;
  
  const VertticalMenuItem({super.key, this.itemName, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return InkWell(
          onTap: onTap,
          onHover: (value) {
            value
                ? menuController.onHover(itemName!)
                : menuController.onHover("not hovering");
          },
          child: Obx(() => Container(
            color: menuController.isHovering(itemName!)
                  ? lightGrey(context).withOpacity(0.1)
                  : Colors.transparent,
              child: Row(
                children: [
                  Visibility(
                    visible: menuController.isHovering(itemName!) ||
                        menuController.isActive(itemName!),
                    maintainSize: true,
                    maintainState: true,
                    maintainAnimation: true,
                    child: Container(
                      width: 3,
                      height: 72,
                      color: themeProvider.isDarkMode ? Colors.white : dark(context),
                    ),
                  ),
                  Expanded(child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: menuController.returnIconFor(itemName!),
                      ),
                      if (!menuController.isActive(itemName!))
                        Flexible(
                          child: CustomText(
                            text: itemName ?? '',
                            color: menuController.isHovering(itemName!) 
                                ? dark(context)  // Zmiana na dark() dla lepszego kontrastu
                                : themeProvider.isDarkMode
                                    ? light(context)  // Zmiana na light() w trybie ciemnym
                                    : lightGrey(context),
                            size: 16,
                          ),
                        )
                      else
                        Flexible(
                          child: CustomText(
                            text: itemName ?? '',
                            color: dark(context),  // Zmiana na dark() dla aktywnego elementu
                            size: 18,
                            weight: FontWeight.bold,
                          ),
                        ),
                    ],
                  ))
                ],
              ),
            ),
          )
        );
      }
    );
  }
}
