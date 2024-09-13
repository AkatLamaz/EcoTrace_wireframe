import "package:flutter/material.dart"  hide MenuController;
import 'package:flutter_web_tutorial2/controllers/menu_controller.dart';
import "package:flutter_web_tutorial2/layout.dart";
import "package:flutter_web_tutorial2/pages/404/error_page.dart";
import "package:flutter_web_tutorial2/pages/authentication/authentication.dart";
import "package:flutter_web_tutorial2/routing/routes.dart";
import "package:get/get.dart";
import "package:google_fonts/google_fonts.dart";
import "controllers/navigation_controller.dart";
import "pages/register/register.dart"; 

void main() {
  Get.put(MenuController());
  Get.put(NavigationController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: AuthentitcationPageRoute,
      unknownRoute: GetPage(
        name: "/not-found", 
        page: () => const PageNotFound(),
        transition: Transition.fadeIn
      ),
      getPages: [
        GetPage(name: rootRoute, page: () { return SiteLayout(); }),
        GetPage(name: RegisterPageRoute, page: () { return RegistrationPage(); }),
        GetPage(name: AuthentitcationPageRoute, page: () => AuthenticationPage()),
      ],
      debugShowCheckedModeBanner: false,
      title: "Dash",
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        textTheme: GoogleFonts.mulishTextTheme(
          Theme.of(context).textTheme
          ).apply(
          bodyColor: Colors.black
        ),
        pageTransitionsTheme: const PageTransitionsTheme(builders: {
          TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder()
        }),
        primaryColor: Colors.blue
      ),
      //home: AuthenticationPage(),
    );
  }
}