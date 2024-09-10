import 'package:flutter/material.dart';
import 'package:flutter_web_tutorial2/constants/controllers.dart';
import 'package:flutter_web_tutorial2/constants/style.dart';
import 'package:flutter_web_tutorial2/widgets/custom_text.dart';
import 'package:get/get.dart';

class HorizontalMenuItem extends StatelessWidget {
  final String? itemName;
  final Function()? onTap;

  const HorizontalMenuItem({super.key, this.itemName, this.onTap});

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    double _width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap, // Ensure onTap is not nullable
      onHover: (value) {
        value
            ? menuController.onHover(itemName!)
            : menuController.onHover("not hovering");
      },
      child: Obx(
        () => Container(
          color: menuController.isHovering(itemName!)
              ? lightGrey.withAlpha((0.1 * 255).toInt())
              : Colors.transparent,
          child: Row(
            children: [
              Visibility(
                visible: menuController.isHovering(itemName!) ||
                    menuController.isActive(itemName!),
                // ignore: sort_child_properties_last
                child: Container(
                  width: 6,
                  height: 40,
                  color: dark,
                ),
                maintainSize: true,
                maintainState: true,
                maintainAnimation: true,
              ),
              SizedBox(
                width: _width / 80,
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: menuController.returnIconFor(itemName!),
              ),
              if (!menuController.isActive(itemName!))
                Flexible(
                  child: CustomText(
                    text: itemName ?? '',
                    color: menuController.isHovering(itemName!) ? dark : lightGrey,
                  ),
                )
              else
                Flexible(
                  child: CustomText(
                    text: itemName ?? '',
                    color: dark,
                    size: 18,
                    weight: FontWeight.bold,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
