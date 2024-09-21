// import 'dart:async';
// import 'dart:math';
// import 'package:get/get.dart';
// import 'package:flutter/material.dart';
// import 'package:nd_connect_techland/components/styles.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:nd_connect_techland/modules/all_pages/attendance/attendance.dart';
// class AttendanceBottomSheet extends StatelessWidget {
//    AttendanceBottomSheet({super.key});
//   Completer<GoogleMapController> _controller = Completer();
//
//    LatLng _center = const LatLng(28.582813, 77.314373);
//
//   void _onMapCreated(GoogleMapController controller) {
//     _controller.complete(controller);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     return OrientationBuilder(builder: (context, orientation){
//       return LayoutBuilder(builder: (context, constraints){
//         var screenWidth = constraints.maxWidth;
//         var screenHeight = constraints.maxHeight;
//
//         var mapWidth = orientation == Orientation.portrait
//             ? screenWidth * 0.55
//             : screenWidth * 0.25;
//         var mapHeight = orientation == Orientation.portrait
//             ? screenHeight * 0.2
//             : screenHeight * 0.5;
//
//         var sizeWidth2 = orientation == Orientation.portrait
//             ? screenWidth * 0.9
//             : screenWidth * 0.88;
//         var sizeHeight2 = orientation == Orientation.portrait
//             ? screenHeight * 0.88
//             : screenHeight * 0.88;
//      return Container(
//           //height: 800,
//              decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(18.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 height: sizeHeight2*0.60,
//                 width: sizeWidth2,
//                 decoration: BoxDecoration(
//                //   color: Colors.yellow,
//                   borderRadius: BorderRadius.circular(16)
//                 ),
//                 child: GoogleMap(
//                   onMapCreated: _onMapCreated,
//                   initialCameraPosition: CameraPosition(
//                     target: _center,
//                     zoom: 11.0,
//                   ),
//                   myLocationEnabled: true,
//                   myLocationButtonEnabled: true,
//                   markers: {
//                     Marker(
//                       markerId: MarkerId('center'),
//                       position: _center,
//                     ),
//                   },
//                 ),
//               ),
//               SizedBox(height: 10,),
//               Text("Checking Your Location...",style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.w600,
//                 // fontFamily: 'poppins'
//               ),),
//              // SizedBox(height: 10,),
//               Text("you are in radius area",
//                 style: TextStyle(
//                     fontWeight: FontWeight.w500,
//                     fontSize: 15,
//                     color: Colors.black
//                 ),),
//               SizedBox(height: 10,),
//               Container(
//                 height: sizeHeight2*0.15,
//                 width: sizeWidth2,
//                 decoration: BoxDecoration(
//                   color: appColor2,
//                   borderRadius: BorderRadius.circular(32)
//                 ),
//                 child: TextButton(onPressed: (){
//                   Get.to(()=>Attendance());
//                 },child: Text("Check - In",
//                 style: TextStyle(
//                   fontWeight: FontWeight.w600,
//                   fontSize: 18,color: Colors.white
//                 ),),),
//               ),
//
//             ],
//           ),
//         ),
//       );
//       });
//     }
//     );
//   }
// }
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nd_connect_techland/components/styles.dart';
import 'package:nd_connect_techland/modules/all_pages/attendance/attendance.dart';
import '../../../controllers/location_controller.dart';

class AttendanceBottomSheet extends StatelessWidget {
  AttendanceBottomSheet({super.key});

  Completer<GoogleMapController> _controller = Completer();
  LatLng _center = const LatLng(28.582813, 77.314373);

  final LocationController locationController = Get.put(LocationController());

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation){
      return LayoutBuilder(builder: (context, constraints){
        var screenWidth = constraints.maxWidth;
        var screenHeight = constraints.maxHeight;

        var sizeWidth2 = orientation == Orientation.portrait
            ? screenWidth * 0.9
            : screenWidth * 0.88;
        var sizeHeight2 = orientation == Orientation.portrait
            ? screenHeight * 0.88
            : screenHeight * 0.88;

        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Map Container
                Obx(() => Container(
                  height: sizeHeight2 * 0.70,
                  width: sizeWidth2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: GoogleMap(
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(locationController.latitude.value, locationController.longitude.value),
                      zoom: 15.0,
                    ),
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                    markers: {
                      Marker(
                        markerId: MarkerId('center'),
                        position:  locationController.center ??
                        _center ,// Fallback to default center if null,
                        infoWindow: InfoWindow(
                          title: locationController.address.value,
                         // snippet: '5 Star Rating',
                        ),
                      ),
                    },
                  ),
                )),
                SizedBox(height: 10,),
                Obx(() => Text(
                  locationController.errorMessage.value.isNotEmpty
                      ? locationController.errorMessage.value
                      : "Checking Your Location...",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600,color: Colors.black87,decoration: TextDecoration.none),
                )),
                SizedBox(height: 10,),
                Container(
                  height: sizeHeight2 * 0.15,
                  width: sizeWidth2,
                  decoration: BoxDecoration(
                    color: appColor2,
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: TextButton(
                    onPressed: () async {
                      print("locationnnn:");


                        // Fetch coordinates asynchronously and wait until it's done
                        await locationController.getCoordinatesFromAddress();

                        // Ensure that the coordinates are available before navigation
                        if (locationController.latitude.value != 0.0 && locationController.longitude.value != 0.0) {
                          print("Navigating to Attendance screen");
                          // Navigate to Attendance screen
                          Get.off(() => Attendance(id: '13',)); // This will remove the current screen from the stack
                        } else {
                          // Show error or handle failed location fetch
                          Get.snackbar(
                            "Location Error",
                            locationController.errorMessage.value.isNotEmpty
                                ? locationController.errorMessage.value
                                : "Unable to fetch location. Please try again.",
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        }


                    },

                    child: Text(
                      "Check - In",
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      });
    });
  }
}
