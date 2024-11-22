import 'package:get/get.dart';
import 'package:nd_connect_techland/services_apis/api_servicesss.dart';
class WfhController extends GetxController{
  var isLoading = false.obs;
  var date1 = "".obs;
  var date2 = "".obs;
  var reason = "".obs;
  Future<void> WfhApi(String date1,String date2,String reason) async{
    try{
      isLoading.value = true;
      final r= await ApiProvider.WorkFromHomeApi(date1.toString() , date2.toString(), reason.toString());
      print("wfh controller:$r");
    }catch(e){}
  }
}