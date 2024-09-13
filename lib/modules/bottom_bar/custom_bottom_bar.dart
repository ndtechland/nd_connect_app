import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nd_connect_techland/components/styles.dart';

import '../../controllers/bottom_nav_controller.dart';

class CustomBottomNavBar extends StatelessWidget {
  final BottomNavController bottomNavController = Get.put(BottomNavController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => BottomNavigationBar(
      currentIndex: bottomNavController.selectedIndex.value,
      onTap: (index) {
        bottomNavController.changeTabIndex(index);
      },
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: appColor2,
      unselectedItemColor: Colors.grey,
      showSelectedLabels: true,
      showUnselectedLabels: false,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),

        BottomNavigationBarItem(
          icon: Icon(Icons.location_on),
          label: 'Location',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.event),
          label: 'Events',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.menu_open_rounded),
          label: 'More',
        ),
      ],
      elevation: 10,
      selectedIconTheme: IconThemeData(size: 30, color: appColor2),
      unselectedIconTheme: IconThemeData(size: 25, color: Colors.grey),
    ));
  }
}
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../controllers/bottom_nav_controller.dart';
//
// class CustomBottomNavBar extends StatelessWidget {
//   final BottomNavController bottomNavController = Get.put(BottomNavController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(() => Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(20),
//           topRight: Radius.circular(20),
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black26,
//             offset: Offset(0, -1),
//             blurRadius: 10,
//           ),
//         ],
//       ),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 10),
//         child: BottomNavigationBar(
//           currentIndex: bottomNavController.selectedIndex.value,
//           onTap: (index) {
//             bottomNavController.changeTabIndex(index);
//           },
//           type: BottomNavigationBarType.fixed,
//           backgroundColor: Colors.transparent, // Transparent to blend with container
//           selectedItemColor: Colors.blueAccent,
//           unselectedItemColor: Colors.grey,
//           showSelectedLabels: false,
//           showUnselectedLabels: false,
//           elevation: 0, // Remove default elevation
//           items: [
//             BottomNavigationBarItem(
//               icon: _buildIcon(Icons.home, 0, bottomNavController.selectedIndex.value),
//               label: '',
//             ),
//             BottomNavigationBarItem(
//               icon: _buildIcon(Icons.search, 1, bottomNavController.selectedIndex.value),
//               label: '',
//             ),
//             BottomNavigationBarItem(
//               icon: _buildIcon(Icons.person, 2, bottomNavController.selectedIndex.value),
//               label: '',
//             ),
//             BottomNavigationBarItem(
//               icon: _buildIcon(Icons.settings, 3, bottomNavController.selectedIndex.value),
//               label: '',
//             ),
//           ],
//         ),
//       ),
//     ));
//   }
//
//   Widget _buildIcon(IconData icon, int index, int selectedIndex) {
//     bool isSelected = index == selectedIndex;
//
//     return Container(
//       decoration: isSelected
//           ? BoxDecoration(
//         color: Colors.blueAccent.withOpacity(0.2),
//         shape: BoxShape.circle,
//       )
//           : null,
//       padding: EdgeInsets.all(10),
//       child: Icon(
//         icon,
//         size: isSelected ? 30 : 25,
//         color: isSelected ? Colors.blueAccent : Colors.grey,
//       ),
//     );
//   }
// }
