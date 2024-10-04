// import 'dart:async';
//
// import 'package:get/get_rx/src/rx_types/rx_types.dart';
// import 'package:get/get_state_manager/get_state_manager.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:map_launcher/map_launcher.dart';
//
// import '../../../models/employee_model/profile_model/bank_profile_details_employee.dart';
// import '../../../models/employee_model/profile_model/profile_basic_detail_model.dart';
// import '../../../models/employee_model/profile_model/profile_info_model_personal.dart';
// import '../../../services_apis/api_servicesss.dart';
//
// class ProfileEmployeeController extends GetxController {
//   RxBool isLoading = true.obs;
//   RxString _address = "".obs;
//   var _error = ''.obs;
//   var _latitude= 0.0.obs;
//   var _longitude= 0.0.obs;
//  // RxString cvUrl = ''.obs;
//
//   BasicInformationModel? getbasicemployeeModel;
//
//   GetProfileEmployeePersonalModel? getprofileemployeeModel;
//
//   BankDetailInformationModel? getbankprofiledetail;
//
//   //PriofileBankDetailEmployeeApi
//   Future<void> getCoordinatesFromAddress() async {
//     try {
//       isLoading(true); // Show loading state
//       List<Location> locations = await locationFromAddress(_address.toString());
//       if (locations.isNotEmpty) {
//         _latitude.value = locations.first.latitude;
//         _longitude.value = locations.first.longitude;
//         _error.value = '';
//         LatLng center =  LatLng(_latitude.value, _longitude.value);
//
//       } else {
//         _error.value = 'No locations found for the provided address.';
//       }
//     } catch (e) {
//       _error.value = 'Failed to get location from address: $e';
//     } finally {
//       isLoading(false); // Hide loading state
//     }
//   }
//
//   Future<void> launchMaps() async {
//     if (_latitude != null && _longitude != null) {
//       final availableMaps = await MapLauncher.installedMaps;
//
//       if (availableMaps.isNotEmpty) {
//         await availableMaps.first.showMarker(
//           coords: Coords(_latitude as double, _longitude as double),
//           title: _address.toString(),
//         );
//       } else {
//
//           _error.value = 'No map applications available.';
//
//       }
//     }
//   }
//   Future<void> profileemployeeApi() async {
//     isLoading(true);
//     getprofileemployeeModel = await ApiProvider.PriofilePersonalEmployeeApi();
//
//     if (getprofileemployeeModel?.data?.personalEmailAddress == null) {
//       Timer(
//         const Duration(seconds: 1),
//         () {
//           //Get.snackbar("Fail", "${medicinecheckoutModel?.data}");
//           //Get.to(() => MedicineCart());
//           //Get.to((page))
//           ///
//         },
//       );
//       isLoading(true);
//       getprofileemployeeModel = await ApiProvider.PriofilePersonalEmployeeApi();
//     }
//     if (getprofileemployeeModel?.data?.personalEmailAddress != null) {
//       _address.value = getprofileemployeeModel!.data!.companyLocationName.toString();
//       print("company location:${_address}");
//       //Get.to(() => TotalPrice());
//       isLoading(false);
//     }
//   }
//
//   // Future<void> profileBasicemployeeApi() async {
//   //   isLoading(true);
//   //   getbasicemployeeModel = await ApiProvider.PriofileBasicEmployeeApi();
//   //
//   //   if (getbasicemployeeModel?.data?.employeeId == null) {
//   //     Timer(
//   //       const Duration(seconds: 1),
//   //       () {
//   //         //Get.snackbar("Fail", "${medicinecheckoutModel?.data}");
//   //         //Get.to(() => MedicineCart());
//   //         //Get.to((page))
//   //         ///
//   //       },
//   //     );
//   //     isLoading(true);
//   //     getbasicemployeeModel = await ApiProvider.PriofileBasicEmployeeApi();
//   //   }
//   //   if (getbasicemployeeModel?.data?.employeeId != null) {
//   //     //Get.to(() => TotalPrice());
//   //     isLoading(false);
//   //   }
//   // }
//
//   Future<void> profileEmployeBankApi() async {
//     isLoading(true);
//     getbankprofiledetail = await ApiProvider.PriofileBankDetailEmployeeApi();
//
//     if (getbankprofiledetail?.data?.accountHolderName == null) {
//       // Timer(
//       //   const Duration(seconds: 1),
//       //   () {
//       //     //Get.snackbar("Fail", "${medicinecheckoutModel?.data}");
//       //     //Get.to(() => MedicineCart());
//       //     //Get.to((page))
//       //     ///
//       //   },
//       // );
//       isLoading(true);
//       getbankprofiledetail = await ApiProvider.PriofileBankDetailEmployeeApi();
//     }
//     if (getbankprofiledetail?.data?.accountHolderName != null) {
//       //Get.to(() => TotalPrice());
//       isLoading(false);
//     }
//   }
//
//   @override
//   void onInit() {
//     super.onInit();
//     profileemployeeApi();
//    // profileBasicemployeeApi();
//     profileEmployeBankApi();
//     getCoordinatesFromAddress();
//   }
//
//   @override
//   void onClose() {
//     super.onClose();
//   }
// }
import 'dart:async';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_launcher/map_launcher.dart';

