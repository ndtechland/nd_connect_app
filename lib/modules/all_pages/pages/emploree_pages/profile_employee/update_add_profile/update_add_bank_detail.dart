import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nd_connect_techland/modules/all_pages/pages/emploree_pages/profile_employee/chequePage.dart';
import '../../../../../../components/styles.dart';
import '../../../../../../constants/static_text.dart';
import '../../../../../../controllers/bottom_nav_controller.dart';
import '../../../../../../widget/custom_loader.dart';
import '../../../../../../widget/upload_button.dart';
import '../../../../../bottom_bar/bottom_bar.dart';
import '../../../../../components/styles.dart';

import 'package:permission_handler/permission_handler.dart';

import '../../../../../../controllers/employee_controller/profile_controller/profile_info_employee_controller.dart';
import '../../../../../../controllers/employeee_controllersss/employee_edit_profile_controller/employee_update_personal_controller.dart';
import '../../../../../../controllers/employeee_controllersss/employee_edit_profile_controller/update_bank_employee.dart';
import '../../../../../../controllers/employeee_controllersss/update_profile_image_controller/update_profile_image.dart';
import '../../../../../../widget/elevated_button.dart';
import '../profile_employee.dart';

class BankDetailUpdateEmployeeProfile extends StatefulWidget {
  @override
  _BankDetailUpdateEmployeeProfileState createState() =>
      _BankDetailUpdateEmployeeProfileState();
}

