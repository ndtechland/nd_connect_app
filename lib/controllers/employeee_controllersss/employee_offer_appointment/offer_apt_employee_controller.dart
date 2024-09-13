// import 'dart:async';
// import 'dart:io';
// import 'package:open_file/open_file.dart';
// import 'package:get/get_rx/src/rx_types/rx_types.dart';
// import 'package:get/get_state_manager/get_state_manager.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:http/http.dart' as http;
// import '../../../models/employee_model/offer_appointment_latter_model.dart';
// import '../../../services_apis/api_servicesss.dart';
// import 'package:get/get.dart';
// class AptOfferEmployeeController extends GetxController {
//   RxBool isLoading = true.obs;
//
//   RxString cvUrl = ''.obs;
//   var aptLetter = ''.obs;
//
//   GetOfferAppointmentModel? getampofferModel;
//
//   //PriofileBankDetailEmployeeApi
//
//   // Future<void> ampofferemployeeApi() async {
//   //   isLoading(true);
//   //   getampofferModel = await ApiProvider.OfferAppointmentEmployeeApi();
//   //
//   //   if (getampofferModel?.data?.offerletter == null) {
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
//   //     getampofferModel = await ApiProvider.OfferAppointmentEmployeeApi();
//   //   }
//   //   if (getampofferModel?.data?.offerletter != null) {
//   //     //Get.to(() => TotalPrice());
//   //     isLoading(false);
//   //   }
//   // }
//
//   Future<void> ampofferemployeeApi() async {
//     try {
//       isLoading(true);
//       getampofferModel = await ApiProvider.OfferAppointmentEmployeeApi();
//
//       if (getampofferModel?.data?.appointmentletter != null) {
//         // Assuming your base URL is "https://new.signatureresorts.in"
//         aptLetter.value = "https://admin.hirejobindia.com/${getampofferModel!.data!.appointmentletter.toString()}";
//         print("aptLetter:${aptLetter.value}");
//       } else {
//         aptLetter.value = ''; // Handle case when it's null
//       }
//     } finally {
//       isLoading(false);
//     }
//   }
//   Future<void> openDocument(String url) async {
//     try {
//       var tempDir = await getTemporaryDirectory();
//       var fileName = url.split('/').last;
//       var tempFile = File('${tempDir.path}/$fileName');
//
//       if (!await tempFile.exists()) {
//         var response = await http.get(Uri.parse(url));
//
//         if (response.statusCode == 200) {
//           await tempFile.writeAsBytes(response.bodyBytes);
//         } else {
//           throw Exception('Failed to download file: ${response.statusCode}');
//         }
//       }
//
//       await OpenFile.open(tempFile.path);
//       print("File opened: ${tempFile.path}");
//       print("URL: $url");
//       print("Temp file path: ${tempFile.path}");
//     } catch (e, stackTrace) {
//       print("Error opening file: $e");
//       print("Stack trace: $stackTrace");
//     }
//   }
//
//   // Future<void> openDocument(String url) async {
//   //   try {
//   //     var tempDir = await getTemporaryDirectory();
//   //     var tempFile = File('${tempDir.path}/${url.split('/').last}');
//   //     if (!await tempFile.exists()) {
//   //       var response = await http.get(Uri.parse("https://admin.hirejobindia.com/$url"));
//   //       await tempFile.writeAsBytes(response.bodyBytes);
//   //     }
//   //     await OpenFile.open(tempFile.path.toString());
//   //     print("temp:${tempFile.path}");
//   //     print("tempp:${tempFile}");
//   //   } catch (e) {
//   //     print("Error opening file: $e");
//   //   }
//   // }
//   @override
//   void onInit() {
//     super.onInit();
//     ampofferemployeeApi();
//   }
//
//   @override
//   void onClose() {
//     super.onClose();
//   }
// }
import 'dart:async';
import 'dart:io';
import 'package:open_file/open_file.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import '../../../models/employee_model/offer_appointment_latter_model.dart';
import '../../../services_apis/api_servicesss.dart';

class AptOfferEmployeeController extends GetxController {
  RxBool isLoading = true.obs;
  RxString cvUrl = ''.obs;
  var aptLetter = ''.obs;
  var offLetter = ''.obs;
  GetOfferAppointmentModel? getampofferModel;

  // Fetch offer appointment data
  Future<void> ampofferemployeeApi() async {
    try {
      isLoading(true);
      getampofferModel = await ApiProvider.OfferAppointmentEmployeeApi();

      if (getampofferModel?.data?.appointmentletter != null) {
        // Assuming your base URL is "https://admin.hirejobindia.com"
        aptLetter.value =
     //   "https://ijrti.org/papers/IJRTI2206109.pdf";
       "https://admin.hirejobindia.com/${getampofferModel!.data!.appointmentletter.toString()}";
      offLetter.value= "https://admin.hirejobindia.com/${getampofferModel!.data!.offerletter.toString()}";
        print("aptLetter: ${aptLetter.value}");
      } else if(getampofferModel?.data?.appointmentletter == null){
        aptLetter.value =
           "https://ijrti.org/papers/IJRTI2206109.pdf";
        offLetter.value =
           "https://ijrti.org/papers/IJRTI2206109.pdf";
      }
      else {
        aptLetter.value = ''; // Handle case when it's null
      }
    } finally {
      isLoading(false);
    }
  }

  // Open document from URL
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
    ampofferemployeeApi();
  }

  @override
  void onClose() {
    super.onClose();
  }
}