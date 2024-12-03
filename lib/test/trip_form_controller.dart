import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nd_connect_techland/models/test_model/drop_time_model.dart';
import 'package:nd_connect_techland/models/test_model/pickup_time_model.dart';
import 'package:nd_connect_techland/models/test_model/shift_type_model.dart';

import '../models/test_model/get_trip_type_model.dart';
import '../services_apis/api_servicesss.dart'; // Make sure to import this for date formatting

class TripFormController extends GetxController {
  var isLoading = false.obs;

  var empId = ''.obs;
  var startDate = Rxn<DateTime>();
  var endDate = Rxn<DateTime>();
  var selectedTripType = ''.obs;
  var selectedTripTypeId = 0.obs;
  var selectedShift = ''.obs;
  var selectedShiftId = 0.obs;
  var selectedFacility = ''.obs;
  var selectedPickupShift = ''.obs;
  var selectedPickupShiftId = 0.obs;
  var selectedDropShift = ''.obs;
  var selectedDropShiftId = 0.obs;
  var tripTypes = [].obs;
  var shifts = [].obs;
  var dropShifts = [].obs;
  var pickupShifts = [].obs;
  List<String> facilities = ['Normal', 'Single', 'Facility C'];
  GetTripTypeModel? getTripTypeModel;
  GetShiftTypeModel? getShiftTypeModel;
  GetPickupShiftTimeModel? getPickupShiftTimeModel;
  GetDropShiftTimeModel? getDropShiftTimeModel;

  Future<void> fetchTripTypes() async {
    isLoading.value = true;
    try {
      getTripTypeModel = await ApiProvider.getTripType();
      if (getTripTypeModel != null && getTripTypeModel?.succeeded == true) {
        // Map the API data to the tripTypes list
        print("selectedTripTypeIdd : $selectedTripTypeId");

        tripTypes.value = getTripTypeModel?.data ??[];
        // tripTypes = getTripTypeModel?.data?.map((e) => e.tripTypeName ?? '').toList() ?? [];
        // selectedTripTypeId.value = apiResponse.data?.isNotEmpty == true
        //     ? apiResponse.data!.first.id ?? 0
        //     : 0;
        //
        // print("Trip Types: $tripTypes");
        // print("Selected Trip Type ID: $selectedTripTypeId");
        update(); // Notify UI to refresh the tripTypes list
      } else {
        print('Error: ${getTripTypeModel?.message}');
      }
    } catch (e) {
      print('Error fetching trip types: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void selectTripType(int id) {
    print("selectedTripTypeId : $selectedTripTypeId");
    selectedTripTypeId.value = id;
  }

  Future<void> fetchShiftTypes() async {
    isLoading.value = true;
    try {
      getShiftTypeModel = await ApiProvider.getShiftType();
      if (getShiftTypeModel != null && getShiftTypeModel?.succeeded == true) {
        // Map the API data to the tripTypes list
        shifts.value = getShiftTypeModel?.data ??[];

        // shifts = apiResponse.data?.map((e) => e.tripName ?? '').toList() ?? [];

        update(); // Notify UI to refresh the tripTypes list
      } else {
        print('Error: ${getShiftTypeModel?.message}');
      }
    } catch (e) {
      print('Error fetching trip types: $e');
    } finally {
      isLoading.value = false;
    }
  }
  void selectShiftType(int id) {
    selectedShiftId.value = id;
  }

  Future<void> fetchPickupShiftTime() async {
    isLoading.value = true;
    try {
      getPickupShiftTimeModel = await ApiProvider.getPickupShiftTime();
      if (getPickupShiftTimeModel != null && getPickupShiftTimeModel?.succeeded == true) {
        // Map the API data to the tripTypes list
        pickupShifts.value = getPickupShiftTimeModel?.data ??[];

        // pickupShifts = apiResponse.data?.map((e) => e.shiftTime ?? '').toList() ?? [];

        update(); // Notify UI to refresh the tripTypes list
      } else {
        print('Error: ${getPickupShiftTimeModel?.message}');
      }
    } catch (e) {
      print('Error fetching trip types: $e');
    } finally {
      isLoading.value = false;
    }
  }
  void selectPickupTime(int id) {
    selectedPickupShiftId.value = id;
  }

  Future<void> fetchDropShiftTime() async {
    isLoading.value = true;
    try {
      getDropShiftTimeModel = await ApiProvider.getDropShiftTime();
      if (getDropShiftTimeModel != null && getDropShiftTimeModel?.succeeded == true) {
        // Map the API data to the tripTypes list
        dropShifts.value = getDropShiftTimeModel?.data ??[];

        // dropShifts = apiResponse.data?.map((e) => e.shiftTime ?? '').toList() ?? [];

        update(); // Notify UI to refresh the tripTypes list
      } else {
        print('Error: ${getDropShiftTimeModel?.message}');
      }
    } catch (e) {
      print('Error fetching trip types: $e');
    } finally {
      isLoading.value = false;
    }
  }
  void selectDropTime(int id) {
    selectedDropShiftId.value = id;
  }

  Future<void> sendBookTripApi() async {
    try {
      isLoading.value = true;
      final response = await ApiProvider.bookTrip(
          selectedShiftId.value,
          selectedTripTypeId.value,
          startDate.value.toString(),
          endDate.value.toString(),
          selectedPickupShiftId.value,
          selectedDropShiftId.value
      );
      print("response request ${response?.body}");
    } catch (e) {
      print('Error during check-in: $e');
    } finally {
      // Set loading state to false after the API call completes
      isLoading.value = false;
    }
  }

  Future<void> selectStartDate(BuildContext context) async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(new Duration(days: 30)),);
    if (date != null) {
      startDate.value = date;
    }
  }

  Future<void> selectEndDate(BuildContext context) async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate:startDate.value,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(new Duration(days: 30)),
    );
    if (date != null) {
      endDate.value = date;
    }
  }

  String formatDate(DateTime? date) {
    if (date == null) return '';
    return DateFormat('d MMM y').format(date); // Adjust format as needed
  }
}