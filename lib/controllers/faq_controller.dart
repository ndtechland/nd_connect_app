import 'package:get/get.dart';
import 'package:nd_connect_techland/models/faq_model.dart';

import '../services_apis/api_servicesss.dart';
class FaqController extends GetxController{
  final isLoading = false.obs;
  RxList<FaqData> faqData = <FaqData>[].obs;

  Future<void> FaqApi() async {
    isLoading.value = true;
    try {
      List<FaqData> faqs = await ApiProvider.GetFaq();
      if (faqs.isNotEmpty) {
        faqData.value = faqs;
      }
    } catch (e) {
      print('Error fetching faqs: $e');
    } finally {
      isLoading.value = false;
    }
  }
}