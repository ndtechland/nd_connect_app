import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:logging/logging.dart';
import 'package:nd_connect_techland/controllers/attendance_controller.dart';
import 'package:nd_connect_techland/controllers/location_controller.dart';
import 'package:nd_connect_techland/models/about_company_model.dart';
import 'package:nd_connect_techland/models/attendance_activity_model.dart';
import 'package:nd_connect_techland/models/attendance_model.dart';
import 'package:nd_connect_techland/models/company_location_model.dart';
import 'package:nd_connect_techland/models/current_month_attendance_model.dart';
import 'package:nd_connect_techland/models/faq_model.dart';
import 'package:nd_connect_techland/models/leaves_detail_model.dart';
import 'package:nd_connect_techland/models/sub_task_model.dart';
import 'package:nd_connect_techland/models/task_history_model.dart';
import 'package:nd_connect_techland/models/task_model.dart';
import 'package:nd_connect_techland/models/total_attendance_model.dart';
import 'package:nd_connect_techland/modules/all_pages/attendance/attendance.dart';
import 'package:nd_connect_techland/modules/all_pages/total_attendance/current_month_attendance.dart';
import 'package:nd_connect_techland/modules/bottom_bar/bottom_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/static_text.dart';
import '../controllers/employeee_controllersss/employee_login_controllers/employee_login_controllers.dart';
import '../controllers/login_controllers/login_controllersss.dart';
import '../models/all_catagary.dart';
import '../models/all_jobs_model.dart';
import '../models/applied_job_model.dart';
import '../models/city_model.dart';
import '../models/company_details_comId_model.dart';
import '../models/company_model.dart';
import '../models/employee_model/all_salary_slip_model.dart';
import '../models/employee_model/apply_leave_model_dropdown.dart';
import '../models/employee_model/dashboard_employee_model.dart';
import '../models/employee_model/offer_appointment_latter_model.dart';
import '../models/employee_model/payment_get_model/get_payment_model.dart';
import '../models/employee_model/profile_model/bank_profile_details_employee.dart';
import '../models/employee_model/profile_model/profileUpdateEmployeeModel.dart';
import '../models/employee_model/profile_model/profile_basic_detail_model.dart';
import '../models/employee_model/profile_model/profile_info_model_personal.dart';
import '../models/employee_model/support_comman_model.dart';
import '../models/events_model.dart';
import '../models/job_description_by_job_id.dart';
import '../models/job_list_bycat_id_model.dart';
import '../models/overtime_model.dart';
import '../models/profile_model.dart';
import '../models/related_job_byjobId.dart';
import '../models/saved_job_model.dart';
import '../models/state_model.dart';
import '../models/task_details_model.dart';
import '../models/testimonial_model.dart';
import '../models/total_leaves_model.dart';
import '../modules/all_pages/pages/bookmark.dart';
import '../modules/all_pages/pages/home.dart';
import '../modules/all_pages/pages/login.dart';
import '../test/p_model.dart';

var prefs = GetStorage();
final box = GetStorage();

final LoginController _loginController = Get.put(LoginController());
final AttendanceController atteControler = Get.put(AttendanceController());
final LocationController locationController = Get.put(LocationController());
EmployeeLoginController _employeeloginController =
    Get.put(EmployeeLoginController());

class ApiProvider {
static var baseUrl = FixedText.apiurl;
  static String token = '';
  static String MedicineId = ''.toString();
  static String adminId = ''.toString();
  static String userId = ''.toString();
  static String employeeId = ''.toString();
  final box = GetStorage();

  ///TODO: here we have to add different api in this page...........
  /// TODO: from here user 1 section...........
  ///
  ///todo: payment api...
  final String baseUrlll = 'https://api.hirejobindia.com/Pay';
  final Logger _logger = Logger('PaymentService');

