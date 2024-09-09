// ignore_for_file: constant_identifier_names

const RootRoute = "/";

const OverViewPageDisplayName = "Overview";
const OverViewPageRoute = "/overview";

const DriversViewPageDisplayName = "Drivers";
const DriversViewPageRoute = "/drivers";

const ClientsViewPageDisplayName = "Clients";
const ClientsViewPageRoute = "/clients";

const AuthentitcationPageDisplayName = "Log Out";
const AuthentitcationPageRoute = "/auth";

class MenuItem {
  final String name;
  final String route;

  MenuItem(this.name, this.route);
}

List<MenuItem> sideMenuItems = [
  MenuItem(OverViewPageDisplayName, OverViewPageRoute),
  MenuItem(DriversViewPageDisplayName, DriversViewPageRoute),
  MenuItem(ClientsViewPageDisplayName, ClientsViewPageRoute),
  MenuItem(AuthentitcationPageDisplayName, AuthentitcationPageRoute)
];
