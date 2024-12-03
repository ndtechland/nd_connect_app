import 'package:flutter/material.dart';
import 'package:nd_connect_techland/components/styles.dart';
import 'package:get/get.dart';
import 'package:nd_connect_techland/modules/all_pages/pages/testtt.dart';
import 'package:nd_connect_techland/modules/all_pages/pages/willPop_scope_exit.dart';
import '../../../controllers/bottom_nav_controller.dart';
import '../../../test/trip_form_controller.dart';
import '../../../test/trip_form_page.dart';
import '../../bottom_bar/bottom_bar.dart';
import 'emploree_pages/change_password_employee.dart';
import 'emploree_pages/profile_employee/update_add_profile/personal_information_update.dart';
import 'emploree_pages/profile_employee/update_add_profile/update_add_bank_detail.dart';

class Settingss extends StatelessWidget {
  String id ='14';
   Settingss({super.key,required this.id});

  @override
  Widget build(BuildContext context) {
    bool shouldPop = true;

    final BottomNavController bottomNavController = Get.put(BottomNavController());
    final TripFormController tripFormController = Get.put(TripFormController());

    List<String> settingList = [
      "Account Settings",
      "Profile Settings",
      "Notification Settings",
      "Password Settings",
    ];
    return WillPopScope(
      onWillPop: () => showExitPopup(context),
      // onWillPop: () async {
      //   bottomNavController.changeTabIndex(0);
      //   return shouldPop;
      // },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: appColor2,
          leading: IconButton(onPressed: (){
            bottomNavController.changeTabIndex(0);
            Get.offAll(()=>BottomBar());

          }, icon: Icon(Icons.arrow_back,color: Colors.white,)),
          centerTitle: true,
          title: Text("Settings",style: TextStyle(
              color: Colors.white,fontSize: 20
          ),),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
            Padding(
            padding: const EdgeInsets.fromLTRB(12.0,8.0,12.0,0),
            child: GestureDetector(
              onTap: (){
                Get.to(()=> BankDetailUpdateEmployeeProfile());
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 2,
                child: Container(
                    alignment: Alignment.centerLeft,
                    width: double.infinity,
                    height: 80,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 18.0,right: 18.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Account Settings",
                            style: TextStyle(
                                fontSize: 16,fontWeight: FontWeight.w600,color: appColor2
                            ),),
                          Icon(Icons.arrow_circle_right_rounded,color: appColor2,)
                        ],
                      ),
                    )),
              ),
            ),
          ), Padding(
            padding: const EdgeInsets.fromLTRB(12.0,8.0,12.0,0),
            child: GestureDetector(
              onTap: () async{

                Get.to(()=>PersonalUpdateProfile());
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 2,
                child: Container(
                    alignment: Alignment.centerLeft,
                    width: double.infinity,
                    height: 80,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 18.0,right: 18.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Profile Settings",
                            style: TextStyle(
                                fontSize: 16,fontWeight: FontWeight.w600,color: appColor2
                            ),),
                          Icon(Icons.arrow_circle_right_rounded,color: appColor2,)
                        ],
                      ),
                    )),
              ),
            ),
          ),
                Padding(
            padding: const EdgeInsets.fromLTRB(12.0,8.0,12.0,0),
            child: GestureDetector(
              onTap: () async{
                await tripFormController.fetchTripTypes();
                await tripFormController.fetchShiftTypes();
                await tripFormController.fetchPickupShiftTime();
                await tripFormController.fetchDropShiftTime();
                Get.to(()=>TripFormPage());
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 2,
                child: Container(
                    alignment: Alignment.centerLeft,
                    width: double.infinity,
                    height: 80,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 18.0,right: 18.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Trip Form Settings",
                            style: TextStyle(
                                fontSize: 16,fontWeight: FontWeight.w600,color: appColor2
                            ),),
                          Icon(Icons.arrow_circle_right_rounded,color: appColor2,)
                        ],
                      ),
                    )),
              ),
            ),
          ),
                Padding(
            padding: const EdgeInsets.fromLTRB(12.0,8.0,12.0,0),
            child: GestureDetector(
              onTap: (){
                Get.to(()=>ChangeEmployeePassword());
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 2,
                child: Container(
                    alignment: Alignment.centerLeft,
                    width: double.infinity,
                    height: 80,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 18.0,right: 18.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Password Settings",
                            style: TextStyle(
                                fontSize: 16,fontWeight: FontWeight.w600,color: appColor2
                            ),),
                          Icon(Icons.arrow_circle_right_rounded,color: appColor2,)
                        ],
                      ),
                    )),
              ),
            ),
          ),
              ],
            ),
            // ListView.builder(
            //     itemCount: settingList.length,
            //     itemBuilder: (context,index)
            // {
            //   return Padding(
            //     padding: const EdgeInsets.fromLTRB(12.0,8.0,12.0,0),
            //     child: GestureDetector(
            //       onTap: (){},
            //       child: Card(
            //         shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(10),
            //       ),
            //         elevation: 2,
            //         child: Container(
            //           alignment: Alignment.centerLeft,
            //             width: double.infinity,
            //             height: 80,
            //             child: Padding(
            //               padding: const EdgeInsets.only(left: 18.0,right: 18.0),
            //               child: Row(
            //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                 children: [
            //                   Text("${settingList[index]}",
            //                   style: TextStyle(
            //                     fontSize: 16,fontWeight: FontWeight.w600,color: appColor2
            //                   ),),
            //                   Icon(Icons.arrow_circle_right_rounded,color: appColor2,)
            //                 ],
            //               ),
            //             )),
            //       ),
            //     ),
            //   );
            // })
          ),
        ),
      ),
    );
  }
}
