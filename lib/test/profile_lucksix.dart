import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'package:intl/intl.dart';
import 'package:nd_connect_techland/test/profileUpdate_controller.dart';

import '../components/styles.dart';
import '../services_apis/api_servicesss.dart';
import 'get_controller.dart';


class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final UserProfilesController _getprofilee = Get.put(UserProfilesController());
  final ProfileUpdateController _userProfileUodateController =
  Get.put(ProfileUpdateController(apiService: ApiProvider()));
  final UserProfilesController _profileController = Get.find();
  final TextEditingController idController = TextEditingController(text: '47714b07-d6ca-41b1-9c56-54a24c774467');

  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  final TextEditingController _profileFilePathController =
  TextEditingController();
  File? profileImage;

  Uint8List? _profileImageContent;

  var selectedDate = DateTime.now().obs;

  Future<void> _selectProfileFile(BuildContext context) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: [
          'jpg',
          'jpeg',
          'png'
        ], // Allowing common image formats
        withData: true, // Ensure the file picker reads the file data
      );
      if (result != null && result.files.isNotEmpty) {
        PlatformFile file = result.files.first;
        print('Selected file: ${file.name}, path: ${file.path}');

        if (file.size <= 10 * 1024 * 1024) {
          // Check if file size is less than or equal to 10MB
          if (file.bytes != null) {
            _profileFilePathController.text = file.name;
            _profileImageContent = file.bytes!;
            print('File size: ${_profileImageContent!.length} bytes');
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

  Future<void> _chooseDate() async {
    DateTime? newPickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      helpText: 'Select DOB',
      cancelText: 'Close',
      confirmText: 'Confirm',
      errorFormatText: 'Enter valid date',
      errorInvalidText: 'Enter valid date range',
      fieldLabelText: 'Selected DOB',
    );
    if (newPickedDate != null) {
      selectedDate.value = newPickedDate;
      _dateOfBirthController.text =
          DateFormat('yyyy-MM-dd').format(selectedDate.value);
    }
  }

  @override
  void initState() {
    super.initState();
    if (_getprofilee.profileModel != null) {
      _fullnameController.text = _getprofilee.profileModel!.profile!.fullName!;
      _emailController.text = _getprofilee.profileModel!.profile!.email!;
      _phoneNumberController.text =
          _getprofilee.profileModel!.profile!.phoneNumber.toString();
      _dateOfBirthController.text =
          formatDateOfBirth(_getprofilee.profileModel!.profile!.dob.toString());

      _addressController.text = _getprofilee.profileModel!.profile!.address!;
      _pincodeController.text =
          _getprofilee.profileModel!.profile!.pinCode.toString();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/images/svg_images/ludobackblack.png",
            fit: BoxFit.cover,
          ),
          Obx(
                () => (_getprofilee.isLoading.value)
                ? Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
              child: Column(
                children: [
                  _buildHeader(),
                  SizedBox(
                    height: MediaQuery.of(context).orientation ==
                        Orientation.portrait
                        ? 100
                        : 8,
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
                      borderRadius:
                      BorderRadius.all(Radius.circular(6.0)),
                    ),
                    child: Column(
                      children: [
                        // Profile Image Container
                        Center(
                          child: Stack(
                            children: [
                              CircleAvatar(
                                radius: 60,
                                backgroundColor: Colors.grey[200],
                                backgroundImage: _profileImageContent !=
                                    null
                                    ? MemoryImage(_profileImageContent!)
                                    : null,
                                child: _profileImageContent == null
                                    ? Icon(
                                  Icons.person,
                                  size: 60,
                                  color: Colors.grey[600],
                                )
                                    : null,
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.camera_alt,
                                    color: Colors.blue,
                                  ),
                                  onPressed: () =>
                                      _selectProfileFile(context),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          keyboardType: TextInputType.name,
                          controller: _fullnameController,
                          decoration: InputDecoration(
                            labelText: 'Name',
                            suffixIcon: Icon(
                              Icons.person,
                              size: 23,
                              color: Colors.black12,
                            ),
                            labelStyle: const TextStyle(
                              color: Colors.black54,
                              fontSize: 15,
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: appColor),
                            ),
                          ),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(10)
                          ],
                          controller: _phoneNumberController,
                          decoration: InputDecoration(
                            suffixIcon: Icon(
                              Icons.phone,
                              size: 23,
                              color: Colors.black12,
                            ),
                            labelText: "Phone Number",
                            hintStyle: const TextStyle(
                              fontSize: 13,
                            ),
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
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            suffixIcon: Icon(
                              Icons.email,
                              size: 23,
                              color: Colors.black12,
                            ),
                            labelText: "Email",
                            hintStyle: const TextStyle(
                              fontSize: 13,
                            ),
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
                        TextFormField(
                          controller: _dateOfBirthController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter DOB';
                            }
                            return null;
                          },
                          onTap: _chooseDate,
                          decoration: InputDecoration(
                            suffixIcon: Icon(
                              Icons.date_range,
                              size: 23,
                              color: Colors.black12,
                            ),
                            labelText: "Date of Birth",
                            hintStyle: const TextStyle(
                              fontSize: 13,
                            ),
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
                        TextFormField(
                          controller: _addressController,
                          decoration: InputDecoration(
                            suffixIcon: Icon(
                              Icons.location_on,
                              size: 23,
                              color: Colors.black12,
                            ),
                            labelText: "Address",
                            hintStyle: const TextStyle(
                              fontSize: 13,
                            ),
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
                        TextFormField(
                          controller: _pincodeController,
                          decoration: InputDecoration(
                            suffixIcon: Icon(
                              Icons.pin_drop,
                              size: 23,
                              color: Colors.black12,
                            ),
                            labelText: "Pincode",
                            hintStyle: const TextStyle(
                              fontSize: 13,
                            ),
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
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 16),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_userProfileUodateController
                            .profileFormKey.currentState
                            ?.validate() ==
                            true) {
                          _userProfileUodateController
                              .profileFormKey.currentState
                              ?.save();
                          await _userProfileUodateController
                              .updateProfile(
                            fullName: _fullnameController.text,
                            email: _emailController.text,
                                phoneNumber: _phoneNumberController.text,
                                dob: _dateOfBirthController.text,
                                pinCode: _pincodeController.text,
                            address: _addressController.text,
                            profileImagePath: 'path/to/profile_image',
                            profileImage: profileImage ?? File(''), id: idController.text,
                          );
                        }
                      },
                      child: Text('Update Profile'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      alignment: Alignment.center,
      child: Text(
        'Edit Profile',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}