import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkerController extends GetxController {
  var companyIcon = Rx<BitmapDescriptor?>(null);
  var userIcon = Rx<BitmapDescriptor?>(null);

  @override
  void onInit() {
    super.onInit();
    loadMarkerIcons();
  }

  Future<void> loadMarkerIcons() async {
    companyIcon.value = await getCompanyMarkerIcon();
    userIcon.value = await getUserMarkerIcon();
  }

  Future<BitmapDescriptor> getCompanyMarkerIcon() async {
    try {
      print("company marker icon loaded");

      return await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(
          size: Size(24, 24), // Adjust the size
          devicePixelRatio: 2.5, // You can tweak this ratio as needed
        ),
        'lib/assets/company.png',
      );
    } catch (e) {
      print("Error loading company marker icon: $e");
      return BitmapDescriptor.defaultMarker;
    }
  }

  Future<BitmapDescriptor> getUserMarkerIcon() async {
    try {
      print("user marker icon loaded");

      return await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(
          size: Size(24, 24), // Adjust the size
          devicePixelRatio: 2.5, // You can tweak this ratio as needed
        ),
        'lib/assets/user_marker.png',
      );
    } catch (e) {
      print("Error loading user marker icon: $e");
      return BitmapDescriptor.defaultMarker;
    }
  }
}
