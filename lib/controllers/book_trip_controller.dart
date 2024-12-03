import 'package:get/get.dart';
import 'package:nd_connect_techland/models/test_model/get_trip_type_model.dart';
import 'package:nd_connect_techland/services_apis/api_servicesss.dart';

class BookTripController extends GetxController{
  var isLoading = false.obs;
  var tripTypeId =0.obs;
  GetTripTypeModel? getTripTypeModel;
  Future<void> EventsApi() async {
    isLoading.value = true;
    try {
      GetTripTypeModel? apiResponse = await ApiProvider.getTripType();
      if (apiResponse != null && apiResponse.succeeded == true) {

        // Update events map with API data
        // _updateEvents(apiResponse.data ?? []);
      } else {
        print('Error: ${apiResponse?.message}');
      }
    } catch (e) {
      print('Error fetching events: $e');
    } finally {
      isLoading.value = false;
    }
  }
}