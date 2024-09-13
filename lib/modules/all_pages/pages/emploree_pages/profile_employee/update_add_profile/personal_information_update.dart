import 'dart:async';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'package:intl/intl.dart';
import 'package:nd_connect_techland/constants/static_text.dart';
import 'package:nd_connect_techland/controllers/bottom_nav_controller.dart';
import 'package:nd_connect_techland/modules/all_pages/pages/emploree_pages/profile_employee/aadharPage.dart';
import 'package:nd_connect_techland/modules/all_pages/pages/emploree_pages/profile_employee/employee_profile_nd.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../../components/responsive_text.dart';
import '../../../../../../components/styles.dart';
import '../../../../../../controllers/employee_controller/profile_controller/profile_info_employee_controller.dart';
import '../../../../../../controllers/employeee_controllersss/employee_edit_profile_controller/employee_update_personal_controller.dart';
import '../../../../../../controllers/employeee_controllersss/update_profile_image_controller/update_profile_image.dart';
import '../../../../../../models/city_model.dart';
import '../../../../../../models/state_model.dart';
import '../../../../../../widget/elevated_button.dart';
import '../../../../../bottom_bar/bottom_bar.dart';
import '../panCard_page.dart';
import '../profile_employee.dart';

//enum Gender { male, female, other }

class PersonalUpdateProfile extends StatefulWidget {
  PersonalUpdateProfile({Key? key}) : super(key: key);

  @override
  State<PersonalUpdateProfile> createState() => _PersonalUpdateProfileState();
}

class _PersonalUpdateProfileState extends State<PersonalUpdateProfile> {
  //late final ProfileEmployeeController _getprofileepersonal;
  final EmployeeUpdatePersonalController _employeeUpdatePersonalController =
      Get.put(EmployeeUpdatePersonalController());

  ProfilePictureEmployeController _profilePictureEmployeController =
      Get.put(ProfilePictureEmployeController());

  ProfileEmployeeController _profileEmployeeController =
      Get.put(ProfileEmployeeController());

  final ProfileEmployeeController _getprofileepersonal = Get.put(ProfileEmployeeController());
  final BottomNavController _bottomNavController = Get.put(BottomNavController());

  //GetProfileModel? getprofileModel;
  int selectID = 1;

  String dropdownValueDay = '2';

  String dropdownValueMonth = 'July';

  String dropdownValueYear = '1990';

  String dropdownValueCountry = 'India';

  String dropdownValueZip = '110096';

  final TextEditingController _profileimagePathController =
      TextEditingController();

  //final TextEditingController _aadhaarController = TextEditingController();
  final TextEditingController _panFilePathController = TextEditingController();

  final TextEditingController _aadharFilePathController = TextEditingController();

  // final TextEditingController _dateOfBirthController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();
  final TextEditingController _employeeIdController = TextEditingController();

  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();

  final TextEditingController _fathernameController = TextEditingController();
  final TextEditingController _companynameController = TextEditingController();
  final TextEditingController _workEmailController = TextEditingController();
  final TextEditingController _joiningDateController = TextEditingController();
  final TextEditingController _shiftController = TextEditingController();
  final TextEditingController _pannoController = TextEditingController();
  final TextEditingController _address1Controller = TextEditingController();
  final TextEditingController _address2Controller = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  final TextEditingController _companyLocController = TextEditingController();
  final TextEditingController _aadharnoController = TextEditingController();

  Uint8List? _profileFileContent;
  var selectedProfileImage = Rxn<Uint8List>(); // Use Rxn for nullable values
  var selectedAdhar1Image = Rxn<Uint8List>(); // Use Rxn for nullable values
  var selectedAdhar2Image = Rxn<Uint8List>(); // Use Rxn for nullable values
  var selectedPanImage = Rxn<Uint8List>(); // Use Rxn for nullable values

  Uint8List? _panFileContent;


  List<Uint8List> _aadharImages = [];

  @override
  void initState() {
    super.initState();
    if (_getprofileepersonal.getprofileemployeeModel != null) {
      _nameController.text =
          _getprofileepersonal.getprofileemployeeModel?.data?.fullName ?? "";
      _emailController.text = _getprofileepersonal
              .getprofileemployeeModel?.data?.personalEmailAddress ??
          "";
      _mobileNumberController.text = _getprofileepersonal
              .getprofileemployeeModel?.data?.mobileNumber
              .toString() ??
          "";
      _dateOfBirthController.text = _getprofileepersonal
              .getprofileemployeeModel?.data?.dateOfBirth
              .toString() ??
          "";
      print("dobbbGet:${_getprofileepersonal
          .getprofileemployeeModel?.data?.dateOfBirth}");
      // _fathernameController.text = _getprofileepersonal
      //         .getprofileemployeeModel?.data?.fatherName
      //         .toString() ??
      //     "";
      // _ageController.text =
      //     _getprofileepersonal.getprofileemployeeModel?.data?.age.toString() ??
      //         "";
      _pannoController.text =
          _getprofileepersonal.getprofileemployeeModel?.data?.panNo.toString() ??
              "";
      _address1Controller.text = _getprofileepersonal
              .getprofileemployeeModel?.data?.address1
              .toString() ??
          "";
      _address2Controller.text = _getprofileepersonal
              .getprofileemployeeModel?.data?.address2
              .toString() ??
          "";
      _pincodeController.text = _getprofileepersonal
              .getprofileemployeeModel?.data?.pincode
              .toString() ??
          "";
      _aadharnoController.text = _getprofileepersonal
              .getprofileemployeeModel?.data?.aadharNo
              .toString() ??
          "";
      _workEmailController.text = _getprofileepersonal
              .getprofileemployeeModel?.data?.workEmail
              .toString() ??
          "";
      _joiningDateController.text = _getprofileepersonal
              .getprofileemployeeModel?.data?.dateOfJoining
              .toString() ??
          "";
      _companyLocController.text = _getprofileepersonal
              .getprofileemployeeModel?.data?.companyLocationName
              .toString() ??
          "";
      _companynameController.text = _getprofileepersonal
              .getprofileemployeeModel?.data?.companyName
              .toString() ??
          "";
      _roleController.text = _getprofileepersonal.getprofileemployeeModel?.data?.designationName?.toString()??"";
      _employeeIdController.text = _getprofileepersonal.getprofileemployeeModel?.data?.employeeId?.toString()??"";
      //_aadharnoController
    }
  }

