// import 'package:get/get.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// class LocationController extends GetxController {
//   var latitude = 0.0.obs;
//   var longitude = 0.0.obs;
//   var errorMessage = ''.obs;
//   var isLoading = false.obs;
//
//   Future<void> getCoordinatesFromAddress(String address) async {
//     try {
//       isLoading(true); // Show loading state
//       List<Location> locations = await locationFromAddress(address);
//       if (locations.isNotEmpty) {
//         latitude.value = locations.first.latitude;
//         longitude.value = locations.first.longitude;
//         errorMessage.value = '';
//         LatLng center = const LatLng(latitude.value, longitude.value);
//
//       } else {
//         errorMessage.value = 'No locations found for the provided address.';
//       }
//     } catch (e) {
//       errorMessage.value = 'Failed to get location from address: $e';
//     } finally {
//       isLoading(false); // Hide loading state
//     }
//   }
// }
import 'package:get/get.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationController extends GetxController {
  var latitude = 0.0.obs;
  var longitude = 0.0.obs;
  var errorMessage = ''.obs;
  var isLoading = false.obs;
  LatLng? center;
  var address =' C 53, 1st Floor, C Block, Sector 2, Noida, Uttar Pradesh 201301'.obs;
  Future<void> getCoordinatesFromAddress() async {
    try {
      isLoading(true); // Show loading state
      List<Location> locations = await locationFromAddress(address.toString());
      print("location:$locations");
      if (locations.isNotEmpty) {
        latitude.value = locations.first.latitude;
        longitude.value = locations.first.longitude;
        errorMessage.value = '';
        print("LatLang:${latitude.value} & ${longitude.value}");
        // Use the latitude and longitude without const
        center = LatLng(latitude.value, longitude.value);
      } else {
        errorMessage.value = 'No locations found for the provided address.';
      }
    } catch (e) {
      errorMessage.value = 'Failed to get location from address: $e';
    } finally {
      isLoading(false);
    }
  }
}
