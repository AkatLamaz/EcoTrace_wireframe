const rootRoute = "/";

const OverViewPageDisplayName = "Overview";
const OverViewPageRoute = "/overview";

const ActionViewPageDisplayName = "Action";
const ActionViewPageRoute = "/Action";

const EmissionsViewPageDisplayName = "Emissions";
const EmissionsViewPageRoute = "/Emissions";

const AuthentitcationPageDisplayName = "Log Out";
const AuthentitcationPageRoute = "/auth";

class MenuItem {
  final String name;
  final String route;

  MenuItem(this.name, this.route);
}

List<MenuItem> sideMenuItems = [
  MenuItem(OverViewPageDisplayName, OverViewPageRoute),
  MenuItem(ActionViewPageDisplayName, ActionViewPageRoute),
  MenuItem(EmissionsViewPageDisplayName, EmissionsViewPageRoute),
  MenuItem(AuthentitcationPageDisplayName, AuthentitcationPageRoute)
];
