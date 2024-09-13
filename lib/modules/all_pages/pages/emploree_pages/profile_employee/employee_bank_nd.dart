import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../components/styles.dart';
import '../../../../../controllers/employee_controller/profile_controller/profile_info_employee_controller.dart';
import 'package:google_fonts/google_fonts.dart';
class EmployeeBankNd extends StatelessWidget {
  const EmployeeBankNd({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileEmployeeController _getprofileebnk = Get.put(ProfileEmployeeController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_outlined),
          onPressed: (){
            Navigator.pop(context);
           // Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>HomeEmployee2()));
            },
        ),
        title: Text("Employee Bank Details",
          style:TextStyle(
            fontFamily: 'medium',
            fontSize: 18
          ),),
        centerTitle: true,
        elevation: 0,
      ),
      body: OrientationBuilder(builder: (context, orientation){
        return LayoutBuilder(builder: (context, constraints){
          var screenWidth = constraints.maxWidth;
          var screenHeight = constraints.maxHeight;

          var imageWidth = orientation == Orientation.portrait
              ? screenWidth * 0.55
              : screenWidth * 0.25;
          var imageHeight = orientation == Orientation.portrait
              ? screenHeight * 0.2
              : screenHeight * 0.5;

          var imageWidth2 = orientation == Orientation.portrait
              ? screenWidth * 0.55
              : screenWidth * 0.19;
          var imageHeight2 = orientation == Orientation.portrait
              ? screenHeight * 0.32
              : screenHeight * 0.5;

          var categoryWidth = orientation == Orientation.portrait
              ? screenWidth * 0.5
              : screenWidth * 0.3;
          var categoryHeight = orientation == Orientation.portrait
              ? screenHeight * 0.42
              : screenHeight * 0.37;
          return SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [
                      SizedBox(height: 20,),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            blackHeadingSmall('Bank Details'.toUpperCase()),
                            GestureDetector(
                                onTap: () async {

                                },
                                child: appcolorText('Edit'))
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.0),
                              boxShadow: [BoxShadow(
                                  spreadRadius:2.0 ,
                                  blurStyle: BlurStyle.outer,
                                  blurRadius: 5,
                                  color: Colors.black26,
                                  offset: Offset(0,5)
                              )]
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Text("Information",
                                //   //"${_getprofilee.getprofileModel?.response!.emailId.toString()}",
                                //   style:GoogleFonts.lato(textStyle: TextStyle(fontSize: 22, color: Colors.black,fontWeight: FontWeight.bold)),
                                // ),
                                // const SizedBox(height: 10),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("A/C Holder Name:",
                                      //"${_getprofilee.getprofileModel?.response!.emailId.toString()}",
                                      style:GoogleFonts.lato(textStyle: TextStyle(fontSize: 14, color: Color(0xff79829E),fontWeight: FontWeight.w500)),
                                    ),
                                    SizedBox(width: 8,),
                                    Text(
                                    //  "",
                                    "${_getprofileebnk.getbankprofiledetail?.data!.accountHolderName.toString()}",
                                      style: TextStyle(fontSize: 16, color: Colors.black,fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("BankName:",
                                      //"${_getprofilee.getprofileModel?.response!.emailId.toString()}",
                                      style:GoogleFonts.lato(textStyle: TextStyle(fontSize: 14, color: Color(0xff79829E),fontWeight: FontWeight.w500)),
                                    ),
                                    SizedBox(width: 8,),
                                    Text(
                                     // "",
                                      "${_getprofileebnk.getbankprofiledetail?.data?.bankName.toString()}",
                                      style: TextStyle(fontSize: 16, color: Colors.black,fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("A/C Number:",
                                      //"${_getprofilee.getprofileModel?.response!.emailId.toString()}",
                                      style:GoogleFonts.lato(textStyle: TextStyle(fontSize: 14, color: Color(0xff79829E),fontWeight: FontWeight.w500)),
                                    ),
                                    SizedBox(width: 8,),
                                    Text(
                                      //"",
                                      "${_getprofileebnk.getbankprofiledetail?.data?.accountNumber.toString()}",
                                      style: TextStyle(fontSize: 16, color: Colors.black,fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("IFSC Code:",
                                      //"${_getprofilee.getprofileModel?.response!.emailId.toString()}",
                                      style:GoogleFonts.lato(textStyle: TextStyle(fontSize: 14, color: Color(0xff79829E),fontWeight: FontWeight.w500)),
                                    ),
                                    SizedBox(width: 8,),
                                    Text(
                                      "${_getprofileebnk.getbankprofiledetail?.data!.ifsc.toString()}",
                                      //"${_getprofilee.getprofileModel?.data!.joiningDate.toString().substring(0,10)}",
                                      style: TextStyle(fontSize: 16, color: Colors.black,fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("EPF Number:",
                                      //"${_getprofilee.getprofileModel?.response!.emailId.toString()}",
                                      style:GoogleFonts.lato(textStyle: TextStyle(fontSize: 14, color: Color(0xff79829E),fontWeight: FontWeight.w500)),
                                    ),
                                    SizedBox(width: 8,),
                                    Text(
                                      "${_getprofileebnk.getbankprofiledetail?.data?.epfNumber.toString()}",
                                      //"${_getprofilee.getprofileModel?.data!.joiningDate.toString().substring(0,10)}",
                                      style: TextStyle(fontSize: 16, color: Colors.black,fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ), const SizedBox(height: 10),Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Nominee:",
                                      //"${_getprofilee.getprofileModel?.response!.emailId.toString()}",
                                      style:GoogleFonts.lato(textStyle: TextStyle(fontSize: 14, color: Color(0xff79829E),fontWeight: FontWeight.w500)),
                                    ),
                                    SizedBox(width: 8,),
                                    Text(
                                      "${_getprofileebnk.getbankprofiledetail?.data?.nominee.toString()}",
                                      //"${_getprofilee.getprofileModel?.data!.joiningDate.toString().substring(0,10)}",
                                      style: TextStyle(fontSize: 16, color: Colors.black,fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ), const SizedBox(height: 10),Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("EPF Number:",
                                      //"${_getprofilee.getprofileModel?.response!.emailId.toString()}",
                                      style:GoogleFonts.lato(textStyle: TextStyle(fontSize: 14, color: Color(0xff79829E),fontWeight: FontWeight.w500)),
                                    ),
                                    SizedBox(width: 8,),
                                    Text(
                                      "${_getprofileebnk.getbankprofiledetail?.data?.epfNumber.toString()}",
                                      //"${_getprofilee.getprofileModel?.data!.joiningDate.toString().substring(0,10)}",
                                      style: TextStyle(fontSize: 16, color: Colors.black,fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ), const SizedBox(height: 10),

                              ],
                            ),
                          ),),
                      ),
                    ],
                  ),
                ),
              ));
        });
      }),
    );
  }
}
