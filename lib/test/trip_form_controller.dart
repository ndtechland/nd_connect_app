import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; // Make sure to import this for date formatting

class TripFormController extends GetxController {
  var empId = ''.obs;
  var startDate = Rxn<DateTime>();
  var endDate = Rxn<DateTime>();
  var selectedTripType = ''.obs;
  var selectedShift = ''.obs;
  var selectedFacility = ''.obs;
  var selectedPickupShift = ''.obs;
  var selectedDropShift = ''.obs;

  List<String> tripTypes = ['Both', 'Pickup', 'Drop'];
  List<String> shifts = ['Normal', 'Single', ];
  List<String> dropShifts = ['06:30 pm', '07:30 pm', ];
  List<String> pickupShifts = ['06:30 pm', '07:30 pm', ];
  List<String> facilities = ['Normal', 'Single', 'Facility C'];

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