import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icofont_flutter/icofont_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:go_router/go_router.dart';

// PageController pageController = PageController();

// class DefaultPage extends StatefulWidget {
//   const DefaultPage({super.key});

//   @override
//   State<DefaultPage> createState() => _DefaultPageState();
// }

// class _DefaultPageState extends State<DefaultPage> {
//   int currentPage = 0;
//   List<Widget> body = const [
//     HomePage(),
//     PickupsPage(),
//     SelectAddressMapPage(),
//     ProfilePage(),
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: body[currentPage],
//       bottomNavigationBar: BottomNavigationBar(
//           elevation: 10,
//           currentIndex: currentPage,
//           selectedItemColor: Colors.black,
//           unselectedItemColor: Colors.grey,
//           type: BottomNavigationBarType.fixed,
//           onTap: (value) {
//             setState(() {
//               currentPage = value;
//             });
//           },
//           items: [
//             //ToDO: Use one tab for notification if available
//             const BottomNavigationBarItem(
//                 icon: ImageIcon(AssetImage("assets/icons/home_icon.png")),
//                 label: 'Home'),
//             BottomNavigationBarItem(
//                 icon: ImageIcon(
//                   const AssetImage("assets/icons/garbage_truck.png"),
//                   size: 30.sp,
//                 ),
//                 label: 'Pickups'),
//             BottomNavigationBarItem(
//                 icon: Icon(MdiIcons.googleMaps), label: 'Maps'),
//             const BottomNavigationBarItem(
//                 icon: Icon(IcoFontIcons.user), label: 'Profile'),
//           ]),
//     );
//   }
// }

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
          BottomNavigationBarItem(
              icon: Icon(MdiIcons.googleMaps), label: 'Maps'),
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
