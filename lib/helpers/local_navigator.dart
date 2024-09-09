import 'package:flutter/widgets.dart';
import 'package:flutter_web_tutorial2/constants/controllers.dart';
import 'package:flutter_web_tutorial2/routing/routes.dart';

Navigator localNavigator() => Navigator(
  key: navigationController.navigationKey,
  initialRoute: OverViewPageRoute,

);