  Future<String> createPaymentRequest(String amount, String firstName,
      String email, String phone, String productInfo) async {
    final Uri uri = _buildUri(amount, firstName, email, phone, productInfo);

    // Retrieve token from GetStorage
    final storage = GetStorage();
    var token = storage.read("token");

    if (token == null) {
      throw Exception('Token not found in storage');
    }
    print("tokenpay${token}");

    // Log the request URL for debugging
    print('Request URL: $uri');

    // Log the request URL for debugging
    _logger.info('Request URL: $uri');

    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // Include Bearer token in headers
      },
    );

    // Log the response status and body for debugging
    _logger.info('Response status: ${response.statusCode}');
    _logger.info('Response body: ${response.body}');

    // Log the response status and body for debugging
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    return _handleResponse(response);
  }

  Uri _buildUri(String amount, String firstName, String email, String phone,
      String productInfo) {
    return Uri.parse(baseUrlll).replace(queryParameters: {
      'Amount': amount,
      'FirstName': firstName,
      'Email': email,
      'Phone': phone,
      'ProductInfo': productInfo,
      'Surl': 'https://api.hirejobindia.com/PaymentResultsuccess',
      'Furl': 'https://api.hirejobindia.com/PaymentResultfail',
    });
  }

  String _handleResponse(http.Response response) {
    if (response.statusCode == 200) {
      if (response.body.isEmpty) {
        throw EmptyResponseException('Response body is empty');
      }
      try {
        final responseBody = json.decode(response.body);
        if (responseBody.containsKey('payurl')) {
          return responseBody['payurl'];
        } else {
          throw KeyNotFoundException('Key "payurl" not found in response');
        }
      } catch (e) {
        throw JsonParsingException('Failed to parse response: $e');
      }
    } else {
      if (response.body.isEmpty) {
        throw EmptyResponseException('Error response body is empty');
      }
      try {
        final responseBody = json.decode(response.body);
        final errorMessage =
            responseBody['error_message'] ?? 'Failed to create payment request';
        throw PaymentRequestException(errorMessage);
      } catch (e) {
        throw JsonParsingException('Failed to create payment request: $e');
      }
    }
  }

  //user signup..............
  static String apiUrl = "${baseUrl}Login/createProfile";

  static Future<http.Response> createProfile(Map<String, String> formData,
      Uint8List cvFileContent, String cvFileName) async {
    var uri = Uri.parse(apiUrl);
    var request = http.MultipartRequest('POST', uri);

    // Add form fields
    formData.forEach((key, value) {
      request.fields[key] = value;
    });

    // Add file field
    request.files.add(http.MultipartFile.fromBytes(
      'CVFileName', // The name of the file field
      cvFileContent,
      filename: cvFileName, // Use the file name from the parameter
      contentType:
      MediaType('application', 'pdf'), // Use MediaType from http_parser
    ));

    // Send the request
    var response = await request.send();

    // Parse the response
    var httpResponse = await http.Response.fromStream(response);
    if (httpResponse.statusCode == 200) {
      // Assuming the response body contains the user ID in JSON format
      var jsonResponse = jsonDecode(httpResponse.body);
      var userId = jsonResponse['loginProfile']
      ['id']; // Extract the user ID from getData

      // Save the user ID using GetStorage
      final storage = GetStorage();
      storage.write('userId', userId);

      // Print the user ID
      print('Saved user ID: $userId');
      // Show success toast
      Fluttertoast.showToast(
        msg: "Profile created successfully!",
        backgroundColor: Colors.green,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
      );
    } else {
      print(
          'Failed to create profile. Status code: ${httpResponse.statusCode}');
      Fluttertoast.showToast(
        msg:
        "Failed to create profile. Status code: ${httpResponse.statusCode}",
        backgroundColor: Colors.red,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
    }
    return httpResponse;
  }

  ///4.login_email..........post...apis...
  static Future<http.Response> LoginApi(String emailId, String password) async {
    var url = "${baseUrl}Login/ProfileLogin";
    //App/UserChangePassword?userId=38
    var body = jsonEncode({
      "emailId": emailId,
      "password": password,
    });

    print("loginnnn");
    print(body);

    http.Response r = await http.post(
      Uri.parse(url),
      body: body,
      headers: {
        "Content-Type": "application/json",
      },
    );

    print(r.body);

    if (r.statusCode == 200) {
      var responseData = json.decode(r.body);
      var userId = responseData['loginProfile']['id'];

      // Save user ID (assuming 'Id' is part of the response JSON)
      prefs.write("Id", userId);
      print('Saved userId: $userId');

      // Navigate to HomePage
      Get.to(() => BottomBar());

      return r;
    } else if (r.statusCode == 401) {
      Get.snackbar('Message', r.body);
    } else {
      Get.snackbar('Error', r.body);
    }

    return r;
  }

  ///user_ profile__update.........15 jun

  static String apiUrl7 = "${baseUrl}App/UpdateProfile";

  static Future<http.Response> updateuserProfileApi(
      Map<String, String> formData,
      Uint8List cvFileContent,
      String CVFileName,
      Uint8List cvFileContent2,
      String ProfileImage,) async {
    var uri = Uri.parse(apiUrl7);
    var request = http.MultipartRequest('POST', uri);

    // Add form fields
    formData.forEach((key, value) {
      request.fields[key] = value;
    });

    // Helper function to determine the MediaType based on the file extension
    MediaType getMediaType(String filename) {
      String ext = filename
          .split('.')
          .last
          .toLowerCase();
      switch (ext) {
      // case 'jpg':
      // case 'jpeg':
      //   return MediaType('image', 'jpeg');
      // case 'png':
      //   return MediaType('image', 'png');
        case 'pdf':
          return MediaType('application', 'pdf');
        default:
          throw Exception('Unsupported file type');
      }
    }

    MediaType getMediaType2(String filename) {
      String ext = filename
          .split('.')
          .last
          .toLowerCase();
      switch (ext) {
        case 'jpg':
        case 'jpeg':
          return MediaType('image', 'jpeg');
        case 'png':
          return MediaType('image', 'png');
      // case 'pdf':
      //   return MediaType('application', 'pdf');
        default:
          throw Exception('Unsupported file type');
      }
    }

    // Add file field
    request.files.add(http.MultipartFile.fromBytes(
        'CVFileName', // The name of the file field
        cvFileContent,
        filename: CVFileName,
        // Use the file name from the parameter
        contentType: getMediaType(CVFileName)

      //contentType:
      //MediaType('application', 'pdf'), // Use MediaType from http_parser
    ));

    request.files.add(http.MultipartFile.fromBytes(
        'ProfileImage', // The name of the file field
        cvFileContent2,
        filename: ProfileImage,
        // Use the file name from the parameter
        contentType: getMediaType2(ProfileImage)

      //contentType:
      //MediaType('application', 'pdf'), // Use MediaType from http_parser
    ));

    // Get token from GetStorage
    // final storage = GetStorage();
    // var token = storage.read('token');

    // Set token in headers
    //request.headers['Authorization'] = 'Bearer $token';

    // Send the request
    var response = await request.send();

    // Parse the response
    var httpResponse = await http.Response.fromStream(response);

    // Print the response data
    print('Response status: ${httpResponse.statusCode}');
    print('Response body: ${httpResponse.body}');

    if (httpResponse.statusCode == 200) {
      // Show success toast
      Fluttertoast.showToast(
        msg: "Profile Updated successfully!",
        backgroundColor: Colors.green,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
      );
    } else {
      // Show error toast
      Fluttertoast.showToast(
        msg:
        "Failed to Update Profile. Status code: ${httpResponse.statusCode}",
        backgroundColor: Colors.red,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
    }

    return httpResponse;
  }

  ///change password api,,,,for user.......
  static Future<http.Response?> ChangePasswordApi(BuildContext context,
      // Added context parameter
      String CurrentPassword,
      String NewPassword,
      String ConfirmPassword) async {
    var prefs = GetStorage();

    // Read saved userId
    String userId = prefs.read("Id").toString();
    print('wwwuseridEE:$userId');

    var url = "${baseUrl}App/UserChangePassword";
    var body = jsonEncode({
      "currentPassword": CurrentPassword,
      "newPassword": NewPassword,
      "confirmPassword": ConfirmPassword,
      "userId": userId
    });

    print("loginnnn");
    print(body);

    try {
      http.Response r = await http.post(
        Uri.parse(url),
        body: body,
        headers: {
          "Content-Type": "application/json",
        },
      ).timeout(const Duration(seconds: 10));

      print(r.body);

      if (r.statusCode == 200) {
        var responseData = json.decode(r.body);
        // var userId = responseData['loginProfile']['id'];

        // Save user ID (assuming 'Id' is part of the response JSON)
        // prefs.write("Id", userId);
        //  print('Saved userId: $userId');

        // Show loading dialog
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        );

        // Simulate a delay for async operations
        await Future.delayed(Duration(seconds: 1));

        // Clear shared preferences
        SharedPreferences.getInstance().then((prefs) => prefs.clear());

        // Hide loading dialog
        Get.back();

        // Navigate to Login Page
        Get.offAll(() => Login());

        // Show success toast
        Fluttertoast.showToast(
          msg: "Password changed successfully!",
          backgroundColor: Colors.green,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
        );
      } else if (r.statusCode == 401) {
        Fluttertoast.showToast(
          msg: "Unauthorized access. Status code: ${r.statusCode}",
          backgroundColor: Colors.red,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
        );

        Get.snackbar('Error', r.body);
      } else {
        Fluttertoast.showToast(
          msg: "Failed to change password. Status code: ${r.statusCode}",
          backgroundColor: Colors.red,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
        );

        Get.snackbar('Error', r.body);
      }

      return r;
    } on TimeoutException catch (_) {
      Fluttertoast.showToast(
        msg: "Network connection slow or disconnected",
        backgroundColor: Colors.red,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );

      return null;
    } on SocketException catch (_) {
      Fluttertoast.showToast(
        msg:
        "Network error: Unable to resolve host. Please check your internet connection.",
        backgroundColor: Colors.red,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );

      return null;
    } catch (error) {
      print('Network error: $error');

      Fluttertoast.showToast(
        msg: "Network error: $error",
        backgroundColor: Colors.red,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );

      return null;
    }
  }


  ///api 1.....all jobs....
  static AllJobsApi() async {
    var url = "${baseUrl}Admin/GetCurrent_Opening";
    try {
      http.Response r = await http.get(Uri.parse(url));
      print(r.body.toString());
      if (r.statusCode == 200) {
        var GetJobListModel = allJobsApiFromJson(r.body);
        return GetJobListModel;
      }
      print(url);
      print(r.body);
      print(r.statusCode);
    } catch (error) {
      return;
    }
  }

  ///api 2.....all cat....
  ///

  static Future<PostedByModel?> AllcatagoryApi() async {
    var url = "${baseUrl}Admin/FilterData";
    try {
      http.Response response = await http.get(Uri.parse(url));
      print(response.body);
      if (response.statusCode == 200) {
        return PostedByModel.fromJson(jsonDecode(response.body));
      } else {
        print('Request failed with status: ${response.statusCode}');
        return null;
      }
    } catch (error) {
      print('Error fetching categories: $error');
      return null;
    }
  }

  ///api 3.....all com....
  ///

  static Future<CompanyResponse?> AllcompanyApi() async {
    var url = "${baseUrl}App/CompanyList";
    try {
      http.Response response = await http.get(Uri.parse(url));
      print(response.body);
      if (response.statusCode == 200) {
        return CompanyResponse.fromJson(jsonDecode(response.body));
      } else {
        print('Request failed with status: ${response.statusCode}');
        return null;
      }
    } catch (error) {
      print('Error fetching companies: $error');
      return null;
    }
  }

  ///api 3.....all testimonial.........

  static AllTestimonialApi() async {
    var url = "${baseUrl}Admin/getAllTestimonial";
    try {
      http.Response r = await http.get(Uri.parse(url));
      print(r.body.toString());
      if (r.statusCode == 200) {
        var GettestimonialModel = allTestimonialModelFromJson(r.body);
        return GettestimonialModel;
      }
      print(url);
      print(r.body);
      print(r.statusCode);
    } catch (error) {
      return;
    }
  }


  ///6.job apply successfully..........post...apis...
  static Future<http.Response> ApplyJobAPi(String JobId) async {
    userId = prefs.read("Id").toString();
    print('www:${userId}');
    var url = "${baseUrl}App/Applyjob";
    var body = jsonEncode({
      "JobId": JobId,
      "userID": userId,
    });

    print("jobapply");
    print(body);

    http.Response r = await http.post(
      Uri.parse(url),
      body: body,
      headers: {
        "Content-Type": "application/json",
      },
    );
    print('okapplyjob');
    print(r.body);

    if (r.statusCode == 200) {
      Get.snackbar(
        'Success',
        r.body,
        backgroundColor:
        Colors.green.shade300, // Set the background color to green
        snackPosition: SnackPosition.TOP, // Set the position of the snackbar
        duration: Duration(
            seconds: 2), // Set the duration of the snackbar to 2 seconds
      );
      // Navigate to HomePage
      //Get.to(() => Home());

      return r;
    } else if (r.statusCode == 401) {
      Get.snackbar(
        'Message',
        r.body,
        backgroundColor: Colors.red, // Set the background color to green
        snackPosition: SnackPosition.TOP, // Set the position of the snackbar
        duration: Duration(
            seconds: 2), // Set the duration of the snackbar to 2 seconds
      );
    } else {
      Get.snackbar(
        'Message',
        r.body,
        backgroundColor: Colors.grey, // Set the background color to green
        snackPosition: SnackPosition.TOP, // Set the position of the snackbar
        duration: Duration(
            seconds: 2), // Set the duration of the snackbar to 2 seconds
      );
    }
    return r;
  }

  ///6.job save successfully..........post...apis...
  static Future<http.Response> SaveJobAPi(String JobId) async {
    userId = prefs.read("Id").toString();
    print('www:${userId}');
    var url = "${baseUrl}App/AddBookmark";
    var body = jsonEncode({
      "JobId": JobId,
      "userID": userId,
    });

    print("jobsave");
    print(body);

    http.Response r = await http.post(
      Uri.parse(url),
      body: body,
      headers: {
        "Content-Type": "application/json",
      },
    );
    print('okapplyjob');
    print(r.body);

    if (r.statusCode == 200) {
      Get.snackbar(
        'Success',
        r.body,
        //"Job Saved Successfully",
        backgroundColor:
        Colors.green.shade300, // Set the background color to green
        snackPosition: SnackPosition.TOP, // Set the position of the snackbar
        duration: Duration(
            seconds: 2), // Set the duration of the snackbar to 2 seconds
      );
      // Navigate to HomePage
      /// Get.to(() => Home());

      return r;
    } else if (r.statusCode == 401) {
      Get.snackbar(
        'Message',
        r.body,
        backgroundColor: Colors.red, // Set the background color to green
        snackPosition: SnackPosition.TOP, // Set the position of the snackbar
        duration: Duration(
            seconds: 2), // Set the duration of the snackbar to 2 seconds
      );
    } else {
      Get.snackbar(
        'Message',
        r.body,
        backgroundColor: Colors.grey, // Set the background color to green
        snackPosition: SnackPosition.TOP, // Set the position of the snackbar
        duration: Duration(
            seconds: 2), // Set the duration of the snackbar to 2 seconds
      );
    }

    return r;
  }

  ///api 7.....all  saved jobs....
  static AllSavedJobsApi() async {
    userId = prefs.read("Id").toString();
    print('wwwsaved:${userId}');
    var url = "${baseUrl}App/GetBookmarks?userId=$userId";
    try {
      http.Response r = await http.get(Uri.parse(url));
      print(r.body.toString());
      if (r.statusCode == 200) {
        var GetJobSavedListModel = allJobsSavedApiFromJson(r.body);
        return GetJobSavedListModel;
      }
      print(url);
      print(r.body);
      print(r.statusCode);
    } catch (error) {
      return;
    }
  }

  ///api 8....company_detail by com_id....
  static CompanyDetailByIdApi(int? id) async {
    userId = prefs.read("Id").toString();
    print('wwwsaved:${userId}');
    //https://api.hirejobindia.com/api/App/GetCompanyById?CompanyId=2
    var url = "${baseUrl}App/GetCompanyById?CompanyId=$id";
    print('urlkkkk:${url}');

    try {
      http.Response r = await http.get(Uri.parse(url));
      print(r.body.toString());
      if (r.statusCode == 200) {
        var CompanyDetailByCompanyIdModel =
        companyDetailByCompanyIdModelFromJson(r.body);
        return CompanyDetailByCompanyIdModel;
      }
      print(url);
      print(r.body);
      print(r.statusCode);
    } catch (error) {
      return;
    }
  }

  ///todo: job on cat id........13 jun 2024...
  static AllJobsbycatIDApi(num? id) async {
    userId = prefs.read("Id").toString();
    print('wwwsaved:${userId}');
    var url = "${baseUrl}Admin/GetCategorybyID?CategoryID=$id";
    // "App/GetBookmarks?userId=$userId";
    //Admin/GetCategorybyID?CategoryID=4
    print("okosds${url}");
    try {
      http.Response r = await http.get(Uri.parse(url));
      print(r.body.toString());
      if (r.statusCode == 200) {
        var AllJobsbyCatIdModel = allJobsbyCatIdModelFromJson(r.body);
        return AllJobsbyCatIdModel;
      }
      print(url);
      print(r.body);
      print(r.statusCode);
    } catch (error) {
      return;
    }
  }

  ///api 8.....all  saved jobs....
  static AllAppliedJobsApi() async {
    userId = prefs.read("Id").toString();
    print('wwwsaved:${userId}');
    var url = "${baseUrl}App/GetJobapplyList?userId=$userId";
    try {
      http.Response r = await http.get(Uri.parse(url));
      print(r.body.toString());
      if (r.statusCode == 200) {
        var GetJobAppliedListModel = allJobsAppliedApiFromJson(r.body);
        return GetJobAppliedListModel;
      }
      print(url);
      print(r.body);
      print(r.statusCode);
    } catch (error) {
      return;
    }
  }

  ///api 9.....all  related  jobs....
  static RelatedJobsbyJobIdApi(String? jobTitleid) async {
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // var JobTitleid1 = preferences.getString("JobTitleid1");
    // print("JobTitleid1: ${JobTitleid1}");

    //JobTitleId
    //userId = prefs.read("Id").toString();
    //print('wwwsaved:${userId}');
    var url = "${baseUrl}App/RelatedJobList?jobtitleid=$jobTitleid";

    print("relatedjobn");

    print(url);

    //  var url =
    //"http://api.hirejobindia.com/api/App/RelatedJobList?jobtitleid=$JobTitleId";
    //"${baseUrl}RelatedJobList?jobtitleid=11";
    try {
      http.Response r = await http.get(Uri.parse(url));
      print(r.body.toString());
      if (r.statusCode == 200) {
        var RelatedJobByJobIdModel = relatedJobByJobIdModelFromJson(r.body);
        return RelatedJobByJobIdModel;
      }
      print(url);
      print(r.body);
      print(r.statusCode);
    } catch (error) {
      return;
    }
  }


  static String apiUrl2 = "${baseUrl}Login/createProfile";

  static Future<List<StateModelss>> getSatesApi() async {
    var url = "https://api.ndtechland.com/api/EmployeeApi/Getstate";
    try {
      http.Response r = await http.get(Uri.parse(url));
      print(r.body.toString());
      if (r.statusCode == 200) {
        var statesData = stateModelFromJson(r.body);
        return statesData.data;
      } else {
        return [];
      }
    } catch (error) {
      return [];
    }
  }

  static Future<List<StateModelss>> getSatesApi1() async {
    var url = "${baseUrl}EmployeeApi/Getstate";
    try {
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        if (jsonResponse['data'] != null) {
          // Parsing the list of states
          return (jsonResponse['data'] as List)
              .map((item) => StateModelss.fromJson(item))
              .toList();
        }
      }
      return [];
    } catch (error) {
      print('Error fetching states: $error');
      return [];
    }
  }


///todo: city by stste id...
  static Future<List<CityModell>> getCitiesApi(int stateID) async {
    var url = "https://api.ndtechland.com/api/EmployeeApi/getcity?stateid=$stateID";
    try {
      http.Response r = await http.get(Uri.parse(url));
      print(r.body.toString());
      if (r.statusCode == 200) {
        var citiesData = cityModelFromJson(r.body);
        print("citiesData:${citiesData.data}");
        return citiesData.data;
      } else {
        return [];
      }
    } catch (error) {
      return [];
    }
  }

  ///todo:JobdetailByjobIdApi Api
  static JobdetailByjobIdApi(String? jobListId) async {
    var prefs = GetStorage();
    userId = prefs.read("Id").toString();
    print('wwwuseridEE:${userId}');
    //https://api.hirejobindia.com/api/App/GetProfile?userId=2
    var url = '${baseUrl}Admin/GetCurrent_OpeningByID?id=$jobListId';
    //'App/GetProfile?userId=$userId';
    try {
      http.Response r = await http.get(Uri.parse(url));
      if (r.statusCode == 200) {
        print("url");
        print(url);
        JobdetailbyjobIdModel? getjobdetailssmodel =
        jobdetailbyjobIdModelFromJson(r.body);
        print("jobdetail: ${getjobdetailssmodel.response!.id}");
        return getjobdetailssmodel;
      }
    } catch (error) {
      print('JobdetailByjobIderor: $error');
    }
  }

  ///todo:EmployeeLoginApi Api
  static Future<http.Response> EmployeeLoginApi(String employee_ID,
      String password) async {
    var url = "https://api.ndtechland.com/api/Account/Login";
    var body2 = jsonEncode({
      "Employee_ID": employee_ID,
      "Password": password,
    });

    print("loginnnnemployee");
    print("login body:${body2}");

    http.Response r = await http.post(
      Uri.parse(url),
      body: body2,
      headers: {
        "Content-Type": "application/json",
      },
    );

    print(r.body);

    if (r.statusCode == 200) {
      var responseData = json.decode(r.body);
      var employeeId = responseData['response']['data']['userid'];
      var token = responseData['token'];
      var refreshToken = responseData['refreshToken'];
      //token
      // Save employee ID and token
      final storage = GetStorage();
      storage.write("userid", employeeId);
      storage.write("token", token);
      storage.write("refreshToken", refreshToken);

      print('Saved employeeId: $employeeId');
      print('Saved token: $token');
      print('Saved refreshToken: $refreshToken');

      // Save user ID (assuming 'Id' is part of the response JSON)
      prefs.write("userid", employeeId);
      print('Saved employeeId: $employeeId');

      ///token...
      prefs.write("token".toString(), json.decode(r.body)['token']);
      token = prefs.read("token").toString();
      print("tokennnn");
      print(token);
      // Navigate to HomePage
      //Get.to(() => Home());
      await locationController.fetchCurrentLocation(
        // " C 53, 1st Floor, C Block, Sector 2, Noida, Uttar Pradesh 201301"
      );
      await locationController.fetchCompanyLocationApi();
      await locationController.getCoordinatesFromAddress();
      await locationController.startSendingLocation();
      return r;
    } else if (r.statusCode == 401) {
      Get.snackbar('Message', 'Invalid UserName or Password',backgroundColor: Colors.red,colorText: Colors.white);
    } else if (r.statusCode == 400) {
      Get.snackbar('Message', 'Invalid UserName or Password',backgroundColor: Colors.red,colorText: Colors.white);
    } else {
      Get.snackbar('Error', 'Error: ${r.body}',backgroundColor: Colors.red,colorText: Colors.white);
    }

    return r;
  }

  ///todo:RefreshToken Api
  static Future<http.Response> RefreshToken() async {
    var prefs = GetStorage();

    // Read saved user id and token
    var refreshToken = prefs.read("refreshToken").toString();
    print('refreshToken read: $refreshToken');
    var url = "${baseUrl}Account/RefreshToken";
    var body2 = jsonEncode({
      "refreshToken": refreshToken,
    });
    print("loginnnnemployee");
    print("login body:${body2}");

    http.Response r = await http.post(
      Uri.parse(url),
      body: body2,
      headers: {
        "Content-Type": "application/json",
      },
    );

    print(r.body);
    if (r.statusCode == 200) {
      var responseData = json.decode(r.body);
      var accessToken = responseData['token'];
      final storage = GetStorage();
      storage.write("token", accessToken);
      print('Saveddd accessToken: $accessToken');
      print('Saveddd accessToken: $responseData');

      // Navigate to HomePage
      //Get.to(() => Home());

      return r;
    } else if (r.statusCode == 401) {
      Get.snackbar('Message', 'Unauthorized: ${r.body}');
    } else {
      Get.snackbar('Error', 'Error: ${r.body}');
    }

    return r;

  }

  ///todo:PriofilePersonalEmployeeApi Api
  static PriofilePersonalEmployeeApi() async {
    var prefs = GetStorage();

    // Read saved user id and token
    userId = prefs.read("userid").toString();
    print('wwwuseridEE: $userId');

    token = prefs.read("token").toString();
    print('tokenProfile: $token');
    var url = 'https://api.ndtechland.com/api/EmployeeApi/GetEmployeeBasicInfo';
    try {
      // Add the token to the headers
      Map<String, String> headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      };

      http.Response r = await http.get(Uri.parse(url), headers: headers);
      if (r.statusCode == 200) {
        print("url");
        print(url);
        GetProfileEmployeePersonalModel? geetprofilepersonalmodel =
        getProfileEmployeePersonalModelFromJson(r.body);
        print(
            "profileinfo: ${geetprofilepersonalmodel.data!
                .personalEmailAddress}");
        print(
            "profileImage: ${geetprofilepersonalmodel.data!.empProfile}");
        return geetprofilepersonalmodel;
      } else {
        print('Failed to load profile information');
      }
    } catch (error) {
      print('PriofileEmployeeApieror: $error');
    }
  }

  ///todo:PriofileBasicEmployeeApi Api
  static PriofileBasicEmployeeApi() async {
    var prefs = GetStorage();

    // Read saved user id and token
    userId = prefs.read("Id").toString();
    print('wwwuseridEE: $userId');

    token = prefs.read("token").toString();
    print('token: $token');
    var url = '${baseUrl}EmployeeApi/GetEmployeeBasicInfo';
    try {
      // Add the token to the headers
      Map<String, String> headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      };

      http.Response r = await http.get(Uri.parse(url), headers: headers);
      if (r.statusCode == 200) {
        print("url");
        print(url);
        BasicInformationModel? geetprofilepersonalmodel =
        basicInformationModelFromJson(r.body);
        print("profileinfo: ${geetprofilepersonalmodel.data!.employeeId}");
        return geetprofilepersonalmodel;
      } else {
        print('Failed to load profile information');
      }
    } catch (error) {
      print('GetEmployeeBasicInfo: $error');
    }
  }

  ///todo:PriofileBankDetailEmployeeApi Api
  static PriofileBankDetailEmployeeApi() async {
    var prefs = GetStorage();

    // Read saved user id and token
    userId = prefs.read("Id").toString();
    print('wwwuseridEE: $userId');

    token = prefs.read("token").toString();
    print('token: $token');
    var url = 'https://api.ndtechland.com/api/EmployeeApi/GetBankdetail';
    try {
      // Add the token to the headers
      Map<String, String> headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      };

      http.Response r = await http.get(Uri.parse(url), headers: headers);
      if (r.statusCode == 200) {
        print("url");
        print(url);
        BankDetailInformationModel? geetprofilbankmodel =
        bankDetailInformationModelFromJson(r.body);
        print("profileinfobnk: ${geetprofilbankmodel.data!.accountHolderName}");
        return geetprofilbankmodel;
      } else {
        print('Failed to load profile information');
      }
    } catch (error) {
      print('bankedetaileror: $error');
    }
  }

  ///todo:OfferAppointmentEmployeeApi Api
  static OfferAppointmentEmployeeApi() async {
    var prefs = GetStorage();

    // Read saved user id and token
    userId = prefs.read("Id").toString();
    print('wwwuseridEE: $userId');

    token = prefs.read("token").toString();
    print('token: $token');
    var url = '${baseUrl}EmployeeApi/GetOfferAndAppointmentLeter';
    try {
      // Add the token to the headers
      Map<String, String> headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      };

      http.Response r = await http.get(Uri.parse(url), headers: headers);
      if (r.statusCode == 200) {
        print("url");
        print(url);
        GetOfferAppointmentModel? getapptoffermodel =
        getOfferAppointmentModelFromJson(r.body);
        print("profileinfobnk: ${getapptoffermodel.data!.offerletter}");
        return getapptoffermodel;
      } else {
        print('Failed to load profile information');
      }
    } catch (error) {
      print('offerandAptError: $error');
    }
  }

  ///todo:getSalarySlips Api
  static Future<AllsalaryslipModells?> getSalarySlips() async {
    String userId = GetStorage().read("userId").toString();
    String token = GetStorage().read("token").toString();
    var url = "https://api.ndtechland.com/api/EmployeeApi/GetAllEmployeesalaryslip";

    try {
      Map<String, String> headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      };

      http.Response response = await http.get(Uri.parse(url), headers: headers);
      print(response.body);

      if (response.statusCode == 200) {
        var allSalarySlipModels = allsalaryslipModellsFromJson(response.body);
        return allSalarySlipModels;
      } else {
        print(
            'Failed to load salary slips. Status code: ${response.statusCode}');
        //Get.snackbar('Error', 'Failed to load salary slips');
        return null;
      }
    } catch (error) {
      print('Error: $error');
      Get.snackbar('Error', 'An error occurred while fetching salary slips');
      return null;
    }
  }

  ///todo:getDashboardApi Api
  static getDashboardApi() async {
    var prefs = GetStorage();

    // Read saved user id and token
    userId = prefs.read("userid").toString();
    print('wwwuseridEE: $userId');
    String token = GetStorage().read("token").toString();

    // token = prefs.read("token").toString();
    print('tokendash: $token');
    var url = 'https://api.ndtechland.com/api/EmployeeApi/EmployeeDashboard';
    try {
      // Add the token to the headers
      Map<String, String> headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      };

      http.Response r = await http.get(Uri.parse(url), headers: headers);
      print("dasBody:${r.body}");
      if (r.statusCode == 200) {
        print("url");
        print(url);
        DashbordModel? geetdashbord = dashbordModelFromJson(r.body);
        print("totalAttendance: ${geetdashbord.data?.totalAttendance!}");
        return geetdashbord;
      } else {
        print('Failed to load dashboard');
      }
    } catch (error) {
      print('dashboardError: $error');
    }
  }

  ///todo:SupportUserEmployeeApi Api
  static SupportUserEmployeeApi() async {
    var prefs = GetStorage();

    // Read saved user id and token
    userId = prefs.read("Id").toString();
    print('wwwuseridEE: $userId');

    token = prefs.read("token").toString();
    print('token: $token');
    var url = '${baseUrl}App/ContactDetail';
    try {
      // Add the token to the headers
      Map<String, String> headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      };

      http.Response r = await http.get(Uri.parse(url));
      if (r.statusCode == 200) {
        print("url");
        print(url);
        //SupportModel supportModelFromJson
        SupportModel? getsupportmodel = supportModelFromJson(r.body);
        print("profilesupport: ${getsupportmodel.response!.id}");
        return getsupportmodel;
      } else {
        print('Failed to load profile information');
      }
    } catch (error) {
      print('SupportUserEmployeeeror: $error');
    }
  }

  ///todo: leave...apply..dropdown.catagary..employee
  static Future<List<GetLeaveTypeList>> getDropdownLeaveApi() async {
    String userId = GetStorage().read("userId").toString();
    String token = GetStorage().read("token").toString();
    var url = "${baseUrl}LeaveStructure/GetLeaveType";

    try {
      Map<String, String> headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      };

      http.Response response = await http.get(Uri.parse(url), headers: headers);
      print(response.body);

      if (response.statusCode == 200) {
        var leaveDropdownData = leaveDropdownModelsFromJson(response.body);
        return leaveDropdownData.data!.getLeaveTypeList!;
      } else {
        print(
            'Failed to load dropdown category. Status code: ${response
                .statusCode}');
        return [];
      }
    } catch (error) {
      print('Error: $error');
      Get.snackbar('Error', 'An error occurred while fetching category');
      return [];
    }
  }

  ///todo: leave...apply..dropdown..type.employee
  static Future<List<GetLeaveList>> getDropdownLeaveTypeApi() async {
    String userId = GetStorage().read("userId").toString();
    String token = GetStorage().read("token").toString();
    var url = "${baseUrl}LeaveStructure/GetLeaveType";

    try {
      Map<String, String> headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      };

      http.Response response = await http.get(Uri.parse(url), headers: headers);
      print(response.body);

      if (response.statusCode == 200) {
        var leaveDropdownData = leaveDropdownModelsFromJson(response.body);
        return leaveDropdownData.data!.getLeaveList!;
      } else {
        print(
            'Failed to load dropdown category. Status code: ${response
                .statusCode}');
        return [];
      }
    } catch (error) {
      print('Error: $error');
      Get.snackbar('Error', 'An error occurred while fetching category');
      return [];
    }
  }

///todo:ApplyLeave Api
  static Future<http.Response> ApplyLeave(Map<String, String> formData) async {
    var uri = Uri.parse("${baseUrl}LeaveStructure/EmployeeApplyLeave");
    var request = http.MultipartRequest('POST', uri);

    // Print form data
    print('Form Data:');
    formData.forEach((key, value) {
      print('$key: $value');
      request.fields[key] = value;
    });

    // Add form fields
    formData.forEach((key, value) {
      request.fields[key] = value;
    });

    ///token
    String token = GetStorage().read("token").toString();

    // Add headers
    request.headers['Authorization'] = 'Bearer $token';

    // Send the request
    var response = await request.send();

    // Parse the response
    var httpResponse = await http.Response.fromStream(response);
    // Print the entire response body
    print('Response body: ${httpResponse.body}');

    if (httpResponse.statusCode == 200) {
      print('Response body200: ${httpResponse.body}');

      Fluttertoast.showToast(
        msg: "Apply Leave successfully!",
        backgroundColor: Colors.green,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
      );
    } else if (httpResponse.statusCode == 501){
      Fluttertoast.showToast(
        msg: "Leave Already Applied",
        backgroundColor: Colors.green,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
      );
    }
    else {
      print('Failed to apply Leave. Status code: ${httpResponse.statusCode}');

      Fluttertoast.showToast(
        msg: "Failed to apply Leave. Status code: ${httpResponse.statusCode}",
        backgroundColor: Colors.red,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
    }

    return httpResponse;
  }


///todo:updatePersonal1 Api
  static Future<http.Response> updatePersonal1(Map<String, String> formData,
      List<Uint8List>? aadharFileContent,
      String? Aadharbase64,
      Uint8List? panFileContent,
      String? Panbase64,
      Uint8List? profileFileContent,
      String? Profilebase64,) async {
    var uri = Uri.parse(
        "https://api.ndtechland.com/api/EmployeeApi/EmployeePersonalDetail");
    var request = http.MultipartRequest('POST', uri);

    // Add form fields
    formData.forEach((key, value) {
      request.fields[key] = value;
      print('Field: $key, Value: $value'); // Print each form field
    });
    if (Aadharbase64 != null) {
      request.fields['AadharImage'] = Aadharbase64;
    }
    if (Panbase64 != null) {
      request.fields['PanbaseImage'] = Panbase64;
    }
    if (Profilebase64 != null) {
      request.fields['Empprofile'] = Profilebase64;
    }
    // Add Aadharbase64 and Panbase64 fields to the form data
    // request.fields['AadharImage'] = Aadharbase64!;
    // request.fields['PanbaseImage'] = Panbase64!;
    // request.fields['Empprofile'] = Profilebase64!;

    // Helper function to determine the MediaType based on the file extension
    MediaType getMediaType(String filename) {
      String ext = filename
          .split('.')
          .last
          .toLowerCase();
      switch (ext) {
        case 'jpg':
        case 'jpeg':
          return MediaType('image', 'jpeg');
        case 'png':
          return MediaType('image', 'png');
        case 'pdf':
          return MediaType('application', 'pdf');
        default:
          throw Exception('Unsupported file type');
      }
    }

    MediaType getMediaType2(String filename) {
      String ext = filename
          .split('.')
          .last
          .toLowerCase();
      switch (ext) {
        case 'jpg':
        case 'jpeg':
          return MediaType('image', 'jpeg');
        case 'png':
          return MediaType('image', 'png');
        case 'pdf':
          return MediaType('application', 'pdf');
        default:
          throw Exception('Unsupported file type');
      }
    }

    // Add Aadhar image files
    for (int i = 0; i < aadharFileContent!.length; i++) {
      request.files.add(http.MultipartFile.fromBytes(
          'AadharImage', // Use array notation if multiple files are allowed
          aadharFileContent[i],
          filename:
          Aadharbase64,
          // Use a generic filename with index for each Aadhar file
          contentType: getMediaType(Aadharbase64!)));
    }

    // Add PAN image file
    request.files.add(
        http.MultipartFile.fromBytes('PanbaseImage', panFileContent!,
            filename: Panbase64,
            // Use the file path as the filename for PAN
            contentType: getMediaType2(Panbase64!)

          //contentType:
          //MediaType('application', 'pdf'), // Use MediaType from http_parser
        ));
    request.files.add(
        http.MultipartFile.fromBytes('Empprofile', profileFileContent!,
            filename: Profilebase64,
            // Use the file path as the filename for PAN
            contentType: getMediaType2(Panbase64)

          //contentType:
          //MediaType('application', 'pdf'), // Use MediaType from http_parser
        ));

    // Add headers
    String token = GetStorage().read("token").toString();
    request.headers['Authorization'] = 'Bearer $token';

    // Send the request
    var response = await request.send();

    // Handle the response
    var httpResponse = await http.Response.fromStream(response);
    print('Response body: ${httpResponse.body}');

    if (httpResponse.statusCode == 200) {
      // Success
      var jsonResponse = jsonDecode(httpResponse.body);
      //var userId = jsonResponse['loginProfile']['id'];
      print("updateeProfile:${jsonResponse}");
      print("updateeProfile:${httpResponse.statusCode}");
      // Show success toast
      Fluttertoast.showToast(
        msg: "Profile update successfully!",
        backgroundColor: Colors.green,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
      );
    } else {
      // Error
      print(
          'Failed to update profile. Status code: ${httpResponse.statusCode}');
      Fluttertoast.showToast(
        msg:
        "Failed to update profile. Status code: ${httpResponse.statusCode}",
        backgroundColor: Colors.red,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
    }
    return httpResponse;
  }

 // final String apiUrl = "https://api.ndtechland.com/api/EmployeeApi/EmployeePersonalDetail";
//todayyyy correct for profile and pan
// static Future<http.Response> updatePersonal({
//     required Map<String, String> formData,
//     List<Uint8List>? aadharFileContent,
//   List<String>? Aadharbase64, // Update to handle multiple Aadhaar filenames
//   Uint8List? panFileContent,
//     String? Panbase64,
//     Uint8List? profileFileContent,
//     String? Profilebase64,
//   }) async {
//     var uri = Uri.parse("https://api.ndtechland.com/api/EmployeeApi/EmployeePersonalDetail");
//     var request = http.MultipartRequest('POST', uri);
//
//     // Add form fields
//     request.fields.addAll(formData);
//
//     // Helper function to determine the MediaType based on the file extension
//     MediaType getMediaType(String filename) {
//       String ext = filename.split('.').last.toLowerCase();
//       switch (ext) {
//         case 'jpg': return MediaType('image', 'jpg');
//         case 'jpeg':
//           return MediaType('image', 'jpeg');
//         case 'png':
//           return MediaType('image', 'png');
//         case 'pdf':
//           return MediaType('application', 'pdf');
//         default:
//           throw Exception('Unsupported file type');
//       }
//     }
//
//     // Add Aadhaar images if available
//     if (aadharFileContent != null && Aadharbase64 != null) {
//       for (int i = 0; i < aadharFileContent.length; i++) {
//         request.files.add(http.MultipartFile.fromBytes(
//           'AadharImage', // Ensure this matches the API requirement
//           aadharFileContent[i],
//           filename: Aadharbase64[i],
//           contentType: getMediaType(Aadharbase64[i]),
//         ));
//       }
//     }
//
//     // Add PAN image if available
//     if (panFileContent != null && Panbase64 != null) {
//       request.files.add(http.MultipartFile.fromBytes(
//         'PanbaseImage', // Ensure this matches the API requirement
//         panFileContent,
//         filename: Panbase64,
//         contentType: getMediaType(Panbase64),
//       ));
//     }
//
//     // Add profile image if available
//     if (profileFileContent != null && Profilebase64 != null) {
//       request.files.add(http.MultipartFile.fromBytes(
//         'Empprofile', // Ensure this matches the API requirement
//         profileFileContent,
//         filename: Profilebase64,
//         contentType: getMediaType(Profilebase64),
//       ));
//     }
//
//     // Get token from GetStorage
//     String token = GetStorage().read("token").toString();
//     request.headers['Authorization'] = 'Bearer $token';
//
//     // Send the request
//     var response = await request.send();
//
//     // Parse the response
//     var httpResponse = await http.Response.fromStream(response);
//
//     // Handle success or failure
//     if (httpResponse.statusCode == 200) {
//       print("Profile updated successfully: ${httpResponse.body}");
//       Fluttertoast.showToast(
//         msg: "Profile updated successfully!",
//         backgroundColor: Colors.green,
//         textColor: Colors.white,
//         toastLength: Toast.LENGTH_LONG,
//         gravity: ToastGravity.CENTER,
//       );
//     } else {
//       Fluttertoast.showToast(
//         msg: "Failed to update profile. Status code: ${httpResponse.statusCode}",
//         backgroundColor: Colors.red,
//         textColor: Colors.white,
//         toastLength: Toast.LENGTH_LONG,
//         gravity: ToastGravity.BOTTOM,
//       );
//       print("Response body: ${httpResponse.body}");
//     }
//
//     return httpResponse;
//   }
  ///todo:updatePersonal Api
  static Future<http.Response> updatePersonal({
    required Map<String, String> formData,
    Uint8List? aadharFileContent1,
    String? Aadhar1base64,
    Uint8List? aadharFileContent2,
    String? Aadhar2base64, // Changed to List to handle multiple images
    Uint8List? panFileContent,
    String? Panbase64,
    Uint8List? profileFileContent,
    String? Profilebase64,
  }) async {
    var uri = Uri.parse("https://api.ndtechland.com/api/EmployeeApi/EmployeePersonalDetail");
    var request = http.MultipartRequest('POST', uri);

    // Add form fields
    request.fields.addAll(formData);
    formData.forEach((key, value) {
      request.fields[key] = value;
      print('Field: $key, Value: $value'); // Print each form field
    });
    // Helper function to determine the MediaType based on the file extension
    MediaType getMediaType(String filename) {
      String ext = filename.split('.').last.toLowerCase();
      switch (ext) {
        case 'jpg': return MediaType('image', 'jpeg');
        case 'jpeg': return MediaType('image', 'jpeg');
        case 'png': return MediaType('image', 'png');
        case 'pdf': return MediaType('application', 'pdf');
        default: throw Exception('Unsupported file type: $ext');
      }
    }

    /// Add Aadhaar images if available
    // if (aadharFileContent != null && Aadharbase64 != null) {
    //   for (int i = 0; i < aadharFileContent.length; i++) {
    //     request.files.add(http.MultipartFile.fromBytes(
    //       'AadharImage', // Ensure this matches the API requirement
    //       aadharFileContent[i],
    //       filename: Aadharbase64[i],
    //       contentType: getMediaType(Aadharbase64[i]),
    //     ));
    //   }
    // }
    if (aadharFileContent1 != null && Aadhar1base64 != null) {
      request.files.add(http.MultipartFile.fromBytes(
        'Aadhar1', // Ensure this matches the API requirement
        aadharFileContent1,
        filename: Aadhar1base64,
        contentType: getMediaType(Aadhar1base64),
      ));
    } if (aadharFileContent2 != null && Aadhar2base64 != null) {
      request.files.add(http.MultipartFile.fromBytes(
        'Aadhar2', // Ensure this matches the API requirement
        aadharFileContent2,
        filename: Aadhar2base64,
        contentType: getMediaType(Aadhar2base64),
      ));
    }
    // Add PAN image if available
    if (panFileContent != null && Panbase64 != null) {
      request.files.add(http.MultipartFile.fromBytes(
        'PanbaseImage', // Ensure this matches the API requirement
        panFileContent,
        filename: Panbase64,
        contentType: getMediaType(Panbase64),
      ));
    }

    // Add profile image if available
    if (profileFileContent != null && Profilebase64 != null) {
      request.files.add(http.MultipartFile.fromBytes(
        'Empprofile', // Ensure this matches the API requirement
        profileFileContent,
        filename: Profilebase64,
        contentType: getMediaType(Profilebase64),
      ));
    }

    // Add authorization token
    String token = GetStorage().read("token").toString();
    request.headers['Authorization'] = 'Bearer $token';

    var response = await request.send();
    var httpResponse = await http.Response.fromStream(response);

    // Handle response
    if (httpResponse.statusCode == 200) {
      print("Profile updated successfully: ${httpResponse.body}");
      Fluttertoast.showToast(
        msg: "Profile updated successfully!",
        backgroundColor: Colors.green,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
      );
    } else {
      Fluttertoast.showToast(
        msg: "Failed to update profile. Status code: ${httpResponse.statusCode}",
        backgroundColor: Colors.red,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
      print("Response body: ${httpResponse.body}");
    }

    return httpResponse;
  }

  ///todo:updatePersonal2 Api
  static Future<http.Response> updatePersonal2({
    required Map<String, String> formData,
    List<Uint8List>? aadharFileContent,
    String? Aadharbase64,
    Uint8List? panFileContent,
    String? Panbase64,
    Uint8List? profileFileContent,
    String? Profilebase64,
  }) async {
    var uri = Uri.parse("https://api.ndtechland.com/api/EmployeeApi/EmployeePersonalDetail");
    var request = http.MultipartRequest('POST', uri);

    // Add form fields
    formData.forEach((key, value) {
      request.fields[key] = value;
      print('Field: $key, Value: $value'); // Print each form field
    });
    String token = GetStorage().read("token").toString();
    request.headers['Authorization'] = 'Bearer $token';

    try {
      // Send the request
      var response = await request.send();

      // Handle the response
      var httpResponse = await http.Response.fromStream(response);
      if (httpResponse.statusCode == 200) {
        print("profileRes:${httpResponse.body}");
        // Success
        Fluttertoast.showToast(
          msg: "Profile updated successfully!",
          backgroundColor: Colors.green,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
        );
      } else {
        // Error
        Fluttertoast.showToast(
          msg: "Failed to update profile. Status code: ${httpResponse.statusCode}",
          backgroundColor: Colors.red,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
        );
      }
      return httpResponse;
    } catch (e) {
      // Handle exceptions
      Fluttertoast.showToast(
        msg: 'Network error. Please try again.',
        backgroundColor: Colors.red,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
      rethrow;
    }
  }

  ///todo:updateBankEmployeeApi Api
  static Future<http.Response> updateBankEmployeeApi(
      Map<String, String> formData,
      Uint8List? cvFileContent,
      String? Chequebase64,) async {
    var uri = Uri.parse(
        "https://api.ndtechland.com/api/EmployeeApi/EmployeeBankDetail");
    var request = http.MultipartRequest('POST', uri);

    // Add form fields
    formData.forEach((key, value) {
      request.fields[key] = value;
    });

    // Helper function to determine the MediaType based on the file extension
    MediaType getMediaType(String filename) {
      String ext = filename
          .split('.')
          .last
          .toLowerCase();
      switch (ext) {
        case 'jpg':
        case 'jpeg':
          return MediaType('image', 'jpeg');
        case 'png':
          return MediaType('image', 'png');
        case 'pdf':
          return MediaType('application', 'pdf');
        default:
          throw Exception('Unsupported file type');
      }
    }

    // Add file field
    request.files.add(http.MultipartFile.fromBytes(
        'Chequebase64', // The name of the file field
        cvFileContent!,
        filename: Chequebase64,
        // Use the file name from the parameter
        contentType: getMediaType(Chequebase64!)

      //contentType:
      //MediaType('application', 'pdf'), // Use MediaType from http_parser
    ));

    // Get token from GetStorage
    final storage = GetStorage();
    var token = storage.read('token');

    // Set token in headers
    request.headers['Authorization'] = 'Bearer $token';

    // Send the request
    var response = await request.send();

    // Parse the response
    var httpResponse = await http.Response.fromStream(response);

    // Print the response data
    print('Response status: ${httpResponse.statusCode}');

    if (httpResponse.statusCode == 200) {
      print('Response body: ${httpResponse.body}');

      // Show success toast
      Fluttertoast.showToast(
        msg: "Bank Updated successfullyyyy!",
        backgroundColor: Colors.green,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
      );
    } else {
      // Show error toast
      Fluttertoast.showToast(
        msg: "Failed to Update Bank. Status code: ${httpResponse.statusCode}",
        backgroundColor: Colors.red,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
    }

    return httpResponse;
  }

  ///todo: update profile picture....employee..
  static String apiUrl9 = "${baseUrl}EmployeeApi/EmpUpdateprofilepicture";

  ///todo:forgotPassword Api sonali
  static Future<http.Response?> ForgotPasswordApi1(BuildContext context,String email) async {
    var prefs = GetStorage();
    String employeeId = prefs.read("Id").toString();
   // String token = GetStorage().read("token").toString();

    print('forgotUserId:$employeeId');
    var urll = "${baseUrl}EmployeeApi/EmployeeForgotPassword";
    var body = jsonEncode({
      'Email':email
    });

    print("forgot password body:${body}");
    try{
      http.Response response = await http.post(
        Uri.parse(urll),
        body: body,
        headers: {
         // 'Authorization': 'Bearer $token',
          "Content-Type": "application/json",
        },
      ).timeout(const Duration(seconds: 15), onTimeout: () {
        throw Exception('Request timed out');
      });
      print(response.body);
      print("forgotPass token: $token");
      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        print("forgot pass 200");
        print("forgotPass:${responseData?.statusCode}");
        print("forgotPass:${responseData?.body}");
        // Show loading dialog
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        );
        // Simulate a delay for async operations
        await Future.delayed(Duration(seconds: 1));
        // Clear shared preferences
        SharedPreferences.getInstance().then((prefs) => prefs.clear());
        // Hide loading dialog
        Get.back();
        // Navigate to Login Page
        Get.offAll(() => Login());
        // Show success toast
        Fluttertoast.showToast(
          msg: "Password changed successfully!",
          backgroundColor: Colors.green,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
        );
      } else if (response.statusCode == 401) {
        print("printtttttttttttttt");
        Fluttertoast.showToast(
          msg: "Unauthorized access. Status code: ${response.statusCode}",
          backgroundColor: Colors.red,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
        );
        Get.snackbar('Error', response.body);
      } else {
        Fluttertoast.showToast(
          msg: "Failed to change password. Status code: ${response.statusCode}",
          backgroundColor: Colors.red,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
        );
        Get.snackbar('Error', response.body);
      }
      return response;
    }
    catch(e){
      print('Network error: $e');
    Fluttertoast.showToast(
      msg: "Network error: $e",
      backgroundColor: Colors.red,
      textColor: Colors.white,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
    );
    }
    return null;
  }

  ///todo:ForgotPasswordApi Api
  static Future<http.Response> ForgotPasswordApi(String email) async {
  var prefs = GetStorage();
  String employeeId = prefs.read("Id").toString();
  // String token = GetStorage().read("token").toString();

  print('forgotUserId:$employeeId');
  var urll = "${baseUrl}EmployeeApi/EmployeeForgotPassword";
  var body = jsonEncode({
    'Email':email
  });

  http.Response r = await http.post(
    Uri.parse(urll),
    body: body,
    headers: {
      "Content-Type": "application/json",
    },
  );
  print("body: ${r.body}");
  if(r.statusCode==200){
    print("forgotbody: ${r.body}");
    print("forgotres: ${r.statusCode}");
    // Show loading dialog
    // showDialog(
    //   context: context,
    //   barrierDismissible: false,
    //   builder: (context) {
    //     return Center(
    //       child:
          CircularProgressIndicator();
    //     );
    //   },
    // );

    // Simulate a delay for async operations
    await Future.delayed(Duration(seconds: 1));

    // Clear shared preferences
    SharedPreferences.getInstance().then((prefs) => prefs.clear());

    // Hide loading dialog
    Get.back();

  Get.offAll(()=>Login());
  return r;
}  else if (r.statusCode == 401) {
    Get.snackbar('Message', r.body);
  } else {
    Get.snackbar('Error', r.body);
  }

  return r;
}

  ///todo:ChangePasswordEmployeeApi Api
  static Future<http.Response?> ChangePasswordEmployeeApi(BuildContext context,
      // Added context parameter
      String CurrentPassword,
      String NewPassword,
      String ConfirmPassword) async {
    var prefs = GetStorage();
    String token = GetStorage().read("token").toString();

    // Read saved userId
    String employeeId = prefs.read("Id").toString();
    print('wwwuseridEE:$employeeId');
    //employeeId

    var url = "${baseUrl}EmployeeApi/EmployeeChangePassword";
    var body = jsonEncode({
      // "userId": employeeId,
      "CurrentPassword": CurrentPassword,
      "NewPassword": NewPassword,
      "ConfirmPassword": ConfirmPassword,
    });

    print("changePass body:$body");
    print(body);

    try {
      http.Response r = await http.post(
        Uri.parse(url),
        body: body,
        headers: {
          'Authorization': 'Bearer $token',
          "Content-Type": "application/json",
        },
      ).timeout(const Duration(seconds: 10));

      print(r.body);

      if (r.statusCode == 200) {
        print("changePass :${r.body}");
        print("changePass :${r.statusCode}");

        var responseData = json.decode(r.body);
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        );

        // Simulate a delay for async operations
        await Future.delayed(Duration(seconds: 1));

        // Clear shared preferences
        SharedPreferences.getInstance().then((prefs) => prefs.clear());

        // Hide loading dialog
        Get.back();

        // Navigate to Login Page
        Get.offAll(() => Login());

        // Show success toast
        Fluttertoast.showToast(
          msg: "Password changed successfully!",
          backgroundColor: Colors.green,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
        );
      } else if (r.statusCode == 401) {
        Fluttertoast.showToast(
          msg: "Unauthorized access. Status code: ${r.statusCode}",
          backgroundColor: Colors.red,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
        );

        Get.snackbar('Error', r.body);
      } else {
        Fluttertoast.showToast(
          msg: "Failed to change password. Status code: ${r.statusCode}",
          backgroundColor: Colors.red,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
        );

        Get.snackbar('Error', r.body);
      }

      return r;
    } on TimeoutException catch (_) {
      Fluttertoast.showToast(
        msg: "Network connection slow or disconnected",
        backgroundColor: Colors.red,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );

      return null;
    } on SocketException catch (_) {
      Fluttertoast.showToast(
        msg:
        "Network error: Unable to resolve host. Please check your internet connection.",
        backgroundColor: Colors.red,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );

      return null;
    } catch (error) {
      print('Network error: $error');

      Fluttertoast.showToast(
        msg: "Network error: $error",
        backgroundColor: Colors.red,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );

      return null;
    }
  }

  ///todo:CompanyLocation Api
  static Future<CompanyLocationModel?> CompanyLocation() async {
    String token = GetStorage().read("token").toString();
    var companyUrl = "${baseUrl}EmployeeApi/GetCompanyLoction";
    try {
      Map<String, String> headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      };
      http.Response response = await http.get(Uri.parse(companyUrl), headers: headers);
      print(response.body);
      if(response.statusCode==200){
        var getCompanyLocation = companyLocationModelFromJson(response.body);
        return getCompanyLocation;
      } else {
        print('Failed to load company location. Status code: ${response.statusCode}');
        return null;
      }
    } catch(e){
      print('Error: $e');
      Get.snackbar('Error', 'An error occurred while fetching company location');
      return null;
    }
    // return null;
  }

  ///todo:check-in Api
  static Future<http.Response?> CheckInApiii
      (String CurrentLat,String Currentlong,
    //  int Userid
      ) async {
    var prefs = GetStorage();

    // Read saved user id and token
    userId = prefs.read("userid").toString();
    print('wwwuserid: $userId');

    String token = GetStorage().read("token").toString();
    var checkInUrl = "${baseUrl}EmployeeApi/EmployeeCheckIn";
    // String employeeId = prefs.read("userid").toString();
    print('useridddd:$userId');
    var body = jsonEncode({
      "CurrentLat": CurrentLat,
      "Currentlong": Currentlong,
      "Userid": userId,
    });
    print("checkin body:$body");
    try{
      http.Response r = await http.post(
        Uri.parse(checkInUrl),
        body: body,
        headers: {
          'Authorization': 'Bearer $token',
          "Content-Type": "application/json",
        },
      );
      print(r.body);
      if(r.statusCode ==200){
        print("checkIn Body :${r.body}");
        print("checkIn :${r.statusCode}");
        var responseData = json.decode(r.body);
        await Future.delayed(Duration(seconds: 2));
        //await EmpAttendancedatail(DateTime.now());
        await atteControler.AttendanceDetailApi(DateTime.now());
        Get.offAll(() => Attendance(id: "13"));

        // Show success toast
        Fluttertoast.showToast(
          msg: "Check In Successfully!",
          backgroundColor: Colors.green,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
        );
      }else if (r.statusCode == 401) {
        Fluttertoast.showToast(
          msg: "Unauthorized access. Status code: ${r.statusCode}",
          backgroundColor: Colors.red,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
        );
        print('CheckInApi elseeeIf');

        Get.snackbar('Error', r.body);
      } else if(r.statusCode ==409){
        Get.offAll(() => Attendance(id: "13"));
        await atteControler.AttendanceDetailApi(DateTime.now());
        // Show success toast
        Fluttertoast.showToast(
          msg: "You are already Check-In",
          backgroundColor: Colors.green,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
        );
      } else {
        Fluttertoast.showToast(
          msg: "Failed to check-in. Status code: ${r.statusCode}",
          backgroundColor: Colors.red,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
        );
        print('CheckInApi elseee');
        Get.snackbar('Error', r.body);
      }
      return r;
    } catch(error) { print('Network error: $error');

    Fluttertoast.showToast(
      msg: "Network error: $error",
      backgroundColor: Colors.red,
      textColor: Colors.white,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
    );

    return null;}
  }


  ///todo:sendLatLang Api
  static Future<http.Response?> sendLatLang
      (String CurrentLat,String Currentlong,
    //  int Userid
      ) async {
    var prefs = GetStorage();

    // Read saved user id and token
    userId = prefs.read("userid").toString();
    print('wwwuseridSend: $userId');

    String token = GetStorage().read("token").toString();
    var checkInUrl = "${baseUrl}EmployeeApi/EmployeeCheckIn";
    // String employeeId = prefs.read("userid").toString();
    print('useridddd:$userId');
    var body = jsonEncode({
      "CurrentLat": CurrentLat,
      "Currentlong": Currentlong,
      "Userid": userId,
    });
    print("sendLatLang body:$body");
    try{
      http.Response r = await http.post(
        Uri.parse(checkInUrl),
        body: body,
        headers: {
          'Authorization': 'Bearer $token',
          "Content-Type": "application/json",
        },
      );
      print(r.body);

      return r;
    } catch(error) { print('Network error: $error');

    return null;}
  }

  ///todo:breakIn Api
  static Future<http.Response?> breakIn
      (String CurrentLat,String Currentlong,bool breakIn
    //  int Userid
      ) async {
    var prefs = GetStorage();

    // Read saved user id and token
    userId = prefs.read("userid").toString();
    print('wwwuserid: $userId');

    String token = GetStorage().read("token").toString();
    var checkInUrl = "${baseUrl}EmployeeApi/EmployeeCheckIn";
    // String employeeId = prefs.read("userid").toString();
    print('useridddd:$userId');
    var body = jsonEncode({
      "CurrentLat": CurrentLat,
      "Currentlong": Currentlong,
      "Userid": userId,
      "Breakin":breakIn,
    });
    print("Breakin body:$body");
    try{
      http.Response r = await http.post(
        Uri.parse(checkInUrl),
        body: body,
        headers: {
          'Authorization': 'Bearer $token',
          "Content-Type": "application/json",
        },
      );
      print(r.body);

      return r;
    } catch(error) { print('Network error: $error');

    return null;}
  }

  ///todo:breakOut Api
  static Future<http.Response?> breakOut
      (String CurrentLat,String Currentlong,bool breakOutt
    //  int Userid
      ) async {
    var prefs = GetStorage();

    // Read saved user id and token
    userId = prefs.read("userid").toString();
    print('wwwuserid: $userId');

    String token = GetStorage().read("token").toString();
    var checkInUrl = "${baseUrl}EmployeeApi/EmployeeCheckIn";
    // String employeeId = prefs.read("userid").toString();
    print('useridddd:$userId');
    var body = jsonEncode({
      "CurrentLat": CurrentLat,
      "Currentlong": Currentlong,
      "Userid": userId,
      "Breakout":breakOutt,
    });
    print("BreakOut body:$body");
    try{
      http.Response r = await http.post(
        Uri.parse(checkInUrl),
        body: body,
        headers: {
          'Authorization': 'Bearer $token',
          "Content-Type": "application/json",
        },
      );
      print(r.body);

      return r;
    } catch(error) { print('Network error: $error');

    return null;}
  }

  ///todo:check-out Api
  static Future<http.Response?>? CheckOutApiii(String CurrentLat,String Currentlong,) async {
  var prefs = GetStorage();
  userId = prefs.read("userid").toString();
  print('useridOut: $userId');
  String token = GetStorage().read("token").toString();
  var checkInUrl = "${baseUrl}EmployeeApi/EmployeeCheckOut";
  print('useridddd:$userId');
  var body = jsonEncode({
  "CurrentLat": CurrentLat,
  "Currentlong": Currentlong,
  "Userid": userId,
  });
  print("checkout body:$body");
  try{
  http.Response r = await http.post(
  Uri.parse(checkInUrl),
  body: body,
  headers: {
  'Authorization': 'Bearer $token',
  "Content-Type": "application/json",
  },
  );
  print(r.body);
  if(r.statusCode ==200){
  print("checkOutt Body 200:${r.body}");
  print("checkOutt :${r.statusCode}");
  var responseData = json.decode(r.body);
  await Future.delayed(Duration(seconds: 1));
  Get.offAll(() => Attendance(id: "13"));

  // Show success toast
  Fluttertoast.showToast(
  msg: "Check Out Successfully!",
  backgroundColor: Colors.green,
  textColor: Colors.white,
  toastLength: Toast.LENGTH_LONG,
  gravity: ToastGravity.CENTER,
  );
  }else if (r.statusCode == 401) {
  Fluttertoast.showToast(
  msg: "Unauthorized access. Status code: ${r.statusCode}",
  backgroundColor: Colors.red,
  textColor: Colors.white,
  toastLength: Toast.LENGTH_LONG,
  gravity: ToastGravity.BOTTOM,
  );
  print('CheckOutApi elseeeIf');

  Get.snackbar('Error', r.body);
  } else if(r.statusCode ==409){
  Get.offAll(() => Attendance(id: "13"));

  // Show success toast
  Fluttertoast.showToast(
  msg: "You are already Check-Out",
  backgroundColor: Colors.green,
  textColor: Colors.white,
  toastLength: Toast.LENGTH_LONG,
  gravity: ToastGravity.CENTER,
  );
  } else {
  Fluttertoast.showToast(
  msg: "You can't be check out because you are out of company radius",
  backgroundColor: Colors.red,
  textColor: Colors.white,
  toastLength: Toast.LENGTH_LONG,
  gravity: ToastGravity.BOTTOM,
  );
  print('CheckOutttApi elseee');
  // Get.snackbar('Error', r.body);
  }
  return r;
  } catch(error) { print('Network error: $error');

  Fluttertoast.showToast(
  msg: "Network error: $error",
  backgroundColor: Colors.red,
  textColor: Colors.white,
  toastLength: Toast.LENGTH_LONG,
  gravity: ToastGravity.BOTTOM,
  );

  return null;}
  }

  ///todo: taskAssign Api
  static Future<List<TasksModells>> getTaskAssign1() async {
    var taskUrl = '${baseUrl}EmployeeApi/EmpTasksassign';
    token = prefs.read("token").toString();
    print('token: $token');
    try {
      Map<String, String> headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      };
      print("taskUrl:${taskUrl}");
      http.Response response = await http.get(Uri.parse(taskUrl),headers: headers);
      if (response.statusCode == 200) {
        print("taskUrl:200");
        var jsonResponse = jsonDecode(response.body);
        if (jsonResponse['data'] != null) {
          print("tasksssss:${jsonResponse['data']}");
          return (jsonResponse['data'] as List)
              .map((item) => TasksModells.fromJson(item))
              .toList();

        }
      }
      return [];
    } catch (error) {
      print('Error fetching tasks: $error');
      return [];
    }
  }
  static Future<TaskModel?> getTaskAssign() async {
    var taskUrl = '${baseUrl}EmployeeApi/EmpTasksassign';
    token = prefs.read("token").toString();
    print('token: $token');
    try {
      Map<String, String> headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      };
      print("taskUrl:${taskUrl}");
      http.Response response = await http.get(Uri.parse(taskUrl),headers: headers);
      if (response.statusCode == 200) {
        print("taskUrl:200");
        // var jsonResponse = jsonDecode(response.body);
        TaskModel? taskModel = taskModelFromJson(response.body);
        // if (jsonResponse['data'] != null) {
        //   print("tasksssss:${jsonResponse['data']}");
        //   return (jsonResponse['data'] as List)
        //       .map((item) => TasksModells.fromJson(item))
        //       .toList();
        //
        // }
        return taskModel;

      }
    } catch (error) {
      print('Error fetching tasks: $error');

    }
    return null;

  }

  ///todo: taskDetail Api
  static Future<TaskDetailModel?> getTaskDetail(int id) async {
    final url = Uri.parse('${baseUrl}EmployeeApi/EmpTasksassignbyid?id=$id');
    token = prefs.read("token").toString();
    print('token: $token');
    try {
      Map<String, String> headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      };
      final response = await http.get(url,headers: headers);
      if (response.statusCode == 200) {
        TaskDetailModel? taskDetailModel=taskDetailModelFromJson(response.body);

        return taskDetailModel;
      } else {
        // return {
        //   'succeeded': false,
        //   'statusCode': response.statusCode,
        //   'status': 'Error',
        //   'message': 'Failed to fetch data.'
        // };
      }
    } catch (error) {
      // return {
      //   'succeeded': false,
      //   'statusCode': 500,
      //   'status': 'Error',
      //   'message': 'An error occurred: $error'
      // };
    }
    return null;
  }


  ///todo:empTaskAssign Api
  static Future<http.Response> TaskAssignApi(Map<String, String> formData) async {
    var uri = Uri.parse("${baseUrl}EmployeeApi/AddEmpTasksassign");
    var request = http.MultipartRequest('POST', uri);

    // Print form data
    print('Form Data Task Assign:');
    formData.forEach((key, value) {
      print('$key: $value');
      request.fields[key] = value;
    });
    // Add form fields
    formData.forEach((key, value) {
      request.fields[key] = value;
    });

    ///token
    String token = GetStorage().read("token").toString();

    // Add headers
    request.headers['Authorization'] = 'Bearer $token';

    // Send the request
    var response = await request.send();

    // Parse the response
    var httpResponse = await http.Response.fromStream(response);
    // Print the entire response body
    print('Response body EMpTaskAssign: ${httpResponse.body}');
    if (httpResponse.statusCode == 200) {
      print('Response body200 TaskAssign: ${httpResponse.body}');

      Fluttertoast.showToast(
        msg: "Apply Leave successfully!",
        backgroundColor: Colors.green,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
      );
    } else if (httpResponse.statusCode == 501){
      Fluttertoast.showToast(
        msg: "Leave Already Applied",
        backgroundColor: Colors.green,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
      );
    }
    else {
      print('Failed to apply Leave. Status code: ${httpResponse.statusCode}');

      Fluttertoast.showToast(
        msg: "Failed to apply Leave. Status code: ${httpResponse.statusCode}",
        backgroundColor: Colors.red,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
    }

    return httpResponse;
  }

  ///todo:subTaskCompleted Api
  static Future<http.Response> subTaskCompleted(Map<String, int> formData) async {
    var uri = Uri.parse("${baseUrl}EmployeeApi/SubTaskCompleted");
    var request = http.MultipartRequest('POST', uri);

    // Print form data
    print('Form Data sub Task completed:');
    formData.forEach((key, value) {
      print('$key: $value');
      request.fields[key] = value.toString();
    });
    // Add form fields
    ///token
    String token = GetStorage().read("token").toString();

    // Add headers
    request.headers['Authorization'] = 'Bearer $token';

    // Send the request
    var response = await request.send();

    // Parse the response
    var httpResponse = await http.Response.fromStream(response);
    // Print the entire response body
    print('Response body subTask: ${httpResponse.body}');
    if (httpResponse.statusCode == 200) {
      print('Response body200 subTask: ${httpResponse.body}');

      Fluttertoast.showToast(
        msg: "Task Submitted successfully!",
        backgroundColor: Colors.green,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
      );
    } else if (httpResponse.statusCode == 501){
      Fluttertoast.showToast(
        msg: "Task Submitted Already",
        backgroundColor: Colors.green,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
      );
    }
    else {
      print('Failed to Task Submitted. Status code: ${httpResponse.statusCode}');

      Fluttertoast.showToast(
        msg: "Failed to Task Submitted. Status code: ${httpResponse.statusCode}",
        backgroundColor: Colors.red,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
    }
    return httpResponse;
  }


  ///todo:TaskCompleted Api
  static Future<http.Response> TaskCompleted(Map<String, int> formData) async {
    var uri = Uri.parse("${baseUrl}EmployeeApi/CompletedTasksassign");
    var request = http.MultipartRequest('POST', uri);

    // Print form data
    print('Form Data Task completed:');
    formData.forEach((key, value) {
      print('$key: $value');
      request.fields[key] = value.toString();
    });
    // Add form fields
    ///token
    String token = GetStorage().read("token").toString();

    // Add headers
    request.headers['Authorization'] = 'Bearer $token';

    // Send the request
    var response = await request.send();

    // Parse the response
    var httpResponse = await http.Response.fromStream(response);
    // Print the entire response body
    print('Response body TaskCompleted: ${httpResponse.body}');
    if (httpResponse.statusCode == 200) {
      print('Response body200 TaskCompleted: ${httpResponse.body}');

      Fluttertoast.showToast(
        msg: "Task Completed successfully!",
        backgroundColor: Colors.green,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
      );
    } else if (httpResponse.statusCode == 501){
      Fluttertoast.showToast(
        msg: "Task Completed Already",
        backgroundColor: Colors.green,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
      );
    }
    else {
      print('Failed to TaskCompleted. Status code: ${httpResponse.statusCode}');

      Fluttertoast.showToast(
        msg: "Failed to Task Completed. Status code: ${httpResponse.statusCode}",
        backgroundColor: Colors.red,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
    }
    return httpResponse;
  }


  ///todo:UnCompletedTask Api
  static Future<http.Response> UnCompletedTask(Map<String, String> formData) async {
    var uri = Uri.parse("${baseUrl}EmployeeApi/UnCompletedTasksassign");
    var request = http.MultipartRequest('POST', uri);

    // Print form data
    print('Form Data Task Uncompleted:');
    formData.forEach((key, value) {
      print('$key: $value');
      request.fields[key] = value.toString();
    });
    // Add form fields
    ///token
    String token = GetStorage().read("token").toString();

    // Add headers
    request.headers['Authorization'] = 'Bearer $token';

    // Send the request
    var response = await request.send();

    // Parse the response
    var httpResponse = await http.Response.fromStream(response);
    // Print the entire response body
    print('Response body UnCompleted: ${httpResponse.body}');
    if (httpResponse.statusCode == 200) {
      print('Response body200 UnCompleted: ${httpResponse.body}');

      Fluttertoast.showToast(
        msg: "UnCompleted successfully!",
        backgroundColor: Colors.green,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
      );
    }
    else {
      print('Failed to post reason. Status code: ${httpResponse.statusCode}');

      Fluttertoast.showToast(
        msg: "Failed to post reason. Try Again Later",
        backgroundColor: Colors.red,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
    }
    return httpResponse;
  }


  ///todo: EmpAttendancedatail Api
  // static Future<AttendanceDetailsModel?> EmpAttendancedatail(DateTime date) async {
  //   var attUrl = '${baseUrl}EmployeeApi/Empattendancedatail?Currentdate=$date';
  //   token = prefs.read("token").toString();
  //   print('attUrltoken: $token');
  //   try {
  //     Map<String, String> headers = {
  //       'Authorization': 'Bearer $token',
  //       'Content-Type': 'application/json'
  //     };
  //     print("attUrl:${attUrl}");
  //     http.Response response = await http.get(Uri.parse(attUrl),headers: headers);
  //     if (response.statusCode == 200) {
  //       print("attUrl:200");
  //       AttendanceDetailsModel? attendanceDetailsModel = attendanceDetailsModelFromJson(response.body);
  //       print("attendanceData:${
  //       attendanceDetailsModel.data?.checkInTime
  //       }");
  //       return attendanceDetailsModel;
  //     }
  //     // return null;
  //   } catch (error) {
  //     print('Error fetching attendance details: $error');
  //   }
  //   return null;
  // }
  static Future<AttendanceDetailsModel?> EmpAttendancedatail(DateTime date) async {
    // Format the date to 'yyyy-MM-dd'
    String formattedDate = "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";

    var attUrl = '${baseUrl}EmployeeApi/Empattendancedatail?Currentdate=$formattedDate';
    token = prefs.read("token").toString();
    print('attUrltoken: $token');

    try {
      Map<String, String> headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      };
      print("attUrl: $attUrl");

      http.Response response = await http.get(Uri.parse(attUrl), headers: headers);
      if (response.statusCode == 200) {
        print("attUrl: 200");
        AttendanceDetailsModel? attendanceDetailsModel = attendanceDetailsModelFromJson(response.body);
        print("attendanceData: ${attendanceDetailsModel.data?.checkInTime}");
        print("attendanceDataStatus: ${attendanceDetailsModel.data?.loginStatus}");
        return attendanceDetailsModel;
      }
      // return null;
    } catch (error) {
      print('Error fetching attendance details: $error');
    }
    return null;
  }
  static Future<AttendanceDetailsModel?> AttendancedatailUpdate(DateTime date) async {
    // Format the date to 'yyyy-MM-dd'
    String formattedDate = "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";

    var attUrl = '${baseUrl}EmployeeApi/Empattendancedatail?Currentdate=$formattedDate';
    token = prefs.read("token").toString();
    print('attUrltoken: $token');

    try {
      Map<String, String> headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      };
      print("attUrl: $attUrl");

      http.Response response = await http.get(Uri.parse(attUrl), headers: headers);
      if (response.statusCode == 200) {
        print("attUrl: 200");
        AttendanceDetailsModel? attendanceDetailsModel = attendanceDetailsModelFromJson(response.body);
        print("attendanceData: ${attendanceDetailsModel.data?.checkInTime}");
        print("attendanceDataStatus: ${attendanceDetailsModel.data?.loginStatus}");
        return attendanceDetailsModel;
      }
      // return null;
    } catch (error) {
      print('Error fetching attendance details: $error');
    }
    return null;
  }
  ///todo: AttendanceActivity Api
  static Future<AttendanceActivityModel?> AttendanceActivityApi() async {
    var actiUrl = '${baseUrl}EmployeeApi/EmpLoginactivity';
    token = prefs.read("token").toString();
    print('actiUrltoken: $token');
    try {
      Map<String, String> headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      };
      print("actiUrl:${actiUrl}");
      http.Response response = await http.get(Uri.parse(actiUrl),headers: headers);
      if (response.statusCode == 200) {
        print("attUrl:200");
        AttendanceActivityModel? attendanceActivityModel = attendanceActivityModelFromJson(response.body);
        print("attendanceActivity:${attendanceActivityModel.data?.checkOut}");
        return attendanceActivityModel;
      }
      // return null;
    } catch (error) {
      print('Error fetching attendance details: $error');
    }
    return null;
  }


///todo: GetofficeEvents Api
  static Future<EventsModell?> GetofficeEventsApi() async {
    var eventsUrl = '${baseUrl}EmployeeApi/GetofficeEvents';
    token = prefs.read("token").toString();
    print('eventstoken: $token');
    try {
      Map<String, String> headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      };
      print("eventstoken:${eventsUrl}");
      http.Response response = await http.get(Uri.parse(eventsUrl),headers: headers);
      if (response.statusCode == 200) {
        print("eventsUrl:200");
        EventsModell? eventsModel = eventsModellFromJson(response.body);
        print("eventsss:${eventsModel.data?.map((e)=>e.subtittle)}");
        return eventsModel;
      }
      // return null;
    } catch (error) {
      print('Error fetching events details: $error');
    }
    return null;
  }

  ///todo: CurrentMonthAttendance Api
  static Future<CurrentMonthAttendanceModel?> CurrentMonthAttendance() async {
    var curAtt = '${baseUrl}EmployeeApi/EmpMonthlyattendanceDetails';
    token = prefs.read("token").toString();
    print('curAttToken: $token');
    try {
      Map<String, String> headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      };
      print("curAtt:${curAtt}");
      http.Response response = await http.get(Uri.parse(curAtt),headers: headers);
      if (response.statusCode == 200) {
        print("curAtt:200");
        CurrentMonthAttendanceModel? currentMonthAttendanceModel = currentMonthAttendanceModelFromJson(response.body);
        print("curAttendanceData:${
            currentMonthAttendanceModel.data?.attendance
        }");
        return currentMonthAttendanceModel;
      }
      // return null;
    } catch (error) {
      print('Error fetching attendance details: $error');
    }
    return null;
  }


  ///todo: TotalLeaves Api
  static Future<TotalLeavesModel?> TotalLeaves() async {
    var totalLeave = '${baseUrl}EmployeeApi/EmpTotalLeaves';
    token = prefs.read("token").toString();
    print('totalLeaveToken: $token');
    try {
      Map<String, String> headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      };
      print("totalLeave:${totalLeave}");
      http.Response response = await http.get(Uri.parse(totalLeave),headers: headers);
      if (response.statusCode == 200) {
        print("totalLeave:200");
        TotalLeavesModel? totalLeavesModel = totalLeavesModelFromJson(response.body);
        print("totalLeaveData:${
            totalLeavesModel.data?.type
        }");
        return totalLeavesModel;
      }
      // return null;
    } catch (error) {
      print('Error fetching total leaves: $error');
    }
    return null;
  }


  ///todo: getLeavesDetail Api
  static Future<LeavesDetailModel?> getLeavesDetail(int id) async {
    final url = Uri.parse('${baseUrl}EmployeeApi/EmpTotalLeavesbyid?id=$id');
    token = prefs.read("token").toString();
    print('token: $token');
    try {
      Map<String, String> headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      };
      final response = await http.get(url,headers: headers);
      if (response.statusCode == 200) {
        LeavesDetailModel? leaveDetaill = leavesDetailModelFromJson(response.body);
        return leaveDetaill;
      }
    } catch (error) {
      print('Error fetching total leaves detail: $error');
    }
    return null;
  }

  ///todo: AttendanceGraph Api
  static Future<List<TotalAttendanceData>> AttendanceGraph() async {
    var attGraphUrl = '${baseUrl}EmployeeApi/EmpattendanceGraph';
    token = prefs.read("token").toString();
    print('attGraph token: $token');
    try {
      Map<String, String> headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      };
      print("attGraphUrl:${attGraphUrl}");
      http.Response response = await http.get(Uri.parse(attGraphUrl),headers: headers);
      if (response.statusCode == 200) {
        print("attGraph:200");
        var jsonResponse = jsonDecode(response.body);
        if (jsonResponse['data'] != null) {
          print("attGraph:${jsonResponse['data']}");
          return (jsonResponse['data'] as List)
              .map((item) => TotalAttendanceData.fromJson(item))
              .toList();

        }
      }
      return [];
    } catch (error) {
      print('Error fetching attGraph: $error');
      return [];
    }
  }

  ///todo: TaskHistory Api
  static Future<TaskHistoryModel?> TaskHistory() async {
    var taskHis = '${baseUrl}EmployeeApi/EmpTasklist';
    token = prefs.read("token").toString();
    print('taskHistoryToken: $token');
    try {
      Map<String, String> headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      };
      print("taskHis:${taskHis}");
      http.Response response = await http.get(Uri.parse(taskHis),headers: headers);
      if (response.statusCode == 200) {
        print("taskHis:200");
        TaskHistoryModel? taskHistoryModel = taskHistoryModelFromJson(response.body);
        print("taskHis:${
            taskHistoryModel.data?.completed?.map((e)=>e.taskname)
        }");
      //  Get.to(()=>TaskHistory());
        return taskHistoryModel;
      }
      // return null;
    } catch (error) {
      print('Error fetching taskkkk history: $error');
    }
    return null;
  }

  ///todo: getTaskHisDetail Api
  static Future<Map<String, dynamic>> getTaskHisDetail(int id) async {
    final url = Uri.parse('${baseUrl}EmployeeApi/EmpSubTasklist?SubTaskid=$id');
    token = prefs.read("token").toString();
    print('token: $token');
    try {
      Map<String, String> headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      };
      final response = await http.get(url,headers: headers);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {
          'succeeded': false,
          'statusCode': response.statusCode,
          'status': 'Error',
          'message': 'Failed to fetch data.'
        };
      }
    } catch (error) {
      return {
        'succeeded': false,
        'statusCode': 500,
        'status': 'Error',
        'message': 'An error occurred: $error'
      };
    }
  }

  ///todo: GetFaq Api
  static Future<List<FaqData>> GetFaq() async {
    var getFaq = '${baseUrl}EmployeeApi/GeFaq';
    token = prefs.read("token").toString();
    print('getFaq token: $token');
    try {
      // Map<String, String> headers = {
      //   'Authorization': 'Bearer $token',
      //   'Content-Type': 'application/json'
      // };
      print("getFaqUrl:${getFaq}");
      http.Response response = await http.get(Uri.parse(getFaq),);
      if (response.statusCode == 200) {
        print("getFaq:200");
        var jsonResponse = jsonDecode(response.body);
        if (jsonResponse['data'] != null) {
          print("getFaq:${jsonResponse['data']}");
          return (jsonResponse['data'] as List)
              .map((item) => FaqData.fromJson(item))
              .toList();

        }
      }
      return [];
    } catch (error) {
      print('Error fetching FAQ: $error');
      return [];
    }
  }

