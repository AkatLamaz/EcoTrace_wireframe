import 'package:flutter/material.dart';
import 'package:flutter_web_tutorial2/helpers/responsiveness.dart';
import 'package:flutter_web_tutorial2/widgets/large_screen.dart';
import 'package:flutter_web_tutorial2/widgets/side_menu.dart';
import 'package:flutter_web_tutorial2/widgets/small_screen.dart';
import 'package:flutter_web_tutorial2/widgets/top_nav.dart';

// ignore: use_key_in_widget_constructors
class SiteLayout extends StatelessWidget {
final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      extendBodyBehindAppBar: true, // usuwa appbar :D
      appBar: topNavigationBar(context, scaffoldKey),
      drawer: const Drawer(
        child: SideMenu(),
      ),
      body: const ResponsiveWidget(
        largeScreen: LargeScreen(),
        smallScreen: SmallScreen()
      )
    );
  }
}