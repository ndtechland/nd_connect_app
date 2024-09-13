// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';
//
// import '../components/styles.dart';
// import '../services_apis/api_servicesss.dart';
// import '../test/get_controller.dart';
// import '../test/profileUpdate_controller.dart';
//
// class ProfilePage extends StatefulWidget {
//   @override
//   _ProfilePageState createState() => _ProfilePageState();
// }
//
// class _ProfilePageState extends State<ProfilePage> {
//   final ProfileUpdateController profileController = Get.put(
//     ProfileUpdateController(apiService: ApiProvider()),
//   );
//   final UserProfilesController _getprofilee = Get.put(UserProfilesController());
//   final _formKey = GlobalKey<FormState>();
//
//   // Text editing controllers for each field
//   final TextEditingController idController = TextEditingController(text: 'c0c135c2-2839-4d33-ac92-2b29e1b1e2d1');
//   final TextEditingController fullNameController = TextEditingController();
//   final TextEditingController phoneNumberController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController addressController = TextEditingController();
//   final TextEditingController pinCodeController = TextEditingController();
//   final TextEditingController dobController = TextEditingController();
//   final TextEditingController profileImagePathController = TextEditingController(text: 'abc.png');
//
//   File? profileImage;
//
//   // Function to pick image from gallery
//   Future<void> _pickImage() async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//
//     if (pickedFile != null) {
//       setState(() {
//         profileImage = File(pickedFile.path);
//       });
//     }
//   }
//
//   // Function to update profile
//   void _updateProfile() {
//     if (_formKey.currentState?.validate() ?? false) {
//       try{
//       profileController.updateProfile(
//         id: idController.text,
//         fullName: fullNameController.text,
//         phoneNumber: phoneNumberController.text,
//         email: emailController.text,
//         address: addressController.text,
//         pinCode: pinCodeController.text,
//         dob: dobController.text,
//         profileImagePath: profileImagePathController.text,
//         profileImage: profileImage ?? File('/path/to/default/image.png'), // Handle default case
//       );
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Profile updated successfully!'),
//           backgroundColor: Colors.green,
//         ),
//       );
//       print({
//         'id': idController.text,
//         'fullName': fullNameController.text,
//         'phoneNumber': phoneNumberController.text,
//         'email': emailController.text,
//         'address': addressController.text,
//         'pinCode': pinCodeController.text,
//         'dob': dobController.text,
//         'profileImagePath': profileImagePathController.text,
//         'profileImage':profileImage
//       });
//
//       } catch (e) {
//         // Show snackbar on error
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Failed to update profile: $e'),
//             backgroundColor: Colors.red,
//           ),
//         );
//       }
//     }
//     // _getprofilee.userprofileApi();
//     // print("userProfileApi:${_getprofilee.profileModel?.profile?.fullName.toString()}");
//   }
//
//   var selectedDate = DateTime.now().obs;
//
//   Future<void> _chooseDate() async {
//     DateTime? newPickedDate = await showDatePicker(
//       context: context,
//       initialDate: selectedDate.value,
//       firstDate: DateTime(1900),
//       lastDate: DateTime.now(),
//       helpText: 'Select DOB',
//       cancelText: 'Close',
//       confirmText: 'Confirm',
//       errorFormatText: 'Enter valid date',
//       errorInvalidText: 'Enter valid date range',
//       fieldLabelText: 'Selected DOB',
//     );
//     if (newPickedDate != null) {
//       selectedDate.value = newPickedDate;
//       dobController.text =
//           DateFormat('yyyy-MM-dd').format(selectedDate.value);
//     }
//   }
//   // @override
//   // void initState() {
//   //   super.initState();
//   //   _getprofilee.userprofileApi();
//   //   print("userNa:${_getprofilee.profileModel?.profile?.fullName.toString()}");
//   //   if (_getprofilee.profileModel != null) {
//   //     print("userName:${_getprofilee.profileModel?.profile?.fullName.toString()}");
//   //
//   //     fullNameController.text = _getprofilee.profileModel!.profile!.fullName!;
//   //     emailController.text = _getprofilee.profileModel!.profile!.email!;
//   //     phoneNumberController.text =
//   //         _getprofilee.profileModel!.profile!.phoneNumber.toString();
//   //     dobController.text =
//   //         _getprofilee.profileModel!.profile!.dob.toString();
//   //
//   //     addressController.text = _getprofilee.profileModel!.profile!.address!;
//   //     pinCodeController.text =
//   //         _getprofilee.profileModel!.profile!.pinCode.toString();
//   //   }
//   //   else{
//   //     print("getprofilee.profileModel:${_getprofilee.profileModel}");
//   //   }
//   // }
//   @override
//   void initState() {
//     super.initState();
//     print("userNa:${_getprofilee.profileModel?.profile?.fullName.toString()}");
//
//     _getprofilee.userprofileApi().then((_) {
//       print("userName:${_getprofilee.profileModel?.profile?.fullName.toString()}");
//
//       if (_getprofilee.profileModel != null) {
//         print("userNameee:${_getprofilee.profileModel?.profile?.fullName.toString()}");
//
//         setState(() {
//           fullNameController.text = _getprofilee.profileModel!.profile!.fullName!;
//           emailController.text = _getprofilee.profileModel!.profile!.email!;
//           phoneNumberController.text = _getprofilee.profileModel!.profile!.phoneNumber.toString();
//           dobController.text = _getprofilee.profileModel!.profile!.dob.toString();
//           addressController.text = _getprofilee.profileModel!.profile!.address!;
//           pinCodeController.text = _getprofilee.profileModel!.profile!.pinCode.toString();
//         });
//       } else {
//         print("getprofilee.profileModel :${_getprofilee.profileModel}");
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Edit Profile'),centerTitle: true,),
//       body:   Obx(
//     () => (_getprofilee.isLoading.value)
//     ? Center(child: CircularProgressIndicator())
//         :
//     SingleChildScrollView(
//       child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Container(
//             height: 570,
//             width: 400,
//             padding: const EdgeInsets.symmetric(
//                 vertical: 0, horizontal: 16),
//             margin: const EdgeInsets.symmetric(
//                 vertical: 0, horizontal: 16),
//             decoration: const BoxDecoration(
//               color: Colors.white,
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black12,
//                   blurRadius: 20.0,
//                 ),
//               ],
//               borderRadius:
//               BorderRadius.all(Radius.circular(6.0)),
//             ),
//             child: Form(
//               key: _formKey,
//               child: ListView(
//                 children: [
//                   SizedBox(height: 15,),
//                   Center(
//                     child: Stack(
//                       children: [
//                         CircleAvatar(
//                           radius: 60,
//                           backgroundColor: Colors.grey[200],
//                           backgroundImage: profileImage != null ? FileImage(profileImage!) : AssetImage('assets/default_profile.png') as ImageProvider,
//                         ),
//                         Positioned(
//                           bottom: 0,
//                           right: 0,
//                           child: IconButton(
//                             icon: Icon(
//                               Icons.camera_alt,
//                               color: Colors.blue,
//                             ),
//                             onPressed: _pickImage,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   TextFormField(
//                     keyboardType: TextInputType.name,
//                     controller: fullNameController,
//                     decoration: InputDecoration(
//                       labelText: 'Name',
//                       suffixIcon: Icon(
//                         Icons.person,
//                         size: 23,
//                         color: Colors.black12,
//                       ),
//                       labelStyle: const TextStyle(
//                         color: Colors.black54,
//                         fontSize: 15,
//                       ),
//                       focusedBorder: const UnderlineInputBorder(
//                         borderSide: BorderSide(color: appColor),
//                       ),
//                     ),
//                   ),
//                   TextFormField(
//                     keyboardType: TextInputType.phone,
//                     inputFormatters: [
//                       LengthLimitingTextInputFormatter(10)
//                     ],
//                     controller: phoneNumberController,
//                     decoration: InputDecoration(
//                       suffixIcon: Icon(
//                         Icons.phone,
//                         size: 23,
//                         color: Colors.black12,
//                       ),
//                       labelText: "Phone Number",
//                       hintStyle: const TextStyle(
//                         fontSize: 13,
//                       ),
//                       labelStyle: const TextStyle(
//                           color: Colors.black54, fontSize: 13),
//                       focusedBorder: const UnderlineInputBorder(
//                         borderSide: BorderSide(color: appColor),
//                       ),
//                       enabledBorder: const UnderlineInputBorder(
//                         borderSide:
//                         BorderSide(color: Colors.black12),
//                       ),
//                     ),
//                   ),
//                   TextFormField(
//                     keyboardType: TextInputType.name,
//                     controller: emailController,
//                     readOnly: true,
//                     decoration: InputDecoration(
//                       labelText: 'Email',
//                       suffixIcon: Icon(
//                         Icons.email,
//                         size: 23,
//                         color: Colors.black12,
//                       ),
//                       labelStyle: const TextStyle(
//                         color: Colors.black54,
//                         fontSize: 15,
//                       ),
//                       focusedBorder: const UnderlineInputBorder(
//                         borderSide: BorderSide(color: appColor),
//                       ),
//                     ),
//                   ),
//                   TextFormField(
//                     controller: dobController,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter DOB';
//                       }
//                       return null;
//                     },
//                     onTap: _chooseDate,
//                     decoration: InputDecoration(
//                       suffixIcon: Icon(
//                         Icons.date_range,
//                         size: 23,
//                         color: Colors.black12,
//                       ),
//                       labelText: "Date of Birth",
//                       hintStyle: const TextStyle(
//                         fontSize: 13,
//                       ),
//                       labelStyle: const TextStyle(
//                           color: Colors.black54, fontSize: 13),
//                       focusedBorder: const UnderlineInputBorder(
//                         borderSide: BorderSide(color: appColor),
//                       ),
//                       enabledBorder: const UnderlineInputBorder(
//                         borderSide:
//                         BorderSide(color: Colors.black12),
//                       ),
//                     ),
//                   ),
//                   TextFormField(
//                     keyboardType: TextInputType.name,
//                     controller: addressController,
//                     decoration: InputDecoration(
//                       labelText: 'Address',
//                       suffixIcon: Icon(
//                         Icons.location_on,
//                         size: 23,
//                         color: Colors.black12,
//                       ),
//                       labelStyle: const TextStyle(
//                         color: Colors.black54,
//                         fontSize: 15,
//                       ),
//                       focusedBorder: const UnderlineInputBorder(
//                         borderSide: BorderSide(color: appColor),
//                       ),
//                     ),
//                   ),
//                   TextFormField(
//                     keyboardType: TextInputType.name,
//                     controller: pinCodeController,
//                     decoration: InputDecoration(
//                       labelText: 'Pin Code',
//                       suffixIcon: Icon(
//                         Icons.pin_drop,
//                         size: 23,
//                         color: Colors.black12,
//                       ),
//                       labelStyle: const TextStyle(
//                         color: Colors.black54,
//                         fontSize: 15,
//                       ),
//                       focusedBorder: const UnderlineInputBorder(
//                         borderSide: BorderSide(color: appColor),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: _updateProfile,
//                     child: Text('Update Profile'),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//     ),
//     ));
//   }
// }
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../components/styles.dart';
import '../services_apis/api_servicesss.dart';
import 'get_controller.dart';
import 'profileUpdate_controller.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ProfileUpdateController profileController = Get.put(
    ProfileUpdateController(apiService: ApiProvider()),
  );
  final UserProfilesController _getprofilee = Get.put(UserProfilesController());
  final _formKey = GlobalKey<FormState>();
var imageUrl ="https://api.luckysix.in/images/";
  // Text editing controllers for each field
  final TextEditingController idController = TextEditingController(text: 'c0c135c2-2839-4d33-ac92-2b29e1b1e2d1');
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController pinCodeController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController profileImagePathController = TextEditingController(text: 'abc.png');

  File? profileImage;

  // Function to pick image from gallery
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        profileImage = File(pickedFile.path);
      });
    }
  }

  // Function to update profile
  void _updateProfile() {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        profileController.updateProfile(
          id: idController.text,
          fullName: fullNameController.text,
          phoneNumber: phoneNumberController.text,
          email: emailController.text,
          address: addressController.text,
          pinCode: pinCodeController.text,
          dob: dobController.text,
          profileImagePath: profileImagePathController.text,
          profileImage: profileImage ?? File('/path/to/default/image.png'), // Handle default case
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Profile updated successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      } catch (e) {
        // Show snackbar on error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to update profile: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  var selectedDate = DateTime.now().obs;

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
      dobController.text =
          DateFormat('yyyy-MM-dd').format(selectedDate.value);
    }
  }

  @override
  void initState() {
    super.initState();
    print("userNa:${_getprofilee.profileModel?.profile?.fullName.toString()}");

    _getprofilee.userprofileApi().then((_) {
      print("userName:${_getprofilee.profileModel?.profile?.fullName.toString()}");

      if (_getprofilee.profileModel != null) {
        print("userNameee:${_getprofilee.profileModel?.profile?.fullName.toString()}");
        print("imagee: $imageUrl${_getprofilee.profileModel!.profile!.profilePicture}");
        print("imagee1: $profileImage");
        setState(() {
          fullNameController.text = _getprofilee.profileModel!.profile!.fullName!;
          emailController.text = _getprofilee.profileModel!.profile!.email!;
          phoneNumberController.text = _getprofilee.profileModel!.profile!.phoneNumber.toString();
          dobController.text = _getprofilee.profileModel!.profile!.dob.toString().substring(0,10);
          addressController.text = _getprofilee.profileModel!.profile!.address!;
          pinCodeController.text = _getprofilee.profileModel!.profile!.pinCode.toString();
        });
      } else {
        print("getprofilee.profileModel :${_getprofilee.profileModel}");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Profile'), centerTitle: true),
      body: Obx(
            () => (_getprofilee.isLoading.value)
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 590,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
              margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
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
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    SizedBox(height: 15),
                    Center(
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.grey[200],
                            backgroundImage: profileImage != null
                                ? FileImage(profileImage!)
                                : NetworkImage("$imageUrl${_getprofilee.profileModel!.profile!.profilePicture}")
                            as ImageProvider,
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: IconButton(
                              icon: Icon(
                                Icons.camera_alt,
                                color: Colors.blue,
                              ),
                              onPressed: _pickImage,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      keyboardType: TextInputType.name,
                      controller: fullNameController,
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
                      inputFormatters: [LengthLimitingTextInputFormatter(10)],
                      controller: phoneNumberController,
                      decoration: InputDecoration(
                        suffixIcon: Icon(
                          Icons.phone,
                          size: 23,
                          color: Colors.black12,
                        ),
                        labelText: "Phone Number",
                        hintStyle: const TextStyle(fontSize: 13),
                        labelStyle: const TextStyle(color: Colors.black54, fontSize: 13),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: appColor),
                        ),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black12),
                        ),
                      ),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.name,
                      controller: emailController,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        suffixIcon: Icon(
                          Icons.email,
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
                    SizedBox(height: 15),
                    TextFormField(
                      readOnly: true,
                      controller: dobController,
                      onTap: () {
                        _chooseDate();
                      },
                      decoration: InputDecoration(
                        labelText: "DOB",
                        suffixIcon: Icon(
                          Icons.calendar_today,
                          size: 23,
                          color: Colors.black12,
                        ),
                        hintStyle: const TextStyle(fontSize: 13),
                        labelStyle: const TextStyle(color: Colors.black54, fontSize: 13),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: appColor),
                        ),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black12),
                        ),
                      ),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.streetAddress,
                      controller: addressController,
                      decoration: InputDecoration(
                        labelText: 'Address',
                        suffixIcon: Icon(
                          Icons.location_on,
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
                      keyboardType: TextInputType.number,
                      controller: pinCodeController,
                      inputFormatters: [LengthLimitingTextInputFormatter(6)],
                      decoration: InputDecoration(
                        suffixIcon: Icon(
                          Icons.local_post_office,
                          size: 23,
                          color: Colors.black12,
                        ),
                        labelText: "Pin Code",
                        hintStyle: const TextStyle(fontSize: 13),
                        labelStyle: const TextStyle(color: Colors.black54, fontSize: 13),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: appColor),
                        ),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black12),
                        ),
                      ),
                    ),
                    SizedBox(height: 35),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35.0),
                      child: ElevatedButton(
                        onPressed: _updateProfile,
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: Text('Update Profile'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
