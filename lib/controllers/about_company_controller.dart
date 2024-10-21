import 'package:get/get.dart';
import 'package:nd_connect_techland/models/about_company_model.dart';
import 'package:nd_connect_techland/services_apis/api_servicesss.dart';
class AboutCompanyController extends GetxController{
  var isLoading = false.obs;
  AboutCompanyModel? aboutCompanyModel;
  Future<void> AboutCompanyApi() async{
    try{
      isLoading=true.obs;
      aboutCompanyModel= await ApiProvider.aboutCompany();
      print("companyUrl");

    }catch(e){
      print("Error, No Url Found :$e");
    }
  }
}