///todo:aboutCompany Api
  static Future<AboutCompanyModel?> aboutCompany() async{
    var comUrl = "${baseUrl}HomeApi/Getaboutcompany";
    token = prefs.read("token").toString();
    print('comUrl token: $token');
    try {
      Map<String, String> headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      };
      print("comUrl:${comUrl}");
      http.Response response = await http.get(Uri.parse(comUrl),headers: headers);
      if (response.statusCode == 200) {
        print("comUrl:200");
        AboutCompanyModel aboutCompanyModel = aboutCompanyModelFromJson(response.body);
        // var jsonResponse = jsonDecode(response.body);
        // if (jsonResponse['data'] != null) {
        //   print("comUrl:${jsonResponse['data']}");
        //   return aboutCompanyModel;
        // }
        print("comUrlll:${aboutCompanyModel.data?.companylink}");
        return aboutCompanyModel;
      }
      // return null;
    } catch (error) {
      print('Error fetching FAQ: $error');
      // return [];
    }
  }

  ///todo:overtimeApi Api
  static Future<http.Response?> overtimeApi() async{
    var overTimeUrl = "${baseUrl}EmployeeApi/EmployeeOvertime";
    token = prefs.read("token").toString();
    print('overTimeUrl token: $token');
    try {
      Map<String, String> headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      };
      print("overTimeUrl:${overTimeUrl}");
      http.Response response = await http.post(Uri.parse(overTimeUrl),headers: headers);
      if (response.statusCode == 200) {
        print("overTimeUrl:200");
        OvertimeModel overtimeModel = overtimeModelFromJson(response.body);
        // var jsonResponse = jsonDecode(response.body);
        // if (jsonResponse['data'] != null) {
        //   print("comUrl:${jsonResponse['data']}");
        //   return aboutCompanyModel;
        // }
        print("start overTime:${overtimeModel.data?.startTime}");
        return null;
      }
      // return null;
    } catch (error) {
      print('Error fetching FAQ: $error');
      // return [];
    }
  }


  ///payment get api......
  static EmployeePaymentGetApi() async {
    var prefs = GetStorage();
    // Read saved user id and token
    userId = prefs.read("Id").toString();
    print('wwwuseridEE: $userId');

    token = prefs.read("token").toString();
    print('token: $token');
    var url = '${baseUrl}EmployeeApi/GetJobamount';
    //https://api.hirejobindia.com/api/EmployeeApi/GetJobamount
    try {
      // Add the token to the headers
      Map<String, String> headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      };

      http.Response r = await http.get(Uri.parse(url), headers: headers);
      if (r.statusCode == 200) {
        print("url");
        print(url);
        GetPaymentModel? geetemployepaymentmodel =
        getPaymentModelFromJson(r.body);
        print("profilepaymentinfo: ${geetemployepaymentmodel.data!.toInt()}");
        return geetemployepaymentmodel;
      } else {
        print('Failed to load profile information');
      }
    } catch (error) {
      print('GetJobamounteror: $error');
    }
  }















  ///todo: luckysix api
  ///todo: get profile api....game ..3
  static PriofileLuckySixApi() async {
    var prefs = GetStorage();

    // Retrieve the saved user ID and token
    var userId = prefs.read("Id").toString();
    var token = prefs.read("Token").toString();
    print('User ID2: $userId');
    print('Token2: $token');

    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();

    // Retrieve the saved user ID and token
    var userId2 = sharedPrefs.getString("Id");
    var token2 = sharedPrefs.getString("Token");
    print('User ID2: $userId2');
    print('Token2: $token2');

    if (userId == null || token == null) {
      print('User ID or Token is null');
      return null;
    }

    var url = 'https://api.luckysix.in/api/Account/GetProfileDetail/c0c135c2-2839-4d33-ac92-2b29e1b1e2d1';

    try {
      // Send the HTTP GET request with authorization header
      http.Response r = await http.get(
        Uri.parse(url),
        headers: {
          // "Authorization":
          //     "Bearer $token", // Include the token in the authorization header
          "Content-Type": "application/json",
        },
      );

      if (r.statusCode == 200) {
        print("Request URL: $url");
        print("Response Body: ${r.body}");

        // Parse the response body
        ProfileModel? geetprofilemodel = profileModelFromJson(r.body);
        print("Profile Email ID: ${geetprofilemodel.profile?.id}");
        return geetprofilemodel;
      } else {
        print("Failed to fetch profile. Status code: ${r.statusCode}");
      }
    } catch (error) {
      print('Error fetching profile details: $error');
    }
    return null;
  }


  Future<http.Response> updateProfile({
    String? id,
    String? fullName,
    String? phoneNumber,
    String? email,
    String? address,
    String? pinCode,
    String? dob,
    String? profileImagePath,
    File? profileImage,
  }) async {
    try {
      var uri = Uri.parse('https://api.luckysix.in/api/Account/UpdateProfile');

      var request = http.MultipartRequest('POST', uri);

      request.fields['Id'] = id!;
      request.fields['FullName'] = fullName!;
      request.fields['Phonenumber'] = phoneNumber!;
      request.fields['Email'] = email!;
      request.fields['Address'] = address!;
      request.fields['PinCode'] = pinCode!;
      request.fields['DOB'] = dob!;
      request.fields['ProfileImagePath'] = profileImagePath!;

      if (profileImage != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'ProfileImage',
          profileImage.path,
        ));
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      // Print the raw response to the console
      print('Raw response body: ${response.body}');
      print('Response status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        return response;
      } else {
        throw Exception('Failed to update profile: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error updating profile: $e');
    }
  }


  static Future<ProfileUpdateEmployeeModel> updateEmployeeDetails({
    String? fullName,
    String? workEmail,
    String? mobileNumber,
    String? dateOfBirth,
    String? stateid,
    String? cityid,
    String? address1,
    String? address2,
    String? pincode,
    String? personalEmailAddress,
    String? dateOfJoining,
    String? departmentName,
    String? designationName,
    String? companyName,
    String? companyLocationName,
    String? panNo,
    String? aadharNo,
    String? empProfile,
    String? aadharImage,
    String? panbaseImage,
  }) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse("https://api.ndtechland.com/api/EmployeeApi/EmployeePersonalDetail"));

      // Add only the fields that are provided
      if (fullName != null) request.fields['FullName'] = fullName;
      if (workEmail != null) request.fields['WorkEmail'] = workEmail;
      if (mobileNumber != null) request.fields['MobileNumber'] = mobileNumber;
      if (dateOfBirth != null) request.fields['DateOfBirth'] = dateOfBirth;
      if (stateid != null) request.fields['Stateid'] = stateid;
      if (cityid != null) request.fields['Cityid'] = cityid;
      if (address1 != null) request.fields['Address1'] = address1;
      if (address2 != null) request.fields['Address2'] = address2;
      if (pincode != null) request.fields['Pincode'] = pincode;
      if (personalEmailAddress != null) request.fields['PersonalEmailAddress'] = personalEmailAddress;
      if (dateOfJoining != null) request.fields['DateOfJoining'] = dateOfJoining;
      if (departmentName != null) request.fields['DepartmentName'] = departmentName;
      if (designationName != null) request.fields['DesignationName'] = designationName;
      if (companyName != null) request.fields['CompanyName'] = companyName;
      if (companyLocationName != null) request.fields['CompanyLocationName'] = companyLocationName;
      if (panNo != null) request.fields['PanNo'] = panNo;
      if (aadharNo != null) request.fields['AadharNo'] = aadharNo;

      if (empProfile != null) {
        request.files.add(await http.MultipartFile.fromPath('EmpProfile', empProfile));
      }
      if (aadharImage != null) {
        request.files.add(await http.MultipartFile.fromPath('AadharImage', aadharImage));
      }
      if (panbaseImage != null) {
        request.files.add(await http.MultipartFile.fromPath('PanbaseImage', panbaseImage));
      }
      String token = GetStorage().read("token").toString();
      request.headers['Authorization'] = 'Bearer $token';

      // Send the request
      var response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        return profileUpdateEmployeeModelFromJson(responseBody);
      } else {
        throw Exception('Failed to update employee details: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}

class EmptyResponseException implements Exception {
  final String message;
  EmptyResponseException(this.message);
}

class KeyNotFoundException implements Exception {
  final String message;
  KeyNotFoundException(this.message);
}

class JsonParsingException implements Exception {
  final String message;
  JsonParsingException(this.message);
}

class PaymentRequestException implements Exception {
  final String message;
  PaymentRequestException(this.message);
}




