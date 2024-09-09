import 'package:flutter/material.dart';
import 'package:flutter_web_tutorial2/constants/controllers.dart';
import 'package:flutter_web_tutorial2/constants/style.dart';
import 'package:flutter_web_tutorial2/helpers/responsiveness.dart';
import 'package:flutter_web_tutorial2/routing/routes.dart';
import 'package:flutter_web_tutorial2/widgets/custom_text.dart';
import 'package:get/get.dart';

import 'side_menu_item.dart';


class SideMenu extends StatelessWidget {
  const SideMenu({ Key? key }) : super(key: key);

   @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
            color: light,
            child: ListView(
              children: [
                if(ResponsiveWidget.isSmallScreen(context))
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      children: [
                        SizedBox(width: width / 48),
                        Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: Image.asset("assets/icons/logo.png", width: 28, height: 28, cacheHeight: 28, cacheWidth: 28, ),
                        ),
                        Flexible(
                          child: CustomText(
                            text: "Dash",
                            size: 20,
                            weight: FontWeight.bold,
                            color: active,
                          ),
                        ),
                        SizedBox(width: width / 48),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
                    Divider(color: lightGrey.withOpacity(.1), ),

            Column(
              mainAxisSize: MainAxisSize.min,
              children: sideMenuItems.map((itemName) => SideMenuItem(
                itemName: itemName == AuthentitcationPageRoute ? "Log out" : itemName,
                onTap: (){
                  if(itemName == AuthentitcationPageRoute){
                    // TODO :: auth page
                  }

                  if(!menuController.isActive(itemName)){
                    menuController.changeActiveitemTo(itemName);
                    if(ResponsiveWidget.isSmallScreen(context))
                      // ignore: curly_braces_in_flow_control_structures
                      Get.back();
                    navigationController.navigateTo(itemName);
                  }
                },
              )).toList(),
                )
              ],
            ),
          );
  }
} 