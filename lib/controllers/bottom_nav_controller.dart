 import 'package:get/get.dart';

// class BottomNavController extends GetxController {
//   var selectedIndex = 0.obs;
//   var isActive = false.obs;
//   void changeTabIndex(int index) {
//     selectedIndex.value = index;
//     if (index == 2) {
//       isActive.value = true;
//     } else {
//       isActive.value = false;
//     }
//   }
// }

 class BottomNavController extends GetxController {
   var selectedIndex = 0.obs;
   var isActive = false.obs;

   void changeTabIndex(int index) {
     selectedIndex.value = index;
     isActive.value = index == 2;
   }
 }