import 'package:flutter/material.dart';
import 'package:flutter_web_tutorial2/helpers/local_navigator.dart';
import 'package:flutter_web_tutorial2/widgets/side_menu.dart';

class LargeScreen extends StatelessWidget {
  const LargeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
        children: [
          const Expanded(
            child: SideMenu()
            ),
          Expanded(
            flex: 5,
            child: localNavigator(),
          )
        ],
      );
  }
}
