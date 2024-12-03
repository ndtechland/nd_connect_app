import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:nd_connect_techland/constants/static_text.dart';
import 'package:nd_connect_techland/controllers/bottom_nav_controller.dart';
import 'package:nd_connect_techland/modules/all_pages/pages/emploree_pages/profile_employee/aadharPage.dart';
import '../../../../../../components/responsive_text.dart';
import '../../../../../../components/styles.dart';
import '../../../../../../controllers/attendance_controller.dart';
import '../../../../../../controllers/employee_controller/profile_controller/profile_info_employee_controller.dart';
import '../../../../../../controllers/employeee_controllersss/employee_edit_profile_controller/employee_update_personal_controller.dart';
import '../../../../../../controllers/location_controller.dart';
import '../../../../../../models/city_model.dart';
import '../../../../../../models/state_model.dart';
import '../../../../../../widget/custom_loader.dart';
import '../../../../../../widget/elevated_button.dart';
import '../../../../../bottom_bar/bottom_bar.dart';
import '../back_aadharPage.dart';
import '../panCard_page.dart';
import '../profileImage_page.dart';
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
  ProfileEmployeeController _profileEmployeeController = Get.put(ProfileEmployeeController());

  final ProfileEmployeeController _getprofileepersonal = Get.put(ProfileEmployeeController());
  final BottomNavController _bottomNavController = Get.put(BottomNavController());
  final TextEditingController _profileimagePathController = TextEditingController();
  final TextEditingController _panFilePathController = TextEditingController();
  final TextEditingController _aadharFilePathController = TextEditingController();
  final TextEditingController _aadharFilePath1Controller = TextEditingController();
  final TextEditingController _aadharFilePath2Controller = TextEditingController();
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
  final _aadharImages = <Uint8List>[];  // List to store multiple Aadhaar file contents
  final _aadharFileNames = <String>[];  // List to store multiple Aadhaar file names
  //final _aadharFilePathController = TextEditingController();  // TextController for showing the file name

  Uint8List? _panFileContent;
  Uint8List? _aadhar1FileContent;
  Uint8List? _aadhar2FileContent;


  //List<Uint8List> _aadharImages = [];

  @override
  void initState() {
    super.initState();
    _getprofileepersonal.getCoordinatesFromAddress();
    if (_getprofileepersonal.getprofileemployeeModel != null) {
      _employeeUpdatePersonalController
          .selectedState.value;
      _employeeUpdatePersonalController
          .selectedCity.value;
      _getprofileepersonal.getprofileemployeeModel?.data?.stateName;
      _getprofileepersonal.getprofileemployeeModel?.data?.stateid;
      _getprofileepersonal.getprofileemployeeModel?.data?.cityName;
      _getprofileepersonal.getprofileemployeeModel?.data?.cityid;
      print("stateeInit:${_getprofileepersonal.getprofileemployeeModel?.data?.stateName}");
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
      print("pannnn:${_pannoController.text}");
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
          "N/A";
      _aadharnoController.text = _getprofileepersonal
              .getprofileemployeeModel?.data?.aadharNo
              .toString() ??
          "N/A";
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
      print("_companyLocController:${_companyLocController.text}");
      _companynameController.text = _getprofileepersonal
              .getprofileemployeeModel?.data?.companyName
              .toString() ??
          "";
      _roleController.text = _getprofileepersonal.getprofileemployeeModel?.data?.designationName?.toString()??"";
      _employeeIdController.text = _getprofileepersonal.getprofileemployeeModel?.data?.employeeId?.toString()??"";
      _shiftController.text = _getprofileepersonal.getprofileemployeeModel?.data?.shiftType?.toString()??"";
      _fathernameController.text = _getprofileepersonal.getprofileemployeeModel?.data?.fatherName?.toString()??"";
      //_aadharnoController
    }
  }


  String formatDateOfBirth(String dateOfBirthString) {
    DateFormat inputFormat1 = DateFormat("dd-MM-yyyy"); // Expecting this format
    DateFormat inputFormat2 = DateFormat("yyyy-MM-dd");
    DateFormat outputFormat = DateFormat("yyyy-MM-dd");

    try {
      DateTime dateOfBirth = inputFormat1.parse(dateOfBirthString);
      return outputFormat.format(dateOfBirth);
    } catch (e) {
      print('Error with dd-MM-yyyy format: $e');
      try {
        DateTime dateOfBirth = inputFormat2.parse(dateOfBirthString);
        return outputFormat.format(dateOfBirth);
      } catch (e) {
        print('Error with yyyy-MM-dd format: $e');
        return dateOfBirthString; // Return the original string if parsing fails
      }
    }
  }

  // String formatDateOfBirth(String dateOfBirthString) {
  //   try {
  //     DateFormat inputFormat = DateFormat("dd/MM/yyyy");
  //     DateTime dateOfBirth = inputFormat.parse(dateOfBirthString);
  //     DateFormat outputFormat = DateFormat("yyyy-MM-dd");
  //     return outputFormat.format(dateOfBirth);
  //   } catch (e) {
  //     try {
  //       DateFormat inputFormat = DateFormat("yyyy-MM-dd");
  //       DateTime dateOfBirth = inputFormat.parse(dateOfBirthString);
  //       DateFormat outputFormat = DateFormat("yyyy-MM-dd");
  //       return outputFormat.format(dateOfBirth);
  //     } catch (e) {
  //       print('Error parsing date: $e');
  //       return dateOfBirthString;
  //     }
  //   }
  // }


//todayyyy correct for profile and pan
  // Future<void> _selectaadhaarFile(BuildContext context) async {
  //   try {
  //     FilePickerResult? result = await FilePicker.platform.pickFiles(
  //       type: FileType.custom,
  //       allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
  //       withData: true,
  //       allowMultiple: true, // Enable multiple file selection
  //     );
  //     if (result != null && result.files.isNotEmpty) {
  //       for (PlatformFile file in result.files) {
  //         if (file.size! <= 20 * 1024 * 1024) {
  //           if (file.bytes != null) {
  //            _aadharFilePathController.text = file.name;
  //             // _aadharFilePath1Controller.text = file.name;
  //             // _aadharFilePath2Controller.text = file.name;
  //             selectedAdhar1Image.value = file.bytes; // Update the selected image
  //             selectedAdhar2Image.value = file.bytes; // Update the selected image
  //             _aadharImages.add(file.bytes!); // Add file content to list
  //             print('File size: ${file.bytes!.length} bytes');
  //           } else {
  //             print('Failed to read file content: File bytes are null');
  //           }
  //         } else {
  //           Fluttertoast.showToast(
  //             msg: "Selected file exceeds 20MB limit",
  //             toastLength: Toast.LENGTH_LONG,
  //             gravity: ToastGravity.CENTER,
  //             timeInSecForIosWeb: 1,
  //             backgroundColor: Colors.red,
  //             textColor: Colors.white,
  //             fontSize: 16.0,
  //           );
  //         }
  //       }
  //     } else {
  //       print('No file selected');
  //     }
  //   } catch (e) {
  //     print('Error picking file: $e');
  //   }
  // }
  Future<void> _showAadharFileDialog(BuildContext context) async {
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
                    _pickImageAadharFromCamera(context);
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
                    _selectaadhaarFile(context);
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
  Future<void> _pickImageAadharFromCamera(BuildContext context) async {
  //  Future<void> _pickImageFromCamera(BuildContext context) async {
      try {
        // Allow two images to be picked from the camera
        for (int i = 0; i < 2; i++) {
          final ImagePicker _picker = ImagePicker();

          final XFile? pickedImage = await _picker.pickImage(source: ImageSource.camera);

          if (pickedImage != null) {
            File imageFile = File(pickedImage.path);

            if (await imageFile.length() <= 20 * 1024 * 1024) {  // Ensure image is under 20MB
              // Read image bytes
              Uint8List imageBytes = await imageFile.readAsBytes();

              // Store image bytes and file names
              _aadharImages.add(imageBytes);
              _aadharFileNames.add(pickedImage.name);
              selectedAdhar1Image.value = imageBytes; // Update the selected image
              selectedAdhar2Image.value = imageBytes;
              // Save the image name to the corresponding text controller
              if (i == 0) {
                _aadharFilePath1Controller.text = pickedImage.name;
              } else if (i == 1) {
                _aadharFilePath2Controller.text = pickedImage.name;
              }

              print("Image added from camera: ${pickedImage.name}");
            } else {
              Fluttertoast.showToast(
                msg: "Selected file exceeds 20MB limit",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                backgroundColor: Colors.red,
                textColor: Colors.white,
              );
            }
          } else {
            print("No image selected from camera");
          }
        }

        // Check if user has selected exactly two images
        if (_aadharImages.length > 2) {
          Fluttertoast.showToast(
            msg: "Please select a maximum of 2 images.",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.red,
            textColor: Colors.white,
          );
        }
      } catch (e) {
        print("Error picking image from camera: $e");
      }

  }

  Future<void> _selectaadhaarFile(BuildContext context) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
        withData: true,
        allowMultiple: true, // Allow multiple file selection
      );

      if (result != null && result.files.isNotEmpty) {
        if (result.files.length > 2) {
          Fluttertoast.showToast(
            msg: "Please select a maximum of 2 files.",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.red,
            textColor: Colors.white,
          );
          return;
        }

        // Clear previous selections if needed
        _aadharImages.clear();
        _aadharFileNames.clear();

        // Process selected files
        for (int i = 0; i < result.files.length; i++) {
          PlatformFile file = result.files[i];

          if (file.size <= 20 * 1024 * 1024) { // Ensure file is under the 20MB size limit
            if (file.bytes != null && file.name.isNotEmpty) {
              // Store the file bytes and file names in the lists
              _aadharImages.add(file.bytes!); // Add file content
              _aadharFileNames.add(file.name);
              selectedAdhar1Image.value = file.bytes; // Update the selected image
              selectedAdhar2Image.value = file.bytes; // Add file name
              print("_aadharImages:$_aadharImages");
              print("_aadharFileNames:$_aadharFileNames");
              // Save file name to the respective controller
              if (i == 0) {
                _aadharFilePath1Controller.text = file.name;
                print("_aadharFilePath1Controller:${_aadharFilePath1Controller.text}");

              } else if (i == 1) {
                _aadharFilePath2Controller.text = file.name;
                print("_aadharFilePath2Controller:${_aadharFilePath2Controller.text}");

              }

              print('Added Aadhaar file: ${file.name}');
            } else {
              print('Failed to read file content or filename is empty');
            }
          } else {
            Fluttertoast.showToast(
              msg: "Selected file exceeds 20MB limit",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.red,
              textColor: Colors.white,
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

  Future<void> _showPanFileDialog(BuildContext context) async {
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
                    _pickImagePanFromCamera();
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
                    _selectPanFile(context);
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
  Future<void> _pickImagePanFromCamera() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.camera);

      if (image != null) {
        // Convert the selected image to bytes
        final bytes = await image.readAsBytes();

        // Update the selected image and file content
        selectedPanImage.value = bytes;
        _panFileContent = bytes;

        // Update the TextField controller with the file name
        _panFilePathController.text = image.name;
      }
    } catch (e) {
      print('Error capturing image: $e');
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

  Future<void> _showAdhar1FileDialog(BuildContext context) async {
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
                    _pickImageAdhar1FromCamera();
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
                    _selectAdhar1File(context);
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
  Future<void> _pickImageAdhar1FromCamera() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.camera);

      if (image != null) {
        // Convert the selected image to bytes
        final bytes = await image.readAsBytes();

        // Update the selected image and file content
        selectedAdhar1Image.value = bytes;
        _aadhar1FileContent = bytes;

        // Update the TextField controller with the file name
        _aadharFilePath1Controller.text = image.name;
      }
    } catch (e) {
      print('Error capturing image: $e');
    }
  }

  Future<void> _selectAdhar1File(BuildContext context) async {
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
            _aadharFilePath1Controller.text = file.name;
            selectedAdhar1Image.value = file.bytes; // Update the selected image

            _aadhar1FileContent = file.bytes!;
            print('File size: ${_aadhar1FileContent!.length} bytes');
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


  Future<void> _showAdhar2FileDialog(BuildContext context) async {
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
                    _pickImageAdhar2FromCamera();
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
                    _selectAdhar2File(context);
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
  Future<void> _pickImageAdhar2FromCamera() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.camera);

      if (image != null) {
        // Convert the selected image to bytes
        final bytes = await image.readAsBytes();

        // Update the selected image and file content
        selectedAdhar2Image.value = bytes;
        _aadhar2FileContent = bytes;

        // Update the TextField controller with the file name
        _aadharFilePath2Controller.text = image.name;
      }
    } catch (e) {
      print('Error capturing image: $e');
    }
  }

  Future<void> _selectAdhar2File(BuildContext context) async {
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
            _aadharFilePath2Controller.text = file.name;
            selectedAdhar2Image.value = file.bytes; // Update the selected image

            _aadhar2FileContent = file.bytes!;
            print('File size: ${_aadhar2FileContent!.length} bytes');
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

  Future<void> _showProfileDialog(BuildContext context) async {
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
                    _pickImageProfileFromCamera();
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
                    _selectimageprofileFile(context);
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
  Future<void> _pickImageProfileFromCamera() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.camera);

      if (image != null) {
        // Convert the selected image to bytes
        final bytes = await image.readAsBytes();

        // Update the selected image and file content
        selectedProfileImage.value = bytes;
        _profileFileContent = bytes;

        // Update the TextField controller with the file name
        _profileimagePathController.text = image.name;
      }
    } catch (e) {
      print('Error capturing image: $e');
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
            print('File path: ${file.name} name');

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
  final LocationController locationController = Get.put(LocationController());
  final AttendanceController attendanceController = Get.put(AttendanceController());
  Future<void> _refreshData() async {
    // Add logic to refresh data, e.g., fetching from an API
    await Future.delayed(Duration(seconds: 2));
    await _profileEmployeeController.profileemployeeApi();
    await Future.delayed(Duration(seconds: 2));
    print("Data refreshed");
  }
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
      backgroundColor: appColor2,
      body:
     Obx(() =>
        (_getprofileepersonal.isLoading.value)
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
              child: SafeArea(
                child: Form(
                  key: _employeeUpdatePersonalController.personalinfoFormKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: SingleChildScrollView(
                          child: Container(
                            color: Colors.white,
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
                                          readOnly: true,
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
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(vertical: 0),
                                        child: TextFormField(
                                          controller: _workEmailController,
                                          readOnly: true,
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
                                          readOnly: true,
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
                                          readOnly: true,
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
                                        child:
                                        Obx(
                                              () => DropdownButtonFormField<StateModelss>(
                                            value: _employeeUpdatePersonalController.selectedState.value,
                                            decoration: InputDecoration(
                                              labelText: 'State',
                                              labelStyle: const TextStyle(color: Colors.black54, fontSize: 15),
                                              focusedBorder: const UnderlineInputBorder(
                                                borderSide: BorderSide(color: appColor),
                                              ),
                                            ),
                                            hint: Text(
                                              _getprofileepersonal.getprofileemployeeModel?.data?.stateName ?? "",
                                              style: TextStyle(color: Colors.black),
                                            ),
                                            items: _employeeUpdatePersonalController.states.map((StateModelss items) {
                                              // Debugging print to see the state items
                                              print("State item id: ${items.id}, name: ${items.sName}");
                                              return DropdownMenuItem(
                                                value: items,
                                                child: Text(
                                                  items.sName!,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: size.height * 0.015,
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                            onChanged: (StateModelss? newValue) {
                                              print("Selected state id: ${newValue?.id}, name: ${newValue?.sName}");
                                              _employeeUpdatePersonalController.selectedState.value = newValue!;
                                              _employeeUpdatePersonalController.selectedCity.value = null;
                                            },
                                          ),
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
                                                print("onTappCity");
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
                                      ),
                                      // Obx(() {
                                      //   return DropdownButtonFormField<StateModelss>(
                                      //     hint: Text(_getprofileepersonal.getprofileemployeeModel?.data?.stateName ?? "",
                                      //       style: TextStyle(color: Colors.black),),
                                      //     value: _employeeUpdatePersonalController.selectedState.value,
                                      //     onChanged: (StateModelss? newValue) {
                                      //       _employeeUpdatePersonalController.selectedState.value = newValue;
                                      //     },
                                      //     items: _employeeUpdatePersonalController.states
                                      //         .map<DropdownMenuItem<StateModelss>>((StateModelss state) {
                                      //       return DropdownMenuItem<StateModelss>(
                                      //         value: state,
                                      //         child: Text(state.sName ?? ''),
                                      //       );
                                      //     }).toList(),
                                      //   );
                                      // }),

                                      // SizedBox(height: 20),
                                      //
                                      // // City Dropdown
                                      // Obx(() {
                                      //   return _employeeUpdatePersonalController.isLoading.value
                                      //       ? CircularProgressIndicator()  // Show loader if loading
                                      //       : DropdownButtonFormField<CityModell>(
                                      //     hint: Text( _getprofileepersonal
                                      //         .getprofileemployeeModel
                                      //         ?.data
                                      //         ?.cityName ??
                                      //         "",
                                      //       style: TextStyle(color: Colors.black),),
                                      //     value: _employeeUpdatePersonalController.selectedCity.value,
                                      //     onChanged: _employeeUpdatePersonalController.cities.isNotEmpty
                                      //         ? (CityModell? newValue) {
                                      //       _employeeUpdatePersonalController.selectedCity.value = newValue;
                                      //     }
                                      //         : null,  // Disable dropdown if no cities are available
                                      //     items: _employeeUpdatePersonalController.cities.isNotEmpty
                                      //         ? _employeeUpdatePersonalController.cities.map<DropdownMenuItem<CityModell>>((CityModell city) {
                                      //       print("cityyy:${city.cityName}"); // Ensure city names are printed
                                      //       return DropdownMenuItem<CityModell>(
                                      //         value: city,
                                      //         child: Text(city.cityName), // Display city name
                                      //       );
                                      //     }).toList()
                                      //         : [],
                                      //   );
                                      // }),

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
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Container(
                                            width: 200,
                                            padding: EdgeInsets.symmetric(vertical: 0),
                                            child: TextFormField(
                                              readOnly: true,
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
                                          Spacer(),
                                          GestureDetector(
                                            onTap: () {
                                              print("trackkkk");
                                            _getprofileepersonal.launchMaps();
                                              // _selectaadhaarFile(context); // Call the updated function
                                            },
                                            child: Container(
                                              alignment: Alignment.center,
                                              width: 80,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                color: appColorr2,
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              child: Text(
                                                'Track',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ],
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
                                      // Container(
                                      //   padding: EdgeInsets.symmetric(vertical: 0),
                                      //   child: Row(
                                      //     children: [
                                      //       // Expanded widget to ensure the TextField takes the remaining width
                                      //       // Expanded(
                                      //       //   child: TextFormField(
                                      //       //     readOnly: true,
                                      //       //     // validator: (value) {
                                      //       //     //   if (value == null || value.isEmpty) {
                                      //       //     //     return 'Please select your Aadhaar';
                                      //       //     //   }
                                      //       //     //   return null;
                                      //       //     // },
                                      //       //     controller: _aadharFilePathController,
                                      //       //     decoration: InputDecoration(
                                      //       //         labelText: 'Aadhar Image'),
                                      //       //     enabled: false,
                                      //       //   ),
                                      //       // ),
                                      //       GestureDetector(
                                      //         onTap: () {
                                      //           Navigator.push(context, MaterialPageRoute(builder: (_) {
                                      //             return FrontAadharpage();
                                      //           }));
                                      //         },
                                      //         child: Container(
                                      //           height: 80,
                                      //           width: 80,
                                      //           decoration: BoxDecoration(
                                      //             border: Border.all(width: 2, color: Colors.grey),
                                      //               borderRadius: BorderRadius.circular(12.0),
                                      //           ),
                                      //           child:Obx(() {
                                      //             return Hero(
                                      //               tag: 'aadharImg',
                                      //               child: selectedAdhar1Image.value != null
                                      //                   ? ClipRRect(
                                      //                 borderRadius: BorderRadius.circular(10.0),
                                      //                     child: Image.memory(
                                      //                   selectedAdhar1Image.value!,
                                      //                   fit: BoxFit.contain,
                                      //                   width: double.infinity,
                                      //                   height: double.infinity,
                                      //                 ),
                                      //                   )
                                      //                   : (_getprofileepersonal.getprofileemployeeModel?.data?.aadharOne != null
                                      //                   ? ClipRRect(
                                      //                 borderRadius: BorderRadius.circular(10.0),
                                      //                     child: Image.network(
                                      //                  "${FixedText.imageUrlll}${_getprofileepersonal.getprofileemployeeModel?.data?.aadharOne}",
                                      //                  fit: BoxFit.cover,
                                      //                  errorBuilder: (context, error, stackTrace) {
                                      //                     return Image.network(
                                      //                       'https://cdn.pixabay.com/photo/2022/11/09/00/44/aadhaar-card-7579588_1280.png',
                                      //                       fit: BoxFit.contain,
                                      //                     );
                                      //                        },
                                      //                      ),
                                      //                   )
                                      //                   : ClipRRect(
                                      //                 borderRadius: BorderRadius.circular(10.0),
                                      //                     child: Image.asset(
                                      //                     'https://cdn.pixabay.com/photo/2022/11/09/00/44/aadhaar-card-7579588_1280.png',
                                      //                     fit: BoxFit.contain,
                                      //                   ),
                                      //                   )),
                                      //             );
                                      //           }),),
                                      //       ),
                                      //       SizedBox(width: 6), // Add some spacing between the TextField and the Button
                                      //
                                      //       GestureDetector(
                                      //         onTap: () {
                                      //         Navigator.push(context, MaterialPageRoute(builder: (_) {
                                      //           return BackAadharpage();
                                      //         }));
                                      //       },
                                      //
                                      //         child: Container(
                                      //           height: 80,
                                      //           width: 80,
                                      //           decoration: BoxDecoration(
                                      //               borderRadius: BorderRadius.circular(12.0),
                                      //             border: Border.all(width: 2, color: Colors.grey),
                                      //
                                      //           ),
                                      //           child:Obx(() {
                                      //             return Hero(
                                      //               tag: 'aadharImg1',
                                      //               child: selectedAdhar2Image.value != null
                                      //                   ? ClipRRect(
                                      //                 borderRadius: BorderRadius.circular(10.0),
                                      //                     child: Image.memory(
                                      //                      selectedAdhar2Image.value!,
                                      //                      fit: BoxFit.contain,
                                      //                      width: double.infinity,
                                      //                      height: double.infinity,
                                      //                    ),
                                      //                   )
                                      //                   : (_getprofileepersonal.getprofileemployeeModel?.data?.aadharTwo != null
                                      //                   ? ClipRRect(
                                      //                 borderRadius: BorderRadius.circular(10.0),
                                      //                     child: Image.network(
                                      //                  "${FixedText.imageUrlll}${_getprofileepersonal.getprofileemployeeModel?.data?.aadharTwo}",
                                      //                  fit: BoxFit.cover,
                                      //                  errorBuilder: (context, error, stackTrace) {
                                      //                     return Image.network(
                                      //                       'https://cdn.pixabay.com/photo/2022/11/09/00/44/aadhaar-card-7579588_1280.png',
                                      //                       fit: BoxFit.contain,
                                      //                     );
                                      //                     },
                                      //                   ),
                                      //                   )
                                      //                   : ClipRRect(
                                      //                     borderRadius: BorderRadius.circular(10.0),
                                      //               child: Image.asset(
                                      //                   'https://cdn.pixabay.com/photo/2022/11/09/00/44/aadhaar-card-7579588_1280.png',
                                      //                   fit: BoxFit.contain,
                                      //                 ),
                                      //                   )),
                                      //             );
                                      //           }),),
                                      //       ),
                                      //       // SizedBox(width: 10), // Add some spacing between the TextField and the Button4
                                      //       Spacer(),
                                      //       GestureDetector(
                                      //         onTap: (){
                                      //           _selectaadhaarFile(context);
                                      //         },
                                      //         child: Container(
                                      //           alignment: Alignment.center,
                                      //           width: 80,
                                      //           height: 50,
                                      //           decoration: BoxDecoration(
                                      //             color: appColorr2,
                                      //             borderRadius: BorderRadius.circular(10),
                                      //           ),
                                      //           child: Text(
                                      //             'Aadhar',
                                      //             textAlign: TextAlign.center,
                                      //             style: TextStyle(
                                      //               fontSize: 13,
                                      //               fontWeight: FontWeight.bold,
                                      //               color: Colors.white
                                      //             ),
                                      //           ),
                                      //         ),
                                      //       ),
                                      //     ],
                                      //   ),
                                      // ),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 0),
                              child: Row(
                                children: [
                                  // First Aadhaar Image (Front)
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                                        return FrontAadharpage();
                                      }));
                                    },
                                    child: Container(
                                      height: 80,
                                      width: 80,
                                      decoration: BoxDecoration(
                                        border: Border.all(width: 2, color: Colors.grey),
                                        borderRadius: BorderRadius.circular(12.0),
                                      ),
                                      child: Obx(() {
                                        return Hero(
                                          tag: 'aadharImg1',
                                          child: selectedAdhar1Image.value != null
                                              ? ClipRRect(
                                            borderRadius: BorderRadius.circular(10.0),
                                            child: selectedAdhar1Image.value!.isNotEmpty
                                                ? Image.memory(
                                              selectedAdhar1Image.value!,
                                             // _aadharImages.isNotEmpty ? _aadharImages[0] : Uint8List(0),
                                              fit: BoxFit.cover,
                                              width: double.infinity,
                                              height: double.infinity,
                                            )
                                                : ClipRRect(
                                              borderRadius: BorderRadius.circular(10.0),
                                              child: Image.asset(
                                                'https://cdn.pixabay.com/photo/2022/11/09/00/44/aadhaar-card-7579588_1280.png',
                                                fit: BoxFit.contain,
                                              ),
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
                                      }),
                                    ),
                                  ),
                                  //SizedBox(width: 6),
                                  Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      _showAdhar1FileDialog(context);
                                      // _selectaadhaarFile(context); // Call the updated function
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: 80,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: appColorr2,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        'Aadhar1',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  // Second Aadhaar Image (Back)
                                ],
                              ),
                            ),

                            SizedBox(height: 8,),
                            Container(
                                child: Row(children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                                        return BackAadharpage();
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
                                        print("selectedAdhar2Image:${selectedAdhar2Image.value}");
                                        return Hero(
                                          tag: 'aadharImg2',
                                          child: selectedAdhar2Image.value != null
                                              ? ClipRRect(
                                              borderRadius: BorderRadius.circular(10.0),
                                              child:
                                              // selectedAdhar2Image.value!.isNotEmpty ?
                                              Image.memory(
                                                selectedAdhar2Image.value!,
                                                // _aadharImages.length > 1 ? _aadharImages[1] : Uint8List(0),
                                                fit: BoxFit.cover,
                                                width: double.infinity,
                                                height: double.infinity,
                                              )
                                            //     : ClipRRect(
                                            //   borderRadius: BorderRadius.circular(10.0),
                                            //   child: Image.asset(
                                            //     'https://cdn.pixabay.com/photo/2022/11/09/00/44/aadhaar-card-7579588_1280.png',
                                            //     fit: BoxFit.contain,
                                            //   ),
                                            // ),
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
                                      }),
                                    ),
                                  ),
                                  Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      _showAdhar2FileDialog(context);
                                      // _selectaadhaarFile(context); // Call the updated function
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: 80,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: appColorr2,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        'Aadhar2',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],),
                            ),
                            SizedBox(height: 8,),
                                      Container(
                                        padding: EdgeInsets.symmetric(vertical: 0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
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
                                            GestureDetector(
                                              onTap: (){ _showPanFileDialog(context);},
                                              child: Container(
                                                alignment: Alignment.center,
                                                width: 80,
                                                height: 50,
                                                decoration: BoxDecoration(
                                                  color: appColorr2,
                                                  borderRadius: BorderRadius.circular(10),
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
                                // MyElevatedButton(
                                //   onPressed: () {
                                //     print("updateee");
                                //     String formattedDateOfBirth =
                                //         formatDateOfBirth(_dateOfBirthController.text);
                                //     // Use null-aware operators to handle potential null values
                                //     String stateId = _employeeUpdatePersonalController
                                //             .selectedState.value?.id
                                //             .toString() ??
                                //         _getprofileepersonal
                                //             .getprofileemployeeModel?.data?.stateid
                                //             ?.toString() ??
                                //         "2";
                                //     String cityId = _employeeUpdatePersonalController
                                //             .selectedCity.value?.id
                                //             .toString() ??
                                //         _getprofileepersonal
                                //             .getprofileemployeeModel?.data?.cityid
                                //             ?.toString() ??
                                //         "158";
                                //
                                //     ///todo: profile...
                                //
                                //     // _profilePictureEmployeController
                                //     //     .updaprofilrimgProfile(
                                //     //   cvFileContent3: cvFileContent3!,
                                //     //   Empprofile: _profileimagePathController.text,
                                //     // );
                                //     print("dob:$formattedDateOfBirth");
                                //     print("_profileFileContent:$_profileFileContent");
                                //     ///todo: other and document not update.......
                                //     _employeeUpdatePersonalController
                                //         .updateEmployee(
                                //       personalEmailAddress: _emailController.text,
                                //       mobileNumber: _mobileNumberController.text,
                                //       dateOfBirth: _dateOfBirthController.text,
                                //       // age: _ageController.text,
                                //       // fatherName: _fathernameController.text,
                                //       //pAN: _pannoController.text,
                                //       address1: _address1Controller.text,
                                //       address2: _address2Controller.text,
                                //       cityid: cityId,
                                //       // _getprofileepersonal
                                //       //     .getprofileemployeeModel!.data!.cityid
                                //       //     .toString(),
                                //       stateid: stateId,
                                //       pincode: _pincodeController.text,
                                //       aadharNo: _aadharnoController.text,
                                //       // aadharFileContent:
                                //       //     _aadharImages, // Pass list of Aadhaar images
                                //       // Aadharbase64: _aadharFilePathController
                                //       //     .text, // Pass Aadhar file name
                                //       // panFileContent:
                                //       //     _panFileContent!, // Pass PAN file content
                                //       // // Panbase64: _panFilePathController.text.isNotEmpty
                                //       // //     ? _panFilePathController.text
                                //       // //     : null, // Check if PAN file path is provided
                                //       //
                                //       // Panbase64: _panFilePathController
                                //       //     .text,
                                //       fullName: _nameController.text,
                                //       workEmail: _workEmailController.text,
                                //       dateOfJoining: _joiningDateController.text,
                                //       departmentName: 'fgh',
                                //       designationName: _roleController.text,
                                //       companyName: _companynameController.text,
                                //       companyLocationName: _companyLocController.text,
                                //       // profileFileContent: _profileFileContent!,
                                //       // Profilebase64: _profileimagePathController.text, // Pass PAN file name
                                //     );
                                //
                                //     // await Future.delayed(Duration(seconds: 3));
                                //
                                //     ///Clear dropdown value
                                //     //_profileController.selectedState.value = null;
                                //     // _profileController.selectedCity.value = null;
                                //     print("updateee done");
                                //
                                //   },
                                //   text: Text('Update',
                                //   style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600),),
                                //   height: 40,
                                //   width: 200,
                                // ),


                                //TODAYY

                                // MyElevatedButton(
                                //   onPressed: () {
                                //     print("Update button pressed");
                                //
                                //     // Ensure the date is in the correct format before sending
                                //     String formattedDateOfBirth = _dateOfBirthController.text;
                                //
                                //     // Get stateId and cityId with fallback values
                                //     String stateId = _employeeUpdatePersonalController.selectedState.value?.id.toString() ??
                                //         _getprofileepersonal.getprofileemployeeModel?.data?.stateid?.toString() ?? "2";
                                //     String cityId = _employeeUpdatePersonalController.selectedCity.value?.id.toString() ??
                                //         _getprofileepersonal.getprofileemployeeModel?.data?.cityid?.toString() ?? "158";
                                //
                                //     // Create the form data map with DOB
                                //     Map<String, String> formData = {
                                //       'personalEmailAddress': _emailController.text,
                                //       'mobileNumber': _mobileNumberController.text,
                                //       'dateOfBirth': formattedDateOfBirth, // Sending DOB in correct format
                                //       'address1': _address1Controller.text,
                                //       'address2': _address2Controller.text,
                                //       'cityid': cityId,
                                //       'stateid': stateId,
                                //       'pincode': _pincodeController.text,
                                //       'aadharNo': _aadharnoController.text,
                                //       'fullName': _nameController.text,
                                //       'workEmail': _workEmailController.text,
                                //       'dateOfJoining': _joiningDateController.text,
                                //       'departmentName': 'fgh',
                                //       'designationName': _roleController.text,
                                //       'companyName': _companynameController.text,
                                //       'companyLocationName': _companyLocController.text,
                                //     };
                                //
                                //     print("DOB sent: ${_dateOfBirthController.text}");
                                //
                                //     // Call the updateProfile function
                                //     _employeeUpdatePersonalController.updateProfile(formData);
                                //   },
                                //   text: const Text("Update"),
                                //   height: 40,
                                //   width: 200,
                                // ),

                              MyElevatedButton(
                                onPressed: () async {
                                  print("Updating profile...");

                                  String formattedDateOfBirth = formatDateOfBirth(_dateOfBirthController.text);
                                  String stateId = _employeeUpdatePersonalController.selectedState.value?.id.toString() ?? "23";
                                  String cityId = _employeeUpdatePersonalController.selectedCity.value?.id.toString() ?? "532";

                                  Map<String, String> formData = {
                                    'personalEmailAddress': _emailController.text,
                                    'mobileNumber': _mobileNumberController.text,
                                    'dateOfBirth': formattedDateOfBirth,
                                    'address1': _address1Controller.text,
                                    'address2': _address2Controller.text,
                                    'cityid': cityId,
                                    'stateid': stateId,
                                    'pincode': _pincodeController.text,
                                    'aadharNo': _aadharnoController.text,
                                    'fullName': _nameController.text,
                                    'workEmail': _workEmailController.text,
                                    // 'dateOfJoining': _joiningDateController.text,
                                    // 'departmentName': 'ff',
                                    // 'designationName': 'ffd',
                                    // 'companyName': 'vccc',
                                    // 'companyLocationName': 'fff',
                                    'fatherName':_fathernameController.text,
                                    'PanNo':_pannoController.text,
                                  };
                                  print("pan:${_pannoController.text},");

                                 // List<String>? Aadharbasee64 = [_aadharFilePath1Controller.text, _aadharFilePath2Controller.text];
                                  Get.dialog(CustomThreeInOutLoader(), barrierDismissible: false);
                                  await _employeeUpdatePersonalController.updateEmployee(
                                    formData: formData,
                                    aadharFileContent1: _aadhar1FileContent,
                                    Aadhar1base64: _aadharFilePath1Controller.text,
                                    aadharFileContent2: _aadhar2FileContent,
                                    Aadhar2base64: _aadharFilePath2Controller.text,
                                    // aadharFileContent: _aadharImages,
                                    // Aadharbase64: _aadharFileNames,
                                    panFileContent: _panFileContent,
                                    Panbase64: _panFilePathController.text,
                                    profileFileContent: _profileFileContent,
                                    Profilebase64: _profileimagePathController.text,
                                  );
                                  Get.back();
                                },
                                text: Text('Update', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                                height: 40,
                                width: 200,
                              ),
                                        //todayyyy correct for profile and pan
                                // MyElevatedButton(
                                //   onPressed: () async {
                                //     print("updateee");
                                //     print("_dateOfBirthController:${_dateOfBirthController.text}");
                                //     // Format the date of birth
                                //     String formattedDateOfBirth = formatDateOfBirth(_dateOfBirthController.text);
                                //     String formattedDate = '';
                                //     if (_dateOfBirthController.text.isNotEmpty) {
                                //       DateTime parsedDate = DateFormat('yyyy-MM-dd').parse(_dateOfBirthController.text);
                                //       formattedDate = DateFormat('yyyy-MM-dd').format(parsedDate);
                                //     }
                                //     print("formattedDateOfBirth:$formattedDateOfBirth");
                                //     print("formattedDate:$formattedDate");
                                //     // Get stateId and cityId with fallback values
                                //     String stateId = _employeeUpdatePersonalController.selectedState.value?.id.toString() ??
                                //         _getprofileepersonal.getprofileemployeeModel?.data?.stateid?.toString() ??
                                //         "2";
                                //     String cityId = _employeeUpdatePersonalController.selectedCity.value?.id.toString() ??
                                //         _getprofileepersonal.getprofileemployeeModel?.data?.cityid?.toString() ??
                                //         "158";
                                //
                                //     // Prepare form data
                                //     Map<String, String> formData = {
                                //       'personalEmailAddress': _emailController.text,
                                //       'mobileNumber': _mobileNumberController.text,
                                //       'dateOfBirth': formattedDateOfBirth,
                                //       'address1': _address1Controller.text,
                                //       'address2': _address2Controller.text,
                                //       'cityid': cityId,
                                //       'stateid': stateId,
                                //       'pincode': _pincodeController.text,
                                //       'aadharNo': _aadharnoController.text,
                                //       'fullName': _nameController.text,
                                //       'workEmail': _workEmailController.text,
                                //       'dateOfJoining': _joiningDateController.text,
                                //       'departmentName': 'fgh',
                                //       'designationName': _roleController.text,
                                //       'companyName': _companynameController.text,
                                //       'companyLocationName': _companyLocController.text,
                                //     };
                                //
                                //     // Prepare Base64 image data
                                //     String? Aadharbase64 = _aadharFilePathController.text.isNotEmpty ? _aadharFilePathController.text : null;
                                //     List<String>? Aadharbasee64 = [_aadharFilePath1Controller.text,_aadharFilePath2Controller.text];
                                //     String? Panbase64 = _panFilePathController.text.isNotEmpty ? _panFilePathController.text : null;
                                //     String? Profilebase64 = _profileimagePathController.text.isNotEmpty ? _profileimagePathController.text : null;
                                //     print("_profileimagePathController:${_profileimagePathController.text}");
                                //     print("Profilebase6444444:${Profilebase64}");
                                //     print("_dateOfBirthController:${_dateOfBirthController.text}");
                                //     // Call the controller's update function
                                //     await _employeeUpdatePersonalController.updateEmployee(
                                //       // personalEmailAddress: _emailController.text,
                                //       // mobileNumber: _mobileNumberController.text,
                                //       // dateOfBirth: formattedDateOfBirth,
                                //       // address1: _address1Controller.text,
                                //       // address2: _address2Controller.text,
                                //       // cityid: cityId,
                                //       // stateid: stateId,
                                //       // pincode: _pincodeController.text,
                                //       // aadharNo: _aadharnoController.text,
                                //       // fullName: _nameController.text,
                                //       // workEmail: _workEmailController.text,
                                //       // dateOfJoining: _joiningDateController.text,
                                //       // departmentName: 'fgh',
                                //       // designationName: _roleController.text,
                                //       // companyName: _companynameController.text,
                                //       // companyLocationName: _companyLocController.text,
                                //       formData: formData,
                                //       aadharFileContent: _aadharImages, // Pass list of Aadhaar images if any
                                //     //  Aadharbase64: Aadharbase64 != null ? [Aadharbase64] : null, // Pass Aadhar Base64 if available
                                //       Aadharbase64: Aadharbase64, // Pass Aadhar Base64 if available
                                //       panFileContent: _panFileContent, // Pass PAN file content if available
                                //       Panbase64: Panbase64, // Pass PAN Base64 if available
                                //       profileFileContent: _profileFileContent, // Pass profile file content if available
                                //       Profilebase64: Profilebase64, // Pass profile Base64 if available
                                //     );
                                //     Future.delayed(Duration(
                                //       seconds: 1
                                //     ));
                                //     _profileimagePathController.text==null;
                                //     print("_profileController:${_profileimagePathController.text}");
                                //     print("profileFileContent:$_profileFileContent");
                                //     print("Profilebase64:$Profilebase64");
                                //     print("Aadharbase64:$Aadharbase64");
                                //     print("Panbase64:$Panbase64");
                                //     print("dateOfBirthController:${_dateOfBirthController.text}");
                                //
                                //     print("updateee done");
                                //   },
                                //   text: Text(
                                //     'Update',
                                //     style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                                //   ),
                                //   height: 40,
                                //   width: 200,
                                // ),xx

                                const SizedBox(height: 34),
                              ],
                            ),
                          ),
                        ),
                      ),
              ),
            ),
          ),
        ),
     ),
    );
  }
  Widget _buildHeader(BuildContext context) {
    return Obx(()=>
      Container(
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
                Row(
                  children: [
                    Text(
                      attendanceController.attendanceDetailsModel?.data?.loginStatus=="Check-In"?"In":"Out",
                      //locationController.statusColor.value==Color(0xfff44336)?"Out":"In",
                      style: TextStyle(color:attendanceController.attendanceDetailsModel?.data?.loginStatus=="Check-In"?Colors.green:Colors.red),),
                    SizedBox(width: 4,),
                    Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: CircleAvatar(
                        radius: 6,
                        child: Container(
                          decoration: BoxDecoration(
                            color: attendanceController.attendanceDetailsModel?.data?.loginStatus=="Check-In"?Colors.green:Colors.red,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // ),

                // Container(
                //   width: 50,
                //   alignment: Alignment.topRight,
                //   child:  Padding(
                //     padding: const EdgeInsets.only(right: 8.0),
                //     child: GestureDetector(
                //       onTap: () {
                //         showDialog(
                //           context: context,
                //           builder: (context) => AlertDialog(
                //             shape: ContinuousRectangleBorder(
                //                 side: BorderSide.none,
                //                 borderRadius: BorderRadius.circular(12)
                //             ),
                //             title: Text('Check-Out'),
                //             content: Text('Do you really want to check out'),
                //             actions: [
                //               Container(
                //                 height:40,
                //                 width: 70,
                //                 decoration: BoxDecoration(
                //                     color: Colors.green,
                //                     borderRadius: BorderRadius.circular(12)
                //
                //                 ),
                //                 child: TextButton(
                //                   onPressed: () => Navigator.pop(context),
                //                   child: Text('No',style: TextStyle(color: Colors.white),),
                //                 ),
                //               ),
                //
                //               Container(
                //                 height:40,
                //                 width: 70,
                //                 decoration: BoxDecoration(
                //                     color: Colors.red,
                //                     borderRadius: BorderRadius.circular(12)
                //
                //                 ),
                //                 child: TextButton(
                //                   onPressed: () async{
                //                     print("cheedck-Outt");
                //                     await locationController.employeeCheckOut();
                //                     print("cheedck-Outt done");
                //                     WidgetsBinding.instance.addPostFrameCallback((_) {
                //                       Get.offAll(() => BottomBar());
                //                     });
                //                   },
                //                   child: Text('Yes',style: TextStyle(color: Colors.white),),
                //                 ),
                //               ),
                //             ],
                //           ),
                //         );
                //       },
                //       child: CircleAvatar(
                //         radius: 16,
                //         backgroundColor: Colors.white,
                //         child: Icon(
                //           size: 20,
                //           Icons.logout_rounded,
                //           color: Colors.black87,
                //         ),
                //       ),
                //     ),
                //   )
                // ),
              ],
            ),
            Stack(
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileImagePage()));
                  },
                  child: Hero(
                    tag: 'profileImg',
                    child: CircleAvatar(
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
                          child:selectedProfileImage.value!=null?Image.memory(
                            selectedProfileImage.value!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ): _getprofileepersonal
                              .getprofileemployeeModel
                              ?.data
                              ?.empProfile !=
                              null
                              ? Image.network(
                            // "${FixedText.apiurl2}"
                            "${FixedText.imageUrlll}${_getprofileepersonal.getprofileemployeeModel?.data?.empProfile}",
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
                      _showProfileDialog(context);
                      //_selectimageprofileFile(context);

                      // _profilePictureEmployeController.updaprofilrimgProfile(
                      //   cvFileContent3: _profileFileContent,
                      //   Empprofile: _profileimagePathController.text,
                      // );
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
