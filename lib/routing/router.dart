import 'package:flutter/material.dart';
import 'package:flutter_web_tutorial2/pages/overview/overview.dart';
import 'package:flutter_web_tutorial2/pages/clients/clients.dart';
import 'package:flutter_web_tutorial2/pages/drivers/drivers.dart';
import 'package:flutter_web_tutorial2/routing/routes.dart';

Route<dynamic>? generateRoute(RouteSettings settings){
  switch(settings.name){
      case OverViewPageRoute:
        return _getPageRoute(OverViewPage());
      case DriversViewPageRoute:
        return _getPageRoute(DriversPage());
      case ClientsViewPageRoute:
       return _getPageRoute(ClientsPage());
      default:
        return _getPageRoute(OverViewPage());
    }
  }

PageRoute _getPageRoute(Widget child){
  return MaterialPageRoute(builder: (context) => child);
}