import 'package:flutter/material.dart';
import 'package:flutter_web_tutorial2/constants/controllers.dart';
import 'package:get/get.dart';
import '../constants/style.dart';
import 'custom_text.dart';

class VertticalMenuItem extends StatelessWidget {
  final String? itemName;
  final Function()? onTap;
  
  const VertticalMenuItem({super.key, this.itemName, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap, // Ensure onTap is not nullable
      onHover: (value) {
        value
            ? menuController.onHover(itemName!)
            : menuController.onHover("not hovering");
      }, child: Obx(() => Container(
        color: menuController.isHovering(itemName!)
              ? lightGrey(context).withOpacity(0.1)
              : Colors.transparent,
          child: Row(
            children: [
              Visibility(
                visible: menuController.isHovering(itemName!) ||
                    menuController.isActive(itemName!),
                // ignore: sort_child_properties_last
                child: Container(
                  width: 3,
                  height: 72,
                  color: dark(context),
                ),
                maintainSize: true,
                maintainState: true,
                maintainAnimation: true,
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
                    color: menuController.isHovering(itemName!) ? dark(context) : lightGrey(context),
                  ),
                )
                  else
                    Flexible(
                      child: CustomText(
                        text: itemName ?? '',
                        color: dark(context),
                        size: 18,
                        weight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}