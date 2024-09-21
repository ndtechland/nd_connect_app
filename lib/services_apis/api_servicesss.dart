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
import '../models/job_description_by_job_id.dart';
import '../models/job_list_bycat_id_model.dart';
import '../models/profile_model.dart';
import '../models/related_job_byjobId.dart';
import '../models/saved_job_model.dart';
import '../models/state_model.dart';
import '../models/testimonial_model.dart';
import '../modules/all_pages/pages/bookmark.dart';
import '../modules/all_pages/pages/home.dart';
import '../modules/all_pages/pages/login.dart';
import '../test/p_model.dart';

var prefs = GetStorage();
final box = GetStorage();

final LoginController _loginController = Get.put(LoginController());

EmployeeLoginController _employeeloginController =
    Get.put(EmployeeLoginController());

class ApiProvider {
  /// static var baseUrl = 'http://test.pswellness.in/';
  /// "https://api.hirejobindia.com/api/";

  static var baseUrl = FixedText.apiurl;

  //'https://api.hirejobindia.com/api/';

  //http://pswellness.in/
  //static var baseUrl1 = 'https://api.gyros.farm/';
  //'http://pswellness.in/';
  static String token = '';

  //static String Token = '';

  //static String catid = '';
  //static String productid = '';
  //static String orderid = '';
  ///static String Id = '';
  static String MedicineId = ''.toString();
  static String adminId = ''.toString();

  //static String userid = ''.toString();
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
    var url = "https://api.ndtechland.com/api/EmployeeApi/Getstate";
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

  ///job_list_by_cat_id ali 10.............
  static JobdetailByjobIdApi(String? jobListId) async {
    var prefs = GetStorage();

    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // var JobListId = preferences.getString("JobListId");
    // print("JobListId: ${JobListId}");

    //JobTitleId

    // prefs.setString(
    //     "JobListId", _allJibsController.foundJobs[index].id.toString());
    // print("sadsad${_allJibsController.foundJobs[index].id.toString()}");

    //saved userid..........
    //prefs.write("Id".toString(), json.decode(r.body)['Id']);
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

  ///4.login_employeee..........post...apis...
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
      //token
      // Save employee ID and token
      final storage = GetStorage();
      storage.write("userid", employeeId);
      storage.write("token", token);

      print('Saved employeeId: $employeeId');
      print('Saved token: $token');

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

      return r;
    } else if (r.statusCode == 401) {
      Get.snackbar('Message', 'Unauthorized: ${r.body}');
    } else {
      Get.snackbar('Error', 'Error: ${r.body}');
    }

    return r;
  }

  ///profile personal_info_employee....5...

  static PriofilePersonalEmployeeApi() async {
    var prefs = GetStorage();

    // Read saved user id and token
    userId = prefs.read("userid").toString();
    print('wwwuseridEE: $userId');

    token = prefs.read("token").toString();
    print('token: $token');
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

  ///profile basic_info_employee....6...

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

  ///profile bank_info_employee....7...

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

  ///offer_employee_appointment_api...8

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

  /// Employee - Get all salary slips
  static Future<AllsalaryslipModells?> getSalarySlips() async {
    String userId = GetStorage().read("userId").toString();
    String token = GetStorage().read("token").toString();
    var url = "${baseUrl}EmployeeApi/GetAllEmpsalaryslip";

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

  ///dashbord...employee....
  static getDashboardApi() async {
    var prefs = GetStorage();

    // Read saved user id and token
    userId = prefs.read("userid").toString();
    print('wwwuseridEE: $userId');

    token = prefs.read("token").toString();
    print('tokendash: $token');
    var url = '${baseUrl}EmployeeApi/Dashboard';
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
        DashbordModel? geetdashbord = dashbordModelFromJson(r.body);
        print("profileinfobnk: ${geetdashbord.data?.completionPercentage!}");
        return geetdashbord;
      } else {
        print('Failed to load dashboard');
      }
    } catch (error) {
      print('dashboardError: $error');
    }
  }

  ///support comman for both.....

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

  ///static Future<List<StateModelss>> getSatesApi() async {
  //     var url = "${baseUrl}EmployeeApi/Getstate";
  //     try {
  //       http.Response r = await http.get(Uri.parse(url));
  //       print(r.body.toString());
  //       if (r.statusCode == 200) {
  //         var statesData = stateModelFromJson(r.body);
  //         return statesData.data;
  //       } else {
  //         return [];
  //       }
  //     } catch (error) {
  //       return [];
  //     }
  //   }

  ///todo: leave...apply..dropdown.catagary..employee
  static Future<List<GetLeaveTypeList>> getDropdownLeaveApi() async {
    String userId = GetStorage().read("userId").toString();
    String token = GetStorage().read("token").toString();
    var url = "${baseUrl}EmployeeApi/LeaveType";

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
    var url = "${baseUrl}EmployeeApi/LeaveType";

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

  //apply leave employee..............
  static String apiUrl4 = "${baseUrl}EmployeeApi/ApplyLeaveNew";

  static Future<http.Response> ApplyLeave(Map<String, String> formData) async {
    var uri = Uri.parse(apiUrl4);
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

      // Assuming the response body contains the user ID in JSON format
      //var jsonResponse = jsonDecode(httpResponse.body);
      //var userId = jsonResponse['loginProfile']['id'];

      // Extract the user ID from getData

      // Save the user ID using GetStorage
      //final storage = GetStorage();
      // storage.write('userId', userId);

      // Print the user ID
      ///print('Saved user ID: $userId');
      // Show success toast
      Fluttertoast.showToast(
        msg: "Apply Leave successfully!",
        backgroundColor: Colors.green,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
      );
    } else {
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

  ///update_personal_profile..wmployee.

  //static String apiUrl5 = "${baseUrl}EmployeeApi/EmployeePresnolInfo";
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

  static Future<http.Response> updatePersonal({
    required Map<String, String> formData,
    List<Uint8List>? aadharFileContent,
    List<String>? Aadharbase64, // Changed to List to handle multiple images
    Uint8List? panFileContent,
    String? Panbase64,
    Uint8List? profileFileContent,
    String? Profilebase64,
  }) async {
    var uri = Uri.parse("https://api.ndtechland.com/api/EmployeeApi/EmployeePersonalDetail");
    var request = http.MultipartRequest('POST', uri);

    // Add form fields
    request.fields.addAll(formData);

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

    // Add Aadhaar images if available
    if (aadharFileContent != null && Aadharbase64 != null) {
      for (int i = 0; i < aadharFileContent.length; i++) {
        request.files.add(http.MultipartFile.fromBytes(
          'AadharImage', // Ensure this matches the API requirement
          aadharFileContent[i],
          filename: Aadharbase64[i],
          contentType: getMediaType(Aadharbase64[i]),
        ));
      }
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

  ///todo: update profile picture....employee....

  static String apiUrl9 = "${baseUrl}EmployeeApi/EmpUpdateprofilepicture";

  //https://api.hirejobindia.com/api/EmployeeApi/EmpUpdateprofilepicture
  // static Future<http.Response> updateProfileEmployeeApi(
  //     Uint8List cvFileContent3,
  //     String Empprofile,) async {
  //   var uri = Uri.parse(apiUrl9);
  //   var request = http.MultipartRequest('POST', uri);
  //
  //   // Helper function to determine the MediaType based on the file extension
  //   MediaType getMediaType(String filename) {
  //     String ext = filename
  //         .split('.')
  //         .last
  //         .toLowerCase();
  //     switch (ext) {
  //       case 'jpg':
  //       case 'jpeg':
  //         return MediaType('image', 'jpeg');
  //       case 'png':
  //         return MediaType('image', 'png');
  //       default:
  //         throw Exception('Unsupported file type');
  //     }
  //   }
  //
  //   // Add file field
  //   request.files.add(http.MultipartFile.fromBytes(
  //     'Empprofile', // The name of the file field
  //     cvFileContent3,
  //     filename: Empprofile,
  //     contentType: getMediaType(Empprofile),
  //   ));
  //
  //   // Get token from GetStorage
  //   final storage = GetStorage();
  //   var token = storage.read('token');
  //
  //   // Set token in headers
  //   request.headers['Authorization'] = 'Bearer $token';
  //
  //   // Send the request
  //   var response = await request.send();
  //
  //   // Parse the response
  //   var httpResponse = await http.Response.fromStream(response);
  //
  //   // Print the response data
  //   print('Response status: ${httpResponse.statusCode}');
  //   print('Response body: ${httpResponse.body}');
  //
  //   // Show toast based on response
  //   if (httpResponse.statusCode == 200) {
  //     Fluttertoast.showToast(
  //       msg: "Profile updated successfully!",
  //       backgroundColor: Colors.green,
  //       textColor: Colors.white,
  //       toastLength: Toast.LENGTH_LONG,
  //       gravity: ToastGravity.CENTER,
  //     );
  //   } else {
  //     Fluttertoast.showToast(
  //       msg:
  //       "Failed to update profile. Status code: ${httpResponse.statusCode}",
  //       backgroundColor: Colors.red,
  //       textColor: Colors.white,
  //       toastLength: Toast.LENGTH_LONG,
  //       gravity: ToastGravity.BOTTOM,
  //     );
  //   }
  //
  //   return httpResponse;
  // }

  ///change password api,,,,for employee.......
  static Future<http.Response?> ChangePasswordEmployeeApi(BuildContext context,
      // Added context parameter
      String CurrentPassword,
      String NewPassword,
      String ConfirmPassword) async {
    var prefs = GetStorage();

    // Read saved userId
    String employeeId = prefs.read("Id").toString();
    print('wwwuseridEE:$employeeId');
    //employeeId

    var url = "${baseUrl}App/EmployeeChangePassword";
    var body = jsonEncode({
      "userId": employeeId,
      "currentPassword": CurrentPassword,
      "newPassword": NewPassword,
      "confirmPassword": ConfirmPassword,
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




