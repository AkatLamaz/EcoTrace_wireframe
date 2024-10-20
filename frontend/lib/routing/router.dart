import 'package:flutter/material.dart';
import 'package:flutter_web_tutorial2/pages/overview/overview.dart';
import 'package:flutter_web_tutorial2/pages/emission/emission.dart';
import 'package:flutter_web_tutorial2/pages/action/action_page.dart';
import 'package:flutter_web_tutorial2/pages/404/error_page.dart';
import 'package:flutter_web_tutorial2/pages/settings/settings.dart';
import 'package:flutter_web_tutorial2/routing/routes.dart';

Route<dynamic>? generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case OverViewPageRoute:
      return _getPageRoute(const OverViewPage());
    case ActionViewPageRoute:
      return _getPageRoute(const ActionsPage());
    case EmissionsViewPageRoute:
      return _getPageRoute( EmissionsPage()); //const
    case SettingsPageRoute:
      return _getPageRoute(SettingsPage()); //const
    default:
      return _getPageRoute(const PageNotFound());
  }
}

PageRoute _getPageRoute(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}