  String formatDateOfBirth(String dateOfBirthString) {
    try {
      DateFormat inputFormat = DateFormat("dd/MM/yyyy");
      DateTime dateOfBirth = inputFormat.parse(dateOfBirthString);
      DateFormat outputFormat = DateFormat("dd-MM-yyyy");
      return outputFormat.format(dateOfBirth);
    } catch (e) {
      try {
        DateFormat inputFormat = DateFormat("yyyy-MM-dd");
        DateTime dateOfBirth = inputFormat.parse(dateOfBirthString);
        DateFormat outputFormat = DateFormat("dd-MM-yyyy");
        return outputFormat.format(dateOfBirth);
      } catch (e) {
        print('Error parsing date: $e');
        return dateOfBirthString;
      }
    }
  }

  // // Gender? _selectedGender = Gender.male;
  // Future<void> _checkAndRequestPermissions(context) async {
  //   if (await Permission.storage.request().isGranted) {
  //     _selectaadhaarFile(context);
  //   } else {
  //     await Permission.storage.request();
  //     if (await Permission.storage.isGranted) {
  //       _selectaadhaarFile(context);
  //     } else {
  //       print('Storage permission is required to access files.');
  //     }
  //   }
  // }
  //
  // ///2...
  //
  // Future<void> _checkAndRequestPermissions2(context) async {
  //   if (await Permission.storage.request().isGranted) {
  //     _selectPanFile(context);
  //   } else {
  //     await Permission.storage.request();
  //     if (await Permission.storage.isGranted) {
  //       _selectPanFile(context);
  //     } else {
  //       print('Storage permission is required to access files.');
  //     }
  //   }
  // }
  //
  // ///3 profile..
  // Future<void> _checkAndRequestPermissions3(context) async {
  //   if (await Permission.storage.request().isGranted) {
  //     _selectimageprofileFile(context);
  //   } else {
  //     await Permission.storage.request();
  //     if (await Permission.storage.isGranted) {
  //       _selectimageprofileFile(context);
  //     } else {
  //       print('Storage permission is required to access files.');
  //     }
  //   }
  // }

