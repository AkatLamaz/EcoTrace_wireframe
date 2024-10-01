const rootRoute = "/site-layout";

const RegisterPageRoute = "/register";

const OverViewPageDisplayName = "Overview";
const OverViewPageRoute = "/overview";

const ActionViewPageDisplayName = "Action";
const ActionViewPageRoute = "/action";

const EmissionsViewPageDisplayName = "Emissions";
const EmissionsViewPageRoute = "/emissions";

const AuthentitcationPageDisplayName = "Log Out";
const AuthentitcationPageRoute = "/auth";

const PageNotFoundDisplayName = "Page Not Found";
const PageNotFoundRoute = "/not-found";

const SettingsPageDisplayName = "Settings";
const SettingsPageRoute = "/settings";

class MenuItem {
  final String name;
  final String route;

  MenuItem(this.name, this.route);
}

List<MenuItem> sideMenuItems = [
  MenuItem(OverViewPageDisplayName, OverViewPageRoute),
  MenuItem(ActionViewPageDisplayName, ActionViewPageRoute),
  MenuItem(EmissionsViewPageDisplayName, EmissionsViewPageRoute),
  MenuItem(AuthentitcationPageDisplayName, AuthentitcationPageRoute),
  //MenuItem(SettingsPageDisplayName, SettingsPageRoute),
];
