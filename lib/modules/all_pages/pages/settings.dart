import 'package:flutter/material.dart';
import 'package:nd_connect_techland/components/styles.dart';
import 'package:get/get.dart';
import '../../../controllers/bottom_nav_controller.dart';
class Settings extends StatelessWidget {
  String id ='14';
   Settings({super.key,required this.id});

  @override
  Widget build(BuildContext context) {
    final BottomNavController bottomNavController = Get.find<BottomNavController>();

    List<String> settingList = [
      "Account Settings",
      "Profile Settings",
      "Notification Settings",
      "Password Settings",
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColor2,
        leading: IconButton(onPressed: (){
          bottomNavController.changeTabIndex(0);
        }, icon: Icon(Icons.arrow_back,color: Colors.white,)),
        centerTitle: true,
        title: Text("Settings",style: TextStyle(
            color: Colors.white,fontSize: 20
        ),),
      ),
      body: Container(
        child: ListView.builder(
            itemCount: settingList.length,
            itemBuilder: (context,index)
        {
          return Padding(
            padding: const EdgeInsets.fromLTRB(12.0,8.0,12.0,0),
            child: GestureDetector(
              onTap: (){},
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
                          Text("${settingList[index]}",
                          style: TextStyle(
                            fontSize: 16,fontWeight: FontWeight.w600,color: appColor2
                          ),),
                          Icon(Icons.arrow_circle_right_rounded,color: appColor2,)
                        ],
                      ),
                    )),
              ),
            ),
          );
        })
      ),
    );
  }
}