  Future<void> _selectaadhaarFile(BuildContext context) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
        withData: true,
        allowMultiple: true, // Enable multiple file selection
      );
      if (result != null && result.files.isNotEmpty) {
        for (PlatformFile file in result.files) {
          if (file.size! <= 20 * 1024 * 1024) {
            if (file.bytes != null) {
              _aadharFilePathController.text = file.name;
              selectedAdhar1Image.value = file.bytes; // Update the selected image
              selectedAdhar2Image.value = file.bytes; // Update the selected image
              _aadharImages.add(file.bytes!); // Add file content to list
              print('File size: ${file.bytes!.length} bytes');
            } else {
              print('Failed to read file content: File bytes are null');
            }
          } else {
            Fluttertoast.showToast(
              msg: "Selected file exceeds 20MB limit",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          }
        }
      } else {
        print('No file selected');
      }
    } catch (e) {
      print('Error picking file: $e');
    }
  }

  Future<void> _selectPanFile(BuildContext context) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
        withData: true, // Ensure the file picker reads the file data
      );
      if (result != null && result.files.isNotEmpty) {
        PlatformFile file = result.files.first;
        print('Selected file: ${file.name}, path: ${file.path}');

        if (file.size! <= 20 * 1024 * 1024) {
          // Check if file size is less than or equal to 10MB
          if (file.bytes != null) {
            _panFilePathController.text = file.name;
            selectedPanImage.value = file.bytes; // Update the selected image

            _panFileContent = file.bytes!;
            print('File size: ${_panFileContent!.length} bytes');
          } else {
            print('Failed to read file content: File bytes are null');
          }
        } else {
          Fluttertoast.showToast(
              msg: "Selected file exceeds 20MB limit",
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
  Future<void> _selectimageprofileFile(BuildContext context) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png'],
        withData: true,
      );
      if (result != null && result.files.isNotEmpty) {
        PlatformFile file = result.files.first;

        if (file.size! <= 20 * 1024 * 1024) {
          if (file.bytes != null) {
            _profileimagePathController.text = file.name;
            selectedProfileImage.value = file.bytes; // Update the selected image
            _profileFileContent = file.bytes!;
          } else {
            print('Failed to read file content: File bytes are null');
          }
        } else {
          Fluttertoast.showToast(
            msg: "Selected file exceeds 20MB limit",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      } else {
        print('No file selected');
      }
    } catch (e) {
      print('Error picking file: $e');
    }
  }

  // Future<void> _selectimageprofileFile(BuildContext context) async {
  //   try {
  //     FilePickerResult? result = await FilePicker.platform.pickFiles(
  //       type: FileType.custom,
  //       allowedExtensions: [
  //         'jpg',
  //         'jpeg',
  //         'png',
  //       ],
  //       withData: true, // Ensure the file picker reads the file data
  //     );
  //     if (result != null && result.files.isNotEmpty) {
  //       PlatformFile file = result.files.first;
  //       print('Selected file: ${file.name}, path: ${file.path}');
  //
  //       if (file.size! <= 20 * 1024 * 1024) {
  //         // Check if file size is less than or equal to 10MB
  //         if (file.bytes != null) {
  //           _profileimagePathController.text = file.name;
  //           cvFileContent3 = file.bytes!;
  //           print('File size: ${cvFileContent3!.length} bytes');
  //         } else {
  //           print('Failed to read file content: File bytes are null');
  //         }
  //       } else {
  //         Fluttertoast.showToast(
  //             msg: "Selected file exceeds 20MB limit",
  //             toastLength: Toast.LENGTH_LONG,
  //             gravity: ToastGravity.CENTER,
  //             timeInSecForIosWeb: 1,
  //             backgroundColor: Colors.red,
  //             textColor: Colors.white,
  //             fontSize: 16.0);
  //       }
  //     } else {
  //       print('No file selected');
  //     }
  //   } catch (e) {
  //     print('Error picking file: $e');
  //   }
  // }

  var selectedDate = DateTime.now().obs;

  // chooseDate() async {
  //   DateTime today = DateTime.now();
  //   DateTime firstDate = DateTime(today.year - 14, today.month, today.day);
  //   DateTime lastDate = DateTime(1900);
  //
  //   DateTime? newpickedDate = await showDatePicker(
  //     context: Get.context!,
  //     initialDate: firstDate,
  //     firstDate: DateTime(1900),
  //     lastDate: firstDate,
  //     initialEntryMode: DatePickerEntryMode.calendar,
  //     initialDatePickerMode: DatePickerMode.day,
  //     helpText: 'Select DOB',
  //     cancelText: 'Close',
  //     confirmText: 'Confirm',
  //     errorFormatText: 'Enter valid date',
  //     errorInvalidText: 'Enter valid date range',
  //     fieldLabelText: 'Selected Date',
  //   );
  //   if (newpickedDate != null) {
  //     selectedDate.value = newpickedDate;
  //     _dateOfBirthController
  //       ..text = DateFormat('yyyy-MM-d').format(selectedDate.value).toString()
  //       ..selection = TextSelection.fromPosition(TextPosition(
  //           offset: _dateOfBirthController.text.length,
  //           affinity: TextAffinity.upstream));
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    ///
    String imageUrl =
        // "${FixedText.apiurl2}$
        "${_getprofileepersonal.getprofileemployeeModel?.data?.empProfile
    }";
    print("imageUrl");
    print(imageUrl);

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: backgroundColor,
      body:
      //Obx(() =>
        // (_getprofileepersonal.isLoading.value)
        //     ? Center(child: CircularProgressIndicator())
        //     :
        WillPopScope(
          onWillPop: () async {
            _bottomNavController.changeTabIndex(0);

            return true;
          },
          child: SafeArea(
            child: Form(
                    key: _employeeUpdatePersonalController.personalinfoFormKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          _buildHeader(context),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                blackHeadingSmall(
                                    'Informations'.toUpperCase()),
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
                                //       Navigator.pop(context);
                                //       //await Get.off(EmployeeProfileNd());
                                //       // await Navigator.push(
                                //       //     context,
                                //       //     MaterialPageRoute(
                                //       //         builder: (context) =>
                                //       //             EmployeeProfile()));
                                //     },
                                //     child: appcolorText('View'))
                              ],
                            ),
                          ),
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
                              borderRadius: BorderRadius.all(Radius.circular(6.0)),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 0),
                                  child: TextFormField(
                                    readOnly: true,
                                    controller: _nameController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter Name';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      //fillColor: Colors.grey.shade200,
                                      //filled: true,
                                      labelText: "Name",
                                      hintStyle: (TextStyle(
                                        fontSize: 13,
                                      )),
                                      labelStyle: const TextStyle(
                                          color: Colors.black54, fontSize: 13),
                                      focusedBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(color: appColor),
                                      ),
                                      enabledBorder: const UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black12),
                                      ),
                                    ),
                                  ),
                                ),
            
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 0),
                                  child: TextFormField(
                                    controller: _emailController,
                                    // validator: (value) {
                                    //   if (value == null || value.isEmpty) {
                                    //     return 'Please enter Email';
                                    //   }
                                    //   // Regular expression for email validation
                                    //   final emailRegex = RegExp(
                                    //       r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                                    //   if (!emailRegex.hasMatch(value)) {
                                    //     return 'Please enter a valid email address';
                                    //   }
                                    //   return null;
                                    // },
                                    decoration: InputDecoration(
                                      labelText: "Personal Email Id",
                                      hintStyle: (TextStyle(
                                        fontSize: 13,
                                      )),
                                      labelStyle: const TextStyle(
                                          color: Colors.black54, fontSize: 13),
                                      focusedBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(color: appColor),
                                      ),
                                      enabledBorder: const UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black12),
                                      ),
                                    ),
                                  ),
                                ),
            
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 0),
                                  child: TextFormField(
                                    keyboardType: TextInputType.phone,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(10)
                                    ],
                                    controller: _mobileNumberController,
                                    // validator: (value) {
                                    //   if (value == null || value.isEmpty) {
                                    //     return 'Please enter Mobile no.';
                                    //   }
                                    //   // Regular expression for exactly 10 digits
                                    //   final mobileRegex = RegExp(r'^[0-9]{10}$');
                                    //   if (!mobileRegex.hasMatch(value)) {
                                    //     return 'Mobile number should be exactly 10 digits long';
                                    //   }
                                    //   return null;
                                    // },
                                    decoration: InputDecoration(
                                      labelText: "Phone Number",
                                      hintStyle: (TextStyle(
                                        fontSize: 13,
                                      )),
                                      labelStyle: const TextStyle(
                                          color: Colors.black54, fontSize: 13),
                                      focusedBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(color: appColor),
                                      ),
                                      enabledBorder: const UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black12),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 0),
                                  child: TextFormField(
                                    readOnly: true,
                                    controller: _dateOfBirthController,
                                    // validator: (value) {
                                    //   if (value == null || value.isEmpty) {
                                    //     return 'Please enter DOB';
                                    //   }
                                    //   return null;
                                    // },
                                    // onTap: () {
                                    //  // chooseDate();
                                    // },
                                    decoration: InputDecoration(
                                      labelText: "Date Of Birth",
                                      hintStyle: (TextStyle(
                                        fontSize: 13,
                                      )),
                                      labelStyle: const TextStyle(
                                          color: Colors.black54, fontSize: 13),
                                      focusedBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(color: appColor),
                                      ),
                                      enabledBorder: const UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black12),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 0),
                                  child: TextFormField(
                                    controller: _fathernameController,
                                    decoration: InputDecoration(
                                      labelText: "Father Name",
                                      hintStyle: (TextStyle(
                                        fontSize: 13,
                                      )),
                                      labelStyle: const TextStyle(
                                          color: Colors.black54, fontSize: 13),
                                      focusedBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(color: appColor),
                                      ),
                                      enabledBorder: const UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black12),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 0),
                                  child: TextFormField(
                                    controller: _companynameController,
                                    decoration: InputDecoration(
                                      labelText: "Company Name",
                                      hintStyle: (TextStyle(
                                        fontSize: 13,
                                      )),
                                      labelStyle: const TextStyle(
                                          color: Colors.black54, fontSize: 13),
                                      focusedBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(color: appColor),
                                      ),
                                      enabledBorder: const UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black12),
                                      ),
                                    ),
                                  ),
                                ),Container(
                                  padding: EdgeInsets.symmetric(vertical: 0),
                                  child: TextFormField(
                                    controller: _workEmailController,
                                    decoration: InputDecoration(
                                      labelText: "Work Email",
                                      hintStyle: (TextStyle(
                                        fontSize: 13,
                                      )),
                                      labelStyle: const TextStyle(
                                          color: Colors.black54, fontSize: 13),
                                      focusedBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(color: appColor),
                                      ),
                                      enabledBorder: const UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black12),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 0),
                                  child: TextFormField(
                                    controller: _joiningDateController,
                                    decoration: InputDecoration(
                                      labelText: "Joining Date",
                                      hintStyle: (TextStyle(
                                        fontSize: 13,
                                      )),
                                      labelStyle: const TextStyle(
                                          color: Colors.black54, fontSize: 13),
                                      focusedBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(color: appColor),
                                      ),
                                      enabledBorder: const UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black12),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 0),
                                  child: TextFormField(
                                    controller: _shiftController,
                                    decoration: InputDecoration(
                                      labelText: "Current Shift",
                                      hintStyle: (TextStyle(
                                        fontSize: 13,
                                      )),
                                      labelStyle: const TextStyle(
                                          color: Colors.black54, fontSize: 13),
                                      focusedBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(color: appColor),
                                      ),
                                      enabledBorder: const UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black12),
                                      ),
                                    ),
                                  ),
                                ),
            
                                ///
            
                                const SizedBox(height: 10),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                blackHeadingSmall('Location'.toUpperCase()),
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
                                //       await Get.off(EmployeeProfile());
                                //
                                //       // await Navigator.push(
                                //       //     context,
                                //       //     MaterialPageRoute(
                                //       //         builder: (context) =>
                                //       //             EmployeeProfile()));
                                //     },
                                //     child: appcolorText('View'))
                              ],
                            ),
                          ),
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
                              borderRadius: BorderRadius.all(Radius.circular(6.0)),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 0),
                                  child: Obx(
                                    () => DropdownButtonFormField<StateModelss>(
                                        value: _employeeUpdatePersonalController
                                            .selectedState.value,
                                        decoration: InputDecoration(
                                          labelText: 'State',
                                          // suffixIcon: Icon(
                                          //   Icons.place_outlined,
                                          //   size: 23,
                                          //   color: Colors.black12,
                                          // ),
                                          labelStyle: const TextStyle(
                                              color: Colors.black54, fontSize: 15),
                                          focusedBorder: const UnderlineInputBorder(
                                            borderSide: BorderSide(color: appColor),
                                          ),
                                        ),
                                        hint: Text(
                                          (_getprofileepersonal
                                                  .getprofileemployeeModel
                                                  ?.data
                                                  ?.stateName ??
                                              0) as String,
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        items: _employeeUpdatePersonalController
                                            .states
                                            .map((StateModelss items) {
                                          return DropdownMenuItem(
                                            value: items,
                                            child: Text(
                                              items.sName,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: size.height * 0.015,
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                        // validator: (value) =>
                                        //     value == null ? 'Select States' : null,
                                        onChanged: (StateModelss? newValue) {
                                          _employeeUpdatePersonalController
                                              .selectedState.value = newValue!;
                                          _employeeUpdatePersonalController
                                              .selectedCity.value = null;
                                        }),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 0),
                                  child: Obx(
                                    () => DropdownButtonFormField<CityModell>(
                                        value: _employeeUpdatePersonalController
                                            .selectedCity.value,
                                        decoration: InputDecoration(
                                          labelText: 'City',
                                          // suffixIcon: Icon(
                                          //   Icons.place_outlined,
                                          //   size: 23,
                                          //   color: Colors.black12,
                                          // ),
                                          labelStyle: const TextStyle(
                                              color: Colors.black54, fontSize: 15),
                                          focusedBorder: const UnderlineInputBorder(
                                            borderSide: BorderSide(color: appColor),
                                          ),
                                        ),
                                        hint: Text(
                                          _getprofileepersonal
                                                  .getprofileemployeeModel
                                                  ?.data
                                                  ?.cityName ??
                                              "",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        items: _employeeUpdatePersonalController
                                            .cities
                                            .map((CityModell items) {
                                          return DropdownMenuItem(
                                            value: items,
                                            child: Text(
                                              items.cityName,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: size.height * 0.015,
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                        onTap: () {
                                          _employeeUpdatePersonalController
                                              .refresh();
                                        },
                                        // validator: (value) =>
                                        //     value == null ? 'Select City' : null,
                                        onChanged: (CityModell? newValue) {
                                          _employeeUpdatePersonalController
                                              .selectedCity.value = newValue!;
                                        }),
                                  ),
                                  // TextFormField(
                                  //   decoration: InputDecoration(
                                  //     labelText: "City",
                                  //     hintStyle: (TextStyle(
                                  //       fontSize: 13,
                                  //     )),
                                  //     labelStyle: const TextStyle(
                                  //         color: Colors.black54, fontSize: 13),
                                  //     focusedBorder: const UnderlineInputBorder(
                                  //       borderSide: BorderSide(color: appColor),
                                  //     ),
                                  //     enabledBorder: const UnderlineInputBorder(
                                  //       borderSide: BorderSide(color: Colors.black12),
                                  //     ),
                                  //   ),
                                  // ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 0),
                                  child: TextFormField(
                                    controller: _address1Controller,
                                    // validator: (value) {
                                    //   if (value == null || value.isEmpty) {
                                    //     return 'Please enter address 1';
                                    //   }
                                    //   return null;
                                    // },
                                    decoration: InputDecoration(
                                      labelText: "Address:",
                                      hintStyle: (TextStyle(
                                        fontSize: 13,
                                      )),
                                      labelStyle: const TextStyle(
                                          color: Colors.black54, fontSize: 13),
                                      focusedBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(color: appColor),
                                      ),
                                      enabledBorder: const UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black12),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 0),
                                  child: TextFormField(
                                    controller: _address2Controller,
                                    // validator: (value) {
                                    //   if (value == null || value.isEmpty) {
                                    //     return 'Please enter address 2';
                                    //   }
                                    //   return null;
                                    // },
                                    decoration: InputDecoration(
                                      labelText: "Permanent Address:",
                                      hintStyle: (TextStyle(
                                        fontSize: 13,
                                      )),
                                      labelStyle: const TextStyle(
                                          color: Colors.black54, fontSize: 13),
                                      focusedBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(color: appColor),
                                      ),
                                      enabledBorder: const UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black12),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 0),
                                  child: TextFormField(
                                    controller: _pincodeController,
                                    // validator: (value) {
                                    //   if (value == null || value.isEmpty) {
                                    //     return 'Please enter pin';
                                    //   }
                                    //   return null;
                                    // },
                                    decoration: InputDecoration(
                                      labelText: "Pin Code",
                                      hintStyle: (TextStyle(
                                        fontSize: 13,
                                      )),
                                      labelStyle: const TextStyle(
                                          color: Colors.black54, fontSize: 13),
                                      focusedBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(color: appColor),
                                      ),
                                      enabledBorder: const UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black12),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 0),
                                  child: TextFormField(
                                    controller: _companyLocController,
                                    // validator: (value) {
                                    //   if (value == null || value.isEmpty) {
                                    //     return 'Please enter pin';
                                    //   }
                                    //   return null;
                                    // },
                                    decoration: InputDecoration(
                                      labelText: "Company Location",
                                      hintStyle: (TextStyle(
                                        fontSize: 13,
                                      )),
                                      labelStyle: const TextStyle(
                                          color: Colors.black54, fontSize: 13),
                                      focusedBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(color: appColor),
                                      ),
                                      enabledBorder: const UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black12),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                              ],
                            ),
                          ),
            
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                blackHeadingSmall('Documents'.toUpperCase()),
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
                                //
                                //       await
                                //           // await _profileController.profileApi();
                                //           // _profileController.update();
                                //           await Navigator.push(
                                //               context,
                                //               MaterialPageRoute(
                                //                   builder: (context) =>
                                //                       EmployeeProfile()));
                                //     },
                                //     child: appcolorText('View'))
                              ],
                            ),
                          ),
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
                              borderRadius: BorderRadius.all(Radius.circular(6.0)),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 0),
                                  child: TextFormField(
                                    controller: _pannoController,
                                    keyboardType: TextInputType.text,
                                    // inputFormatters: [
                                    //   FilteringTextInputFormatter.allow(RegExp(
                                    //       r'[A-Z0-9]')), // Allow only uppercase letters and digits
                                    // ],
                                    // validator: (value) {
                                    //   if (value == null || value.isEmpty) {
                                    //     return 'Please enter PAN number.';
                                    //   }
                                    //   // Regular expression for PAN number format
                                    //   final panRegex =
                                    //       RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$');
                                    //   if (!panRegex.hasMatch(value)) {
                                    //     return 'PAN number should be in the format ABCDE1234F';
                                    //   }
                                    //   return null;
                                    // },
                                    decoration: InputDecoration(
                                      labelText: "Pan No",
                                      hintStyle: (TextStyle(
                                        fontSize: 13,
                                      )),
                                      labelStyle: const TextStyle(
                                          color: Colors.black54, fontSize: 13),
                                      focusedBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(color: appColor),
                                      ),
                                      enabledBorder: const UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black12),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 0),
                                  child: TextFormField(
                                    controller: _aadharnoController,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter
                                          .digitsOnly, // Allow only digits
                                    ],
                                    // validator: (value) {
                                    //   if (value == null || value.isEmpty) {
                                    //     return 'Please enter Aadhaar number.';
                                    //   }
                                    //   // Check if the input is exactly 12 digits
                                    //   if (value.length != 12) {
                                    //     return 'Aadhaar number should be exactly 12 digits long';
                                    //   }
                                    //   return null;
                                    // },
                                    decoration: InputDecoration(
                                      labelText: "Aadhar No.",
                                      hintStyle: (TextStyle(
                                        fontSize: 13,
                                      )),
                                      labelStyle: const TextStyle(
                                          color: Colors.black54, fontSize: 13),
                                      focusedBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(color: appColor),
                                      ),
                                      enabledBorder: const UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black12),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8,),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 0),
                                  child: Row(
                                    children: [
                                      // Expanded widget to ensure the TextField takes the remaining width
                                      // Expanded(
                                      //   child: TextFormField(
                                      //     readOnly: true,
                                      //     // validator: (value) {
                                      //     //   if (value == null || value.isEmpty) {
                                      //     //     return 'Please select your Aadhaar';
                                      //     //   }
                                      //     //   return null;
                                      //     // },
                                      //     controller: _aadharFilePathController,
                                      //     decoration: InputDecoration(
                                      //         labelText: 'Aadhar Image'),
                                      //     enabled: false,
                                      //   ),
                                      // ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(context, MaterialPageRoute(builder: (_) {
                                            return Aadharpage();
                                          }));
                                        },
                                        child: Container(
                                          height: 80,
                                          width: 80,
                                          decoration: BoxDecoration(
                                            border: Border.all(width: 2, color: Colors.grey),
                                              borderRadius: BorderRadius.circular(12.0),
                                          ),
                                          child:Obx(() {
                                            return Hero(
                                              tag: 'aadharImg',
                                              child: selectedAdhar1Image.value != null
                                                  ? ClipRRect(
                                                borderRadius: BorderRadius.circular(10.0),
                                                    child: Image.memory(
                                                  selectedAdhar1Image.value!,
                                                  fit: BoxFit.contain,
                                                  width: double.infinity,
                                                  height: double.infinity,
                                                ),
                                                  )
                                                  : (_getprofileepersonal.getprofileemployeeModel?.data?.aadharOne != null
                                                  ? ClipRRect(
                                                borderRadius: BorderRadius.circular(10.0),
                                                    child: Image.network(
                                                 "${FixedText.imageUrlll}${_getprofileepersonal.getprofileemployeeModel?.data?.aadharOne}",
                                                 fit: BoxFit.cover,
                                                 errorBuilder: (context, error, stackTrace) {
                                                    return Image.network(
                                                      'https://cdn.pixabay.com/photo/2022/11/09/00/44/aadhaar-card-7579588_1280.png',
                                                      fit: BoxFit.contain,
                                                    );
                                                       },
                                                     ),
                                                  )
                                                  : ClipRRect(
                                                borderRadius: BorderRadius.circular(10.0),
                                                    child: Image.asset(
                                                    'https://cdn.pixabay.com/photo/2022/11/09/00/44/aadhaar-card-7579588_1280.png',
                                                    fit: BoxFit.contain,
                                                  ),
                                                  )),
                                            );
                                          }),),
                                      ),
                                      SizedBox(width: 6), // Add some spacing between the TextField and the Button
          
                                      GestureDetector(
                                        onTap: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                                          return Aadharpage();
                                        }));
                                      },
          
                                        child: Container(
                                          height: 80,
                                          width: 80,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(12.0),
                                            border: Border.all(width: 2, color: Colors.grey),

                                          ),
                                          child:Obx(() {
                                            return Hero(
                                              tag: 'aadharImg',
                                              child: selectedAdhar2Image.value != null
                                                  ? ClipRRect(
                                                borderRadius: BorderRadius.circular(10.0),
                                                    child: Image.memory(
                                                     selectedAdhar2Image.value!,
                                                     fit: BoxFit.contain,
                                                     width: double.infinity,
                                                     height: double.infinity,
                                                   ),
                                                  )
                                                  : (_getprofileepersonal.getprofileemployeeModel?.data?.aadharTwo != null
                                                  ? ClipRRect(
                                                borderRadius: BorderRadius.circular(10.0),
                                                    child: Image.network(
                                                 "${FixedText.imageUrlll}${_getprofileepersonal.getprofileemployeeModel?.data?.aadharTwo}",
                                                 fit: BoxFit.cover,
                                                 errorBuilder: (context, error, stackTrace) {
                                                    return Image.network(
                                                      'https://cdn.pixabay.com/photo/2022/11/09/00/44/aadhaar-card-7579588_1280.png',
                                                      fit: BoxFit.contain,
                                                    );
                                                    },
                                                  ),
                                                  )
                                                  : ClipRRect(
                                                    borderRadius: BorderRadius.circular(10.0),
                                              child: Image.asset(
                                                  'https://cdn.pixabay.com/photo/2022/11/09/00/44/aadhaar-card-7579588_1280.png',
                                                  fit: BoxFit.contain,
                                                ),
                                                  )),
                                            );
                                          }),),
                                      ),
                                      SizedBox(width: 6), // Add some spacing between the TextField and the Button
                                      Expanded(
                                        child: Container(
                                          width: 100,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            color: appColorr2,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: ElevatedButton(
                                            onPressed: () =>
                                                _selectaadhaarFile(context),
                                            // _checkAndRequestPermissions(
                                            //     context), // Use a lambda function
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: appColorr2, // Button color
                                              // onPrimary: Colors.white, // Text color
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(
                                                    10), // Rounded corners
                                              ),
                                            ),
                                            child: Text(
                                              'Aadhar',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 8,),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      // Expanded widget to ensure the TextField takes the remaining width
                                      // Expanded(
                                      //   child: TextFormField(
                                      //     readOnly: true,
                                      //     // validator: (value) {
                                      //     //   if (value == null || value.isEmpty) {
                                      //     //     return 'Please select your PAN';
                                      //     //   }
                                      //     //   return null;
                                      //     // },
                                      //     controller: _panFilePathController,
                                      //     decoration: InputDecoration(
                                      //         labelText: 'Pan File'),
                                      //     enabled: false,
                                      //   ),
                                      // ),

                                      GestureDetector(
                                      onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (_) {
                                return PancardPage();
                                }));
                                },
                                  child: Container(
                                    height: 80,
                                    width: 80,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.0),
                                      border: Border.all(width: 2, color: Colors.grey),
                                    ),
                                    child: Obx(() {
                                      return Hero(
                                        tag: 'panImg',
                                        child: selectedPanImage.value != null
                                            ? ClipRRect(
                                          borderRadius: BorderRadius.circular(10.0),
                                          child: Image.memory(
                                            selectedPanImage.value!,
                                            fit: BoxFit.cover,  // Ensures image fills the container
                                            width: double.infinity,
                                            height: double.infinity,
                                          ),
                                        )
                                            : (_getprofileepersonal.getprofileemployeeModel?.data?.panimg != null
                                            ? ClipRRect(
                                          borderRadius: BorderRadius.circular(10.0),
                                          child: Image.network(
                                            "${FixedText.imageUrlll}${_getprofileepersonal.getprofileemployeeModel?.data?.panimg}",
                                            fit: BoxFit.cover,  // Fills the container
                                            width: double.infinity,
                                            height: double.infinity,
                                            errorBuilder: (context, error, stackTrace) {
                                              return Image.network(
                                                'https://www.pngitem.com/pimgs/m/18-182217_pan-card-pan-card-with-cartoon-hd-png.png',
                                                fit: BoxFit.cover,  // Default image fills the container
                                              );
                                            },
                                          ),
                                        )
                                            : ClipRRect(
                                          borderRadius: BorderRadius.circular(10.0),
                                          child: Image.network(
                                            'https://www.pngitem.com/pimgs/m/18-182217_pan-card-pan-card-with-cartoon-hd-png.png',
                                            fit: BoxFit.cover,
                                          ),
                                        )),
                                      );
                                    }),
                                  ),
                                ),

                        SizedBox(
                                          width:
                                              10), // Add some spacing between the TextField and the Button
                                      Container(
                                        width: 120,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: ElevatedButton(
                                          onPressed: () => _selectPanFile(context),
                                          // _checkAndRequestPermissions2(
                                          //     context), // Use a lambda function
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: appColorr2,
                                            // primary: appColor, // Button color
                                            // onPrimary: Colors.white, // Text color
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(
                                                  10), // Rounded corners
                                            ),
                                          ),
                                          child: Text(
                                            textAlign: TextAlign.center,
                                            'Pan',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Container(
                                //   padding: EdgeInsets.symmetric(vertical: 0),
                                //   child: Row(
                                //     children: [
                                //       // Expanded widget to ensure the TextField takes the remaining width
                                //       Expanded(
                                //         child: TextFormField(
                                //           readOnly: true,
                                //           // validator: (value) {
                                //           //   if (value == null || value.isEmpty) {
                                //           //     return 'Please select your Profile';
                                //           //   }
                                //           //   return null;
                                //           // },
                                //           controller: _profileimagePathController,
                                //           decoration: InputDecoration(
                                //               labelText: 'Profile Picture'),
                                //           enabled: false,
                                //         ),
                                //       ),
                                //       SizedBox(
                                //           width:
                                //               10), // Add some spacing between the TextField and the Button
                                //       Container(
                                //         width: 80,
                                //         height: 35,
                                //         decoration: BoxDecoration(
                                //           color: Colors.white,
                                //           borderRadius: BorderRadius.circular(10),
                                //         ),
                                //         child: ElevatedButton(
                                //           onPressed: () =>
                                //               _selectimageprofileFile(context),
                                //
                                //           // _checkAndRequestPermissions3(
                                //           //       context), // Use a lambda function
                                //           style: ElevatedButton.styleFrom(
                                //             // primary: appColor, // Button color
                                //             // onPrimary: Colors.white, // Text color
                                //             shape: RoundedRectangleBorder(
                                //               borderRadius: BorderRadius.circular(
                                //                   10), // Rounded corners
                                //             ),
                                //           ),
                                //           child: Text(
                                //             'Profile\n Image',
                                //             style: TextStyle(
                                //               fontSize: 12,
                                //               fontWeight: FontWeight.bold,
                                //             ),
                                //           ),
                                //         ),
                                //       ),
                                //     ],
                                //   ),
                                // ),
                                const SizedBox(height: 10),
                              ],
                            ),
                          ),
            
                          //_checkAndRequestPermissions3
            
                          ///education end
                          ///
                          SizedBox(height: 24),
                          MyElevatedButton(
                            onPressed: () {
                              print("updateee");
                              String formattedDateOfBirth =
                                  formatDateOfBirth(_dateOfBirthController.text);
                              // Use null-aware operators to handle potential null values
                              String stateId = _employeeUpdatePersonalController
                                      .selectedState.value?.id
                                      .toString() ??
                                  _getprofileepersonal
                                      .getprofileemployeeModel?.data?.stateid
                                      ?.toString() ??
                                  "2";
                              String cityId = _employeeUpdatePersonalController
                                      .selectedCity.value?.id
                                      .toString() ??
                                  _getprofileepersonal
                                      .getprofileemployeeModel?.data?.cityid
                                      ?.toString() ??
                                  "158";
            
                              ///todo: profile...
            
                              // _profilePictureEmployeController
                              //     .updaprofilrimgProfile(
                              //   cvFileContent3: cvFileContent3!,
                              //   Empprofile: _profileimagePathController.text,
                              // );
                              print("dob:$formattedDateOfBirth");
                              print("_profileFileContent:$_profileFileContent");
                              ///todo: other and document not update.......
                              _employeeUpdatePersonalController
                                  .updateProfilePersonalApi(
                                personalEmailAddress: _emailController.text,
                                mobileNumber: _mobileNumberController.text,
                                dateOfBirth: _dateOfBirthController.text,
                                // age: _ageController.text,
                                // fatherName: _fathernameController.text,
                                pAN: _pannoController.text,
                                addressLine1: _address1Controller.text,
                                addressLine2: _address2Controller.text,
                                cityid: cityId,
                                // _getprofileepersonal
                                //     .getprofileemployeeModel!.data!.cityid
                                //     .toString(),
                                stateid: stateId,
                                pincode: _pincodeController.text,
                                aadharNo: _aadharnoController.text,
                                aadharFileContent:
                                    _aadharImages, // Pass list of Aadhaar images
                                Aadharbase64: _aadharFilePathController
                                    .text, // Pass Aadhar file name
                                panFileContent:
                                    _panFileContent!, // Pass PAN file content
                                // Panbase64: _panFilePathController.text.isNotEmpty
                                //     ? _panFilePathController.text
                                //     : null, // Check if PAN file path is provided
          
                                Panbase64: _panFilePathController
                                    .text,
                                fullName: _nameController.text,
                                workEmail: _workEmailController.text,
                                dateOfJoining: _joiningDateController.text,
                                departmentName: 'fgh',
                                designationName: _roleController.text,
                                companyName: _companynameController.text,
                                companyLocationName: _companyLocController.text,
                                profileFileContent: _profileFileContent!,
                                Profilebase64: _profileimagePathController.text, // Pass PAN file name
                              );
            
                              // await Future.delayed(Duration(seconds: 3));
            
                              ///Clear dropdown value
                              //_profileController.selectedState.value = null;
                              // _profileController.selectedCity.value = null;
                              print("updateee done");
            
                            },
                            text: Text('Update',
                            style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600),),
                            height: 40,
                            width: 200,
                          ),
                          const SizedBox(height: 34),
                        ],
                      ),
                    ),
                  ),
          ),
        ),
    //  ),
    );
  }
  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      width: double.infinity,
      decoration: const BoxDecoration(
        color: appColor2,
      ),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  Get.back();
                  Get.to(()=>BottomBar());
                 // Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>BottomBar()));
                },
                icon: Icon(Icons.arrow_back, color: Colors.white),
              ),
              Center(
                child: Text(
                  "Profile",
                  style: TextStyle(
                      fontSize: 20, fontFamily: 'medium', color: Colors.white),
                ),
              ),
              Container(
                width: 50,
                alignment: Alignment.topRight,
                // child: IconButton(
                //   onPressed: () {
                //     _selectimageprofileFile(context);
                //     _profilePictureEmployeController.updaprofilrimgProfile(
                //       cvFileContent3: _profileFileContent!,
                //       Empprofile: _profileimagePathController.text,
                //     );
                //   },
                //   icon: Icon(Icons.edit_outlined, color: Colors.white),
                // ),
              ),
            ],
          ),
          Stack(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: Colors.white,
                child: ClipOval(
                  child: responsiveContainer(
                    // padding: const EdgeInsets.only(right: 0),
                    //height: 20,
                    //width: 20,
                    heightPortrait:
                    MediaQuery.of(context).size.height * 0.12,
                    widthPortrait:
                    MediaQuery.of(context).size.width * 0.25,
                    heightLandscape:
                    MediaQuery.of(context).size.height * 0.3,
                    widthLandscape:
                    MediaQuery.of(context).size.width * 0.2,
                    // height: MediaQuery.of(context).size.height *
                    //     0.05, // 20% of screen height if not provided
                    // width: MediaQuery.of(context).size.width * 0.09,
                    //                                    "${_getprofileepersonal.getprofileemployeeModel?.data?.personalEmailAddress}",
                    child: _profileEmployeeController
                        .getprofileemployeeModel
                        ?.data
                        ?.empProfile !=
                        null
                        ? Image.network(
                      // "${FixedText.apiurl2}"
                      "${FixedText.imageUrlll}${_profileEmployeeController.getprofileemployeeModel?.data?.empProfile}",
                      //color: appColor,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'lib/assets/logo/logoo.png',
                          fit: BoxFit.contain,
                        );
                      },
                    )
                        : Image.network(
                      'https://ih1.redbubble.net/image.5098928927.2456/flat,750x,075,f-pad,750x1000,f8f8f8.u2.jpg',
                      fit: BoxFit.fill,
                    ),
                    context: context,
                  ),
                ),
              ),
              // CircleAvatar(
              //   radius: 40,
              //   backgroundColor: Colors.white,
              //   child: Obx(() {
              //     return selectedProfileImage.value != null
              //         ? Image.memory(
              //       selectedProfileImage.value!,
              //       fit: BoxFit.contain,
              //       width: double.infinity,
              //       height: double.infinity,
              //     )
              //         : (_getprofileepersonal.getprofileemployeeModel?.data?.empProfile != null
              //         ? Image.network(
              //       "${FixedText.imageUrlll}${_getprofileepersonal.getprofileemployeeModel?.data?.empProfile}",
              //       fit: BoxFit.cover,
              //       errorBuilder: (context, error, stackTrace) {
              //         return Image.asset(
              //           'lib/assets/logo/logoo.png',
              //           fit: BoxFit.contain,
              //         );
              //       },
              //     )
              //         : Image.asset(
              //       'lib/assets/logo/logoo.png',
              //       fit: BoxFit.contain,
              //     ));
              //   }),
              // ),
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    _selectimageprofileFile(context);
                    _profilePictureEmployeController.updaprofilrimgProfile(
                      cvFileContent3: _profileFileContent!,
                      Empprofile: _profileimagePathController.text,
                    );
                  },
                  child: CircleAvatar(
                    radius: 14,
                    backgroundColor: Colors.grey[300],
                    child: Icon(
                      Icons.camera_alt,
                      size: 18,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            "${_getprofileepersonal.getprofileemployeeModel?.data?.fullName?.toString()}",
            style: TextStyle(
                fontSize: 18, fontFamily: 'medium', color: Colors.white),
          ),
          Text(
            "Role: ${_getprofileepersonal.getprofileemployeeModel?.data?.designationName?.toString()}",
            style: TextStyle(fontSize: 14, color: Colors.white),
          ),
          const SizedBox(height: 5),
          Text(
            "Employee Id: ${_getprofileepersonal.getprofileemployeeModel?.data?.employeeId?.toString()}",
            style: TextStyle(fontSize: 14, color: Colors.white),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }


// Widget _buildHeader(BuildContext context) {
  //   return Container(
  //       padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
  //       width: double.infinity,
  //       decoration: const BoxDecoration(
  //         color: appColor2
  //         // gradient: LinearGradient(
  //         //     begin: Alignment.topCenter,
  //         //     end: Alignment.bottomCenter,
  //         //     colors: <Color>[appColor2, appColor]),
  //       ),
  //       child: Column(
  //         children: [
  //           const SizedBox(height: 10),
  //
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               IconButton(
  //                   onPressed: (){Navigator.pop(context);
  //                     }, icon: Icon(Icons.arrow_back,color: Colors.white,)),
  //               Center(
  //                 child: Text(
  //                   "Profile",
  //                   style: TextStyle(
  //                       fontSize: 20, fontFamily: 'medium', color: Colors.white),
  //                 ),
  //               ),
  //               Container(
  //                 //width: 40,
  //                 alignment: Alignment.topRight,
  //                 child: IconButton(onPressed: (){
  //                   _selectimageprofileFile(context);
  //
  //                   _profilePictureEmployeController
  //                       .updaprofilrimgProfile(
  //                     cvFileContent3: _profileFileContent!,
  //                     Empprofile: _profileimagePathController.text,
  //                   );
  //                 }, icon: Icon(Icons.edit_outlined,color: Colors.white,)),
  //               ),
  //             ],
  //           ),
  //           CircleAvatar(
  //             radius: 40,
  //             backgroundColor: Colors.white,
  //             child: Obx(() {
  //               return selectedProfileImage.value != null
  //                   ? Image.memory(
  //                 selectedProfileImage.value!,
  //                 fit: BoxFit.contain,
  //                 width: double.infinity,
  //                 height: double.infinity,
  //               )
  //                   : (_getprofileepersonal.getprofileemployeeModel?.data?.empProfile != null
  //                   ? Image.network(
  //                 "${FixedText.imageUrlll}${_getprofileepersonal.getprofileemployeeModel?.data?.empProfile}",
  //                 fit: BoxFit.cover,
  //                 errorBuilder: (context, error, stackTrace) {
  //                   return Image.asset(
  //                     'lib/assets/logo/logoo.png',
  //                     fit: BoxFit.contain,
  //                   );
  //                 },
  //               )
  //                   : Image.asset(
  //                 'lib/assets/logo/logoo.png',
  //                 fit: BoxFit.contain,
  //               ));
  //             }),
  //           ),
  //
  //           // CircleAvatar(
  //           //   radius: 45,
  //           //   backgroundColor: Colors.white,
  //           //   child: ClipOval(
  //           //     child: responsiveContainer(
  //           //       // padding: const EdgeInsets.only(right: 0),
  //           //       //height: 20,
  //           //       //width: 20,
  //           //       heightPortrait: MediaQuery.of(context).size.height * 0.12,
  //           //       widthPortrait: MediaQuery.of(context).size.width * 0.25,
  //           //       heightLandscape: MediaQuery.of(context).size.height * 0.3,
  //           //       widthLandscape: MediaQuery.of(context).size.width * 0.2,
  //           //       // height: MediaQuery.of(context).size.height *
  //           //       //     0.05, // 20% of screen height if not provided
  //           //       // width: MediaQuery.of(context).size.width * 0.09,
  //           //       //                                    "${_getprofileepersonal.getprofileemployeeModel?.data?.personalEmailAddress}",
  //           //       child: _getprofileepersonal
  //           //                   .getprofileemployeeModel?.data?.profileImage !=
  //           //               null
  //           //           ? Image.network(
  //           //               //"${FixedText.apiurl2}"
  //           //               "${_getprofileepersonal.getprofileemployeeModel?.data?.profileImage}",
  //           //               //color: appColor,
  //           //               fit: BoxFit.cover,
  //           //               // errorBuilder: (context, error, stackTrace) {
  //           //               //   return Image.asset(
  //           //               //     'lib/assets/logo/logoo.png',
  //           //               //     fit: BoxFit.contain,
  //           //               //   );
  //           //               // },
  //           //             )
  //           //           : Image.network(
  //           //               'https://ih1.redbubble.net/image.5098928927.2456/flat,750x,075,f-pad,750x1000,f8f8f8.u2.jpg',
  //           //               fit: BoxFit.fill,
  //           //             ),
  //           //       context: context,
  //           //     ),
  //           //   ),
  //           // ),
  //           const SizedBox(height: 8),
  //           Text(
  //             "${_getprofileepersonal.getprofileemployeeModel?.data?.fullName?.toString()}",
  //             style: TextStyle(
  //                 fontSize: 18, fontFamily: 'medium', color: Colors.white),
  //           ),
  //           //const SizedBox(height: 8),
  //           Text(
  //             "Role: ${_getprofileepersonal.getprofileemployeeModel?.data?.designationName?.toString()}",
  //             style: TextStyle(fontSize: 14, color: Colors.white),
  //           ),
  //           const SizedBox(height: 5),
  //           Text(
  //             "Employee Id: ${_getprofileepersonal.getprofileemployeeModel?.data?.employeeId?.toString()}",
  //             style: TextStyle(fontSize: 14, color: Colors.white),
  //           ),
  //           const SizedBox(height: 10),
  //         ],
  //       ));
  // }
}