import '../../../models/employee_model/profile_model/bank_profile_details_employee.dart';
import '../../../models/employee_model/profile_model/profile_basic_detail_model.dart';
import '../../../models/employee_model/profile_model/profile_info_model_personal.dart';
import '../../../services_apis/api_servicesss.dart';

class ProfileEmployeeController extends GetxController {
  RxBool isLoading = true.obs;
  RxString _address = "".obs;
  var _error = ''.obs;
  var _latitude = 0.0.obs;
  var _longitude = 0.0.obs;

  BasicInformationModel? getbasicemployeeModel;
  GetProfileEmployeePersonalModel? getprofileemployeeModel;
  BankDetailInformationModel? getbankprofiledetail;

  // Fetch coordinates based on the address
  Future<void> getCoordinatesFromAddress() async {
    try {
      isLoading(true); // Show loading state
      List<Location> locations = await locationFromAddress(_address.toString());
      if (locations.isNotEmpty) {
        _latitude.value = locations.first.latitude;
        _longitude.value = locations.first.longitude;
        _error.value = '';
        print("address:${_address}");
        print("latt:${_latitude.value}");
        print("lang:${_longitude.value}");

      } else {
        _error.value = 'No locations found for the provided address.';
      }
    } catch (e) {
      _error.value = 'Failed to get location from address: $e';
    } finally {
      isLoading(false); // Hide loading state
    }
  }

  // Launch map with the location coordinates
  Future<void> launchMaps() async {
    if (_latitude.value != 0.0 && _longitude.value != 0.0) {
      final availableMaps = await MapLauncher.installedMaps;
print("lattLang:${_latitude.value}${_longitude.value}");
      if (availableMaps.isNotEmpty) {
        await availableMaps.first.showMarker(
          coords: Coords(_latitude.value, _longitude.value), // Accessing .value
          title: _address.toString(),
        );
      } else {
        _error.value = 'No map applications available.';
      }
    }
  }

  // Fetch profile employee personal data
  Future<void> profileemployeeApi() async {
    isLoading(true);
    getprofileemployeeModel = await ApiProvider.PriofilePersonalEmployeeApi();

    if (getprofileemployeeModel?.data?.personalEmailAddress == null) {
      Timer(const Duration(seconds: 1), () async {
        isLoading(true);
        getprofileemployeeModel = await ApiProvider.PriofilePersonalEmployeeApi();
      });
    }

    if (getprofileemployeeModel?.data?.personalEmailAddress != null) {
      _address.value = getprofileemployeeModel!.data!.companyLocationName.toString();
      print("company location: $_address");
      isLoading(false);
    }
  }

  // Fetch employee bank details
  Future<void> profileEmployeBankApi() async {
    isLoading(true);
    getbankprofiledetail = await ApiProvider.PriofileBankDetailEmployeeApi();

    if (getbankprofiledetail?.data?.accountHolderName == null) {
      isLoading(true);
      getbankprofiledetail = await ApiProvider.PriofileBankDetailEmployeeApi();
    }
    if (getbankprofiledetail?.data?.accountHolderName != null) {
      isLoading(false);
    }
  }

  @override
  void onInit() {
    super.onInit();
    profileemployeeApi();
    profileEmployeBankApi();
    getCoordinatesFromAddress();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
