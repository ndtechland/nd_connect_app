import 'dart:io';

import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import '../../../models/employee_model/all_salary_slip_model.dart';
import '../../../services_apis/api_servicesss.dart';

class AllSalarySlipController extends GetxController {
  RxBool isLoading = true.obs;
  AllsalaryslipModells? allSalarySlipModel;
  final ApiProvider _apiProvider = ApiProvider(); // Use ApiProvider instance
  String searchQuery = "";

  RxList<ModelClassSalary> foundSalarySlips = RxList<ModelClassSalary>([]);

  @override
  void onInit() {
    super.onInit();
    fetchSalarySlips();
  }

  Future<void> fetchSalarySlips() async {
    isLoading(true);
    allSalarySlipModel = await ApiProvider.getSalarySlips();
    print('Fetched salary slips: $allSalarySlipModel');
    if (allSalarySlipModel != null) {
      foundSalarySlips.value = allSalarySlipModel!.data!;
    }
    isLoading(false);
  }

  void filterSalarySlips(String searchSalarySlipName) {
    List<ModelClassSalary>? finalResult = [];
    if (searchSalarySlipName.isEmpty) {
      finalResult = allSalarySlipModel!.data;
    } else {
      finalResult = allSalarySlipModel!.data!
          .where((element) => element.salarySlipName!
              .toLowerCase()
              .contains(searchSalarySlipName.toLowerCase().trim()))
          .toList();
    }
    foundSalarySlips.value = finalResult!;
    print('Filtered salary slips: ${foundSalarySlips.length}');
  }

  void viewForSlip(ModelClassSalary job) {
    // Implement view functionality for a salary slip
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
}