class _BankDetailUpdateEmployeeProfileState
    extends State<BankDetailUpdateEmployeeProfile> {
  final ProfileEmployeeController _getprofileebnk =
      Get.put(ProfileEmployeeController());

  final BankEmployeeUodateController _bankEmployeeUodateController =
      Get.put(BankEmployeeUodateController());
  ProfileEmployeeController _profileEmployeeController = Get.put(ProfileEmployeeController());

  var selectedChequeImage = Rxn<Uint8List>(); // Use Rxn for nullable values

  final TextEditingController _acholdernameController = TextEditingController();
  final TextEditingController _bankController = TextEditingController();

  final TextEditingController _deductioncycleController =
      TextEditingController();
  final TextEditingController _employeecontrobutionController =
      TextEditingController();

  final TextEditingController _accnumberController = TextEditingController();
  final TextEditingController _reenteracnoNumberController =
      TextEditingController();
  final TextEditingController _ifscController = TextEditingController();
  final TextEditingController _acounttypeController = TextEditingController();
  final TextEditingController _epfnumnberController = TextEditingController();
  final TextEditingController _nominiNameController = TextEditingController();
  final TextEditingController _cvFilePathController = TextEditingController();
  final BottomNavController _bottomNavController = Get.put(BottomNavController());

  Uint8List? _cvFileContent;
  Future<void> _refreshData() async {
    // Add logic to refresh data, e.g., fetching from an API
    await Future.delayed(Duration(seconds: 2));
    await _profileEmployeeController.profileEmployeBankApi();
    await Future.delayed(Duration(seconds: 2));
    print("Data refreshed");
  }
  @override
  void initState() {
    super.initState();
    if (_getprofileebnk.getbankprofiledetail != null) {
      _getprofileebnk.getbankprofiledetail!.data!.accountTypeId;
      _bankEmployeeUodateController.selectedAccountType.value = _getprofileebnk.getbankprofiledetail!.data!.accountTypeId.toString();
      print("accountTypeId:${_getprofileebnk.getbankprofiledetail!.data!.accountTypeId}");
      _acholdernameController.text =
          _getprofileebnk.getbankprofiledetail!.data!.accountHolderName!;
      _bankController.text =
          _getprofileebnk.getbankprofiledetail!.data!.bankName!;
      _accnumberController.text =
          _getprofileebnk.getbankprofiledetail!.data!.accountNumber!.toString();
      _reenteracnoNumberController.text = _getprofileebnk
          .getbankprofiledetail!.data!.reEnterAccountNumber!.toString();
      _ifscController.text = _getprofileebnk.getbankprofiledetail!.data!.ifsc!;
      _acounttypeController.text =
          _getprofileebnk.getbankprofiledetail!.data!.accountTypeId.toString();
      _epfnumnberController.text =
          _getprofileebnk.getbankprofiledetail!.data!.epfNumber!;
      _nominiNameController.text =
          _getprofileebnk.getbankprofiledetail!.data!.nominee!;
      //_pincodeController.text =
      // _acholdernameController.text = _getprofileebnk.getbankprofiledetail!.data!.accountHolderName!;
    }
  }

  @override
  void dispose() {
    // _acholdernameController.dispose();
    // _bankController.dispose();
    // _accnumberController.dispose();
    // _reenteracnoNumberController.dispose();
    // _ifscController.dispose();
    // _acounttypeController.dispose();
    // _epfnumnberController.dispose();
    // _nominiNameController.dispose();
    // _cvFilePathController.dispose();
    super.dispose();
  }


  Future<void> _checkAndRequestPermissions() async {
    if (await Permission.storage.request().isGranted) {
      _selectCVFile();
    } else {
      await Permission.storage.request();
      if (await Permission.storage.isGranted) {
        _selectCVFile();
      } else {
        print('Storage permission is required to access files.');
      }
    }
  }
  Future<void> _showChequeFileDialog(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Choose Option'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: Row(
                    children: [
                      Icon(Icons.camera),
                      SizedBox(width: 10),
                      Text('Take Photo'),
                    ],
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    _pickImageChequeFromCamera();
                  },
                ),
                Padding(padding: EdgeInsets.all(8.0)),
                GestureDetector(
                  child: Row(
                    children: [
                      Icon(Icons.image),
                      SizedBox(width: 10),
                      Text('Choose from Gallery'),
                    ],
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    _selectCVFile();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

// Function to pick image from camera
  Future<void> _pickImageChequeFromCamera() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.camera);

      if (image != null) {
        // Convert the selected image to bytes
        final bytes = await image.readAsBytes();

        // Update the selected image and file content
        selectedChequeImage.value = bytes;
        _cvFileContent = bytes;

        // Update the TextField controller with the file name
        _cvFilePathController.text = image.name;
      }
    } catch (e) {
      print('Error capturing image: $e');
    }
  }

  Future<void> _selectCVFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png','pdf'],
        withData: true,
      );
      if (result != null && result.files.isNotEmpty) {
        PlatformFile file = result.files.first;
        print('Selected file: ${file.name}, path: ${file.path}');

        if (file.size! <= 10 * 1024 * 1024) {
          if (file.bytes != null) {
            setState(() {
              _cvFilePathController.text = file.name;
              _cvFileContent = file.bytes!;
              selectedChequeImage.value = file.bytes; // Update the selected image

            });
            print('File size: ${_cvFileContent!.length} bytes');
          } else {
            print('Failed to read file content: File bytes are null');
          }
        } else {
          Fluttertoast.showToast(
              msg: "Selected file exceeds 10MB limit",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      } else {
        print('No file selected');
      }
    } catch (e) {
      print('Error picking file: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColor2,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_outlined,color: Colors.white),
          onPressed: (){
           // _bottomNavController.changeTabIndex(0);
            Navigator.pop(context);
            //Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>BottomBar()));

            // Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>HomeEmployee2()));
          },
        ),
        title: Text("Bank Details",
          style:TextStyle(
              fontFamily: 'medium',
              fontSize: 18,
            color: Colors.white
          ),),
        centerTitle: true,
        elevation: 0,
      ),
      //extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      body: Obx(
        () =>
        (_getprofileebnk.isLoading.value)
            ? Center(child: CircularProgressIndicator())
            :
        WillPopScope(
          onWillPop: () async {
            _bottomNavController.changeTabIndex(0);
            return true;
          },
          child: RefreshIndicator(
            onRefresh: _refreshData,
            child: SingleChildScrollView(
              child: Form(
                key: _bankEmployeeUodateController.bankemployeeFormKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Container(
                  child: Column(
                    children: [
                      //const SizedBox(height: 80),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            blackHeadingSmall('Bank Information'.toUpperCase()),
                            // GestureDetector(
                            //     onTap: () async {
                            //       await _profileEmployeeController
                            //           .profileemployeeApi();
                            //       await _profileEmployeeController
                            //           .profileBasicemployeeApi();
                            //       await _profileEmployeeController
                            //           .profileEmployeBankApi();
                            //
                            //       //profileBasicemployeeApi();
                            //       //     profileEmployeBankApi();
                            //
                            //       _profileEmployeeController.update();
                            //       // await _profileController.profileApi();
                            //       // _profileController.update();
                            //
                            //       Get.off(EmployeeProfile());
                            //       /*await Navigator.push(
                            //           context,
                            //           MaterialPageRoute(
                            //               builder: (context) =>
                            //                   EmployeeProfile()));*/
                            //     },
                            //     child: appcolorText('view'))
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 0),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 16),
                              margin: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 16),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 20.0,
                                  ),
                                ],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6.0)),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(vertical: 0),
                                    child: TextFormField(
                                      controller: _acholdernameController,
                                      decoration: InputDecoration(
                                        labelText: "A/C Holder Name",
                                        hintStyle: TextStyle(fontSize: 13),
                                        labelStyle: const TextStyle(
                                            color: Colors.black54,
                                            fontSize: 13),
                                        focusedBorder:
                                            const UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: appColor2),
                                        ),
                                        enabledBorder:
                                            const UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black12),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(vertical: 0),
                                    child: TextFormField(
                                      controller: _bankController,
                                      decoration: InputDecoration(
                                        labelText: "Bank Name",
                                        hintStyle: TextStyle(fontSize: 13),
                                        labelStyle: const TextStyle(
                                            color: Colors.black54,
                                            fontSize: 13),
                                        focusedBorder:
                                            const UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: appColor2),
                                        ),
                                        enabledBorder:
                                            const UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black12),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(vertical: 0),
                                    child: TextFormField(
                                      controller: _accnumberController,
                                      decoration: InputDecoration(
                                        labelText: "Account Number",
                                        hintStyle: TextStyle(fontSize: 13),
                                        labelStyle: const TextStyle(
                                            color: Colors.black54,
                                            fontSize: 13),
                                        focusedBorder:
                                            const UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: appColor2),
                                        ),
                                        enabledBorder:
                                            const UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black12),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(vertical: 0),
                                    child: TextFormField(
                                      controller: _reenteracnoNumberController,
                                      decoration: InputDecoration(
                                        labelText: "Re-Enter A/C No.",
                                        hintStyle: TextStyle(fontSize: 13),
                                        labelStyle: const TextStyle(
                                            color: Colors.black54,
                                            fontSize: 13),
                                        focusedBorder:
                                            const UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: appColor2),
                                        ),
                                        enabledBorder:
                                            const UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black12),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(vertical: 0),
                                    child: TextFormField(
                                      controller: _ifscController,
                                      decoration: InputDecoration(
                                        labelText: "IFSC Code",
                                        hintStyle: TextStyle(fontSize: 13),
                                        labelStyle: const TextStyle(
                                            color: Colors.black54,
                                            fontSize: 13),
                                        focusedBorder:
                                            const UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: appColor2),
                                        ),
                                        enabledBorder:
                                            const UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black12),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: size.height * 0.02,
                                  ),
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Account Type",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: Colors.grey.shade500,
                                        ),
                                      )),
                                  Container(padding: EdgeInsets.symmetric(vertical: 0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Obx(()=>
                                           RadioListTile(
                                                title: Text(
                                                  'Current',
                                                  style: TextStyle(
                                                    fontSize:
                                                        size.height * 0.014,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                visualDensity: VisualDensity(
                                                  horizontal: VisualDensity
                                                      .minimumDensity,
                                                  vertical: VisualDensity
                                                      .minimumDensity,
                                                ),

                                                // title: Text("Male"),
                                                value:
                                                    //_nurseBooking1Controller.selectedshift.value,
                                                //_acounttypeController.value.text.toString(),
                                                "1",
                                                groupValue:

                                                    _bankEmployeeUodateController.selectedAccountType.value,
                                                onChanged: (value) {
                                                  print("accountType:${_acounttypeController.value.text}");
                                                  _bankEmployeeUodateController
                                                      .onChangeAccountType(value!);
                                                  // setState(() {
                                                  //   gender = value.toString();
                                                  // });
                                                },
                                              ),
                                          ),
                                         // ),
                                        ),
                                        Expanded(
                                          child: Obx(()=>
                                            RadioListTile(
                                                title: Text(
                                                  'Savings',
                                                  style: TextStyle(
                                                    fontSize:
                                                        size.height * 0.014,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                visualDensity: VisualDensity(
                                                  horizontal: VisualDensity
                                                      .minimumDensity,
                                                  vertical: VisualDensity
                                                      .minimumDensity,
                                                ),
                                                // title: Text("Male"),
                                                value:
                                                    //_nurseBooking1Controller.selectedshift.value,
                                                //_acounttypeController.value.text.toString(),
                                                   "2",
                                                groupValue:
                                                // _acounttypeController.value.text == 2?
                                                // _bankEmployeeUodateController.selectedAccountType.value:"",
                                               // _acounttypeController.value.text,
                                                _bankEmployeeUodateController.selectedAccountType.value,
                                                onChanged: (value) {
                                                  print("accountType:${_acounttypeController.value.text}");
                                                  _bankEmployeeUodateController
                                                      .onChangeAccountType(value!);
                                                  // setState(() {
                                                  //   gender = value.toString();
                                                  // });
                                                },
                                              ),
                                          ),
                                          ),
                                       // ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: size.height * 0.005,
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(vertical: 1),
                                    child: TextFormField(
                                      controller: _epfnumnberController,
                                      decoration: InputDecoration(
                                        labelText: "EPF Number",
                                        hintStyle: TextStyle(fontSize: 13),
                                        labelStyle: const TextStyle(
                                            color: Colors.black54,
                                            fontSize: 13),
                                        focusedBorder:
                                            const UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: appColor2),
                                        ),
                                        enabledBorder:
                                            const UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black12),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(vertical: 0),
                                    child: TextFormField(
                                      controller: _nominiNameController,
                                      decoration: InputDecoration(
                                        labelText: "Nominee",
                                        hintStyle: TextStyle(fontSize: 13),
                                        labelStyle: const TextStyle(
                                            color: Colors.black54,
                                            fontSize: 13),
                                        focusedBorder:
                                            const UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: appColor2),
                                        ),
                                        enabledBorder:
                                            const UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black12),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Container(
                                    padding: EdgeInsets.symmetric(vertical: 0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(context, MaterialPageRoute(builder: (_) {
                                              return ChequePage();
                                            }));
                                          },

                                          child: Container(
                                            height: 60,
                                            width: 120,
                                            decoration: BoxDecoration(
                                              border: Border.all(width: 2, color: Colors.grey),
                                                borderRadius: BorderRadius.circular(12.0),
                                            ),
                                            child:Obx(() {
                                              return Hero(
                                                tag: 'chequeImg',
                                                child: selectedChequeImage.value != null
                                                    ? ClipRRect(
                                                  borderRadius: BorderRadius.circular(10.0),
                                                      child: Image.memory(
                                                      selectedChequeImage.value!,
                                                      fit: BoxFit.contain,
                                                      width: double.infinity,
                                                      height: double.infinity,
                                                    ),
                                                    )
                                                    : (_getprofileebnk.getbankprofiledetail!.data!.chequeimage != null
                                                    ? ClipRRect(
                                                  borderRadius: BorderRadius.circular(10.0),
                                                      child: Image.network(
                                                     "${FixedText.imageUrlll}${_getprofileebnk.getbankprofiledetail!.data!.chequeimage}",
                                                     fit: BoxFit.cover,
                                                     errorBuilder: (context, error, stackTrace) {
                                                      return ClipRRect(
                                                        borderRadius: BorderRadius.circular(10.0),
                                                        child: Image.network(
                                                          'https://media.geeksforgeeks.org/wp-content/uploads/20230711180739/Date-the-Cheque.jpg',
                                                          fit: BoxFit.contain,
                                                        ),
                                                      );
                                                        },
                                                      ),
                                                    )
                                                    : ClipRRect(
                                                  borderRadius: BorderRadius.circular(10.0),
                                                      child: Image.asset(
                                                      'https://media.geeksforgeeks.org/wp-content/uploads/20230711180739/Date-the-Cheque.jpg',
                                                      fit: BoxFit.contain,
                                                    ),
                                                    )),
                                              );
                                            }),),
                                        ),
                                        // Container(
                                        //   width:120,
                                        //   height: 80,
                                        //   child: TextFormField(
                                        //     readOnly: true,
                                        //     validator: (value) {
                                        //       if (value == null ||
                                        //           value.isEmpty) {
                                        //         return 'Please select your Check';
                                        //       }
                                        //       return null;
                                        //     },
                                        //     controller: _cvFilePathController,
                                        //     decoration: InputDecoration(
                                        //         labelText: 'Check File'),
                                        //     enabled: false,
                                        //   ),
                                        // ),
                                        SizedBox(width: 10),
                                        UpdateButton(onTap: ()
                                        {
                                          _showChequeFileDialog(context);
                                          //_selectCVFile();
                                          }, text: 'Cheque',),
                                        // NextButton(onTap: () {
                                        //   //_selectCVFile();
                                        // }, text: 'Cheque', h: 50, w: 80,),
                                        // GestureDetector(
                                        //   onTap: (){
                                        //     _selectCVFile();
                                        //   },
                                        //   child: Container(
                                        //     alignment: Alignment.center,
                                        //     width: 80,
                                        //     height: 50,
                                        //     decoration: BoxDecoration(
                                        //       color: appColorr2,
                                        //       borderRadius:
                                        //           BorderRadius.circular(10),
                                        //     ),
                                        //     child: Text(
                                        //       'Cheque',
                                        //       style: TextStyle(
                                        //         fontSize: 12,
                                        //         fontWeight: FontWeight.bold,
                                        //         color: Colors.white
                                        //       ),
                                        //     ),
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                  MyElevatedButton(
                                    onPressed: () {
                                      print("update bank");
                                      Get.dialog(CustomThreeInOutLoader(),
                                          barrierDismissible: false);
                                      _bankEmployeeUodateController.updateBankProfile(
                                        accountHolderName:
                                            _acholdernameController.text,
                                        bankname: _bankController.text,
                                        accountNumber:
                                            _accnumberController.text,
                                        reEnterAccountNumber:
                                            _reenteracnoNumberController.text,
                                        ifsc: _ifscController.text,
                                        epfNumber: _epfnumnberController.text,
                                        // deductionCycle:
                                        //     _deductioncycleController.text,
                                        // employeeContributionRate:
                                        //     _employeecontrobutionController
                                        //         .text,
                                        //_deduc
                                        nominee: _nominiNameController.text,
                                        accountTypeId:
                                            _bankEmployeeUodateController
                                                .selectedAccountType.value,
                                        cvFileContent: _cvFileContent!,
                                        Chequebase64:
                                            _cvFilePathController.text,
                                      );
                                      Get.back();
                                      print("update bank done");

                                    },
                                    text: Text('Update',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600
                                    ),),
                                    height: 40,
                                    width: 200,
                                  ),
                                 // const SizedBox(height: 34),
                                  const SizedBox(height: 20),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
