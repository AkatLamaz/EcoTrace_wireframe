import 'package:flutter/material.dart';
import 'package:flutter_web_tutorial2/constants/controllers.dart';
import 'package:get/get.dart';
import '../constants/style.dart';
import 'custom_text.dart';
import 'package:provider/provider.dart';
import '../../theme_provider.dart';

class VerticalMenuItem extends StatelessWidget {
  final String? itemName;
  final Function()? onTap;
  
  VerticalMenuItem({super.key, this.itemName, required this.onTap}) {
  }

  @override
  Widget build(BuildContext context) {
    
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        
        return Obx(() {
          
          final bool isHovering = menuController.isHovering(itemName!);
          final bool isActive = menuController.isActive(itemName!);
          
          
          return InkWell(
            onTap: () {
              onTap?.call();
            },
            onHover: (value) {
              value
                  ? menuController.onHover(itemName!)
                  : menuController.onHover("not hovering");
            },
            child: Container(
              color: isHovering
                    ? themeProvider.isDarkMode 
                        ? Colors.white.withOpacity(0.1)
                        : lightGrey(context).withOpacity(0.1)
                    : Colors.transparent,
              child: Row(
                children: [
                  Visibility(
                    visible: isHovering || isActive,
                    maintainSize: true,
                    maintainState: true,
                    maintainAnimation: true,
                    child: Container(
                      width: 3,
                      height: 72,
                      color: themeProvider.isDarkMode ? Colors.white : dark(context),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Builder(
                            builder: (context) {
                              return menuController.returnIconFor(itemName!);
                            }
                          ),
                        ),
                        if (!isActive)
                          Flexible(
                            child: Builder(
                              builder: (context) {
                                return CustomText(
                                  text: itemName ?? '',
                                  color: isHovering 
                                      ? themeProvider.isDarkMode
                                          ? Colors.white
                                          : dark(context)
                                      : themeProvider.isDarkMode
                                          ? Colors.white.withOpacity(0.7)
                                          : lightGrey(context),
                                  size: 16,
                                );
                              }
                            ),
                          )
                        else
                          Flexible(
                            child: Builder(
                              builder: (context) {
                                return CustomText(
                                  text: itemName ?? '',
                                  color: themeProvider.isDarkMode
                                      ? Colors.white
                                      : dark(context),
                                  size: 18,
                                  weight: FontWeight.bold,
                                );
                              }
                            ),
                          ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
      },
    );
  }
}
