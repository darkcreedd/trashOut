import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icofont_flutter/icofont_flutter.dart';

import 'package:go_router/go_router.dart';

class ScaffoldWithNavbar extends StatelessWidget {
  const ScaffoldWithNavbar(this.navigationShell, {super.key});

  /// The navigation shell and container for the branch Navigators.
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        elevation: 10,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: [
          //ToDO: Use one tab for notification if available
          const BottomNavigationBarItem(
              icon: ImageIcon(AssetImage("assets/icons/home_icon.png")),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: ImageIcon(
                const AssetImage("assets/icons/garbage_truck.png"),
                size: 30.sp,
              ),
              label: 'Pickups'),
          const BottomNavigationBarItem(
              icon: Icon(Icons.notifications_active), label: 'Alerts'),
          const BottomNavigationBarItem(
              icon: Icon(IcoFontIcons.user), label: 'Profile'),
        ],
        onTap: _onTap,
      ),
    );
  }

  void _onTap(index) {
    navigationShell.goBranch(
      index,
      // A common pattern when using bottom navigation bars is to support
      // navigating to the initial location when tapping the item that is
      // already active. This example demonstrates how to support this behavior,
      // using the initialLocation parameter of goBranch.
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}
