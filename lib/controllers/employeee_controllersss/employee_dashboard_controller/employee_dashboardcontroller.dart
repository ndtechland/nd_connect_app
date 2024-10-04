import 'package:nd_connect_techland/constants/static_text.dart';
import 'package:open_file/open_file.dart';
import 'dart:async';
import 'dart:io';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import '../../../models/employee_model/dashboard_employee_model.dart';
import '../../../services_apis/api_servicesss.dart';
import 'package:http/http.dart' as http;

class HomedashboardController extends GetxController {
  RxBool isLoading = true.obs;
  // Rx<DashbordModel?> dashboardResponse = Rx<DashbordModel?>;
  DashbordModel? dashboardResponse;
  var aptLetter = ''.obs;
  var offLetter = ''.obs;
  Future<void> dashboarddApi() async {
    isLoading(true);
    dashboardResponse = await ApiProvider.getDashboardApi();

    if (dashboardResponse?.data?.totalAttendance == null) {
      Timer(
        const Duration(seconds: 1),
        () {
          //Get.snackbar("Fail", "${medicinecheckoutModel?.data}");
          //Get.to(() => MedicineCart());
          //Get.to((page))
          ///
        },
      );
      isLoading(true);
      dashboardResponse = await ApiProvider.getDashboardApi();
    }
    if (dashboardResponse?.data?.totalAttendance != null) {
      aptLetter.value =
      "${FixedText.apiurl2}${dashboardResponse!.data!.appointmentletter.toString()}";
      offLetter.value= "${FixedText.apiurl2}${dashboardResponse!.data!.offerletter.toString()}";
      print("aptLetter: ${aptLetter.value}");
      //Get.to(() => TotalPrice());
      isLoading(false);
    }else {
      aptLetter.value = ''; // Handle case when it's null
    }
    isLoading(false);
  }
  Future<void> openDocument(String url) async {
    try {
      var formattedUrl = Uri.parse(url).toString();  // Ensure URL is correctly formatted
      var tempDir = await getTemporaryDirectory();
      var fileName = formattedUrl.split('/').last;
      fileName = _sanitizeFileName(fileName);  // Sanitize file name
      var tempFile = File('${tempDir.path}/$fileName');

      if (!await tempFile.exists()) {
        var response = await http.get(Uri.parse(formattedUrl));

        if (response.statusCode == 200) {
          await tempFile.writeAsBytes(response.bodyBytes);
        } else {
          throw Exception('Failed to download file: ${response.statusCode}');
        }
      }

      if (await tempFile.exists()) {
        await OpenFile.open(tempFile.path);
        print("File opened: ${tempFile.path}");
      } else {
        print("File does not exist after download: ${tempFile.path}");
      }
    } catch (e, stackTrace) {
      print("Error opening file: $e");
      print("Stack trace: $stackTrace");
    }
  }

  // Sanitize file name to remove invalid characters
  String _sanitizeFileName(String fileName) {
    return fileName.replaceAll(RegExp(r'[<>:"/\\|?*]'), '_');
  }
  @override
  void onInit() {
    super.onInit();
    dashboarddApi();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
