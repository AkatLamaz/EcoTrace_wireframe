import 'package:flutter/material.dart';
import 'package:flutter_web_tutorial2/constants/controllers.dart';
import 'package:flutter_web_tutorial2/constants/style.dart';
import 'package:flutter_web_tutorial2/helpers/responsiveness.dart';
import 'package:flutter_web_tutorial2/routing/routes.dart';
import 'package:flutter_web_tutorial2/widgets/custom_text.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'side_menu_item.dart';
import '../theme_provider.dart';


class SideMenu extends StatelessWidget {
  const SideMenu({ super.key });

   @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Container(
            decoration: BoxDecoration(
            color: themeProvider.isDarkMode ? dark(context) : light(context), // Use theme-aware colors
            ),
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
                          child: Image.asset("assets/icons/logo_64.png", width: 28, height: 28, cacheHeight: 28, cacheWidth: 28, ),
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
                //Divider(color: lightGrey(context).withOpacity(0.1)),
                Divider(color: lightGrey(context).withAlpha((0.1 * 255).toInt()), ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: sideMenuItems.map((item) => SideMenuItem(
                itemName: item.name,
                onTap: (){
                  if(item.route == AuthentitcationPageRoute){
                    menuController.changeActiveitemTo(OverViewPageDisplayName);
                    Get.offAllNamed(AuthentitcationPageRoute);
                    //Get.offAll(() => AuthenticationPage()); old method
                  }

                  if(!menuController.isActive(item.name)){
                    menuController.changeActiveitemTo(item.name);
                    if(ResponsiveWidget.isSmallScreen(context))
                      // ignore: curly_braces_in_flow_control_structures
                      Get.back();
                    navigationController.navigateTo(item.route);
                  }
                },
              )).toList(),
                )
              ],
            ),
          );
      },
    );
  }
} 
