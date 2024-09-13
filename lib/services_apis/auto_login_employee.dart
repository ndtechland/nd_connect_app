//import 'package:ps_welness_new_ui/utils/models/account_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/employee_model/autologin_employee_model.dart';

// class AccountService2 {
//   static const String _accountKey2 = 'accountData2';
//   Future<EmployeeLogin?> get getAccountData2 async {
//     final SharedPreferences getStorage = await SharedPreferences.getInstance();
//
//     final String? accountDataEncoded2 = getStorage.get(_accountKey2) as String?;
//     if (accountDataEncoded2 == null) {
//       return null;
//     }
//     return employeeLoginFromJson(accountDataEncoded2);
//   }
//
//   Future<void> setAccountData2(EmployeeLogin? accountData2) async {
//     final SharedPreferences getStorage = await SharedPreferences.getInstance();
//
//     print("WHILE SET ACCOUNT2 $accountData2");
//     getStorage.setString(_accountKey2, employeeLoginToJson(accountData2!));
//   }
// }
//
// final accountService2 = AccountService2();


class AccountService2 {
  static const String _accountKey2 = 'accountData2';

  Future<EmployeeLogin?> get getAccountData2 async {
    final SharedPreferences getStorage = await SharedPreferences.getInstance();

    // Use getString instead of get()
    final String? accountDataEncoded2 = getStorage.getString(_accountKey2);
    if (accountDataEncoded2 == null) {
      return null;
    }

    // Deserialize the stored JSON string into EmployeeLogin
    return employeeLoginFromJson(accountDataEncoded2);
  }

  Future<void> setAccountData2(EmployeeLogin? accountData2) async {
    final SharedPreferences getStorage = await SharedPreferences.getInstance();

    // Check if accountData2 is not null before saving
    if (accountData2 != null) {
      print("WHILE SET ACCOUNT2 $accountData2");
      getStorage.setString(_accountKey2, employeeLoginToJson(accountData2));
    }
  }

  Future<void> clearAccountData2() async {
    final SharedPreferences getStorage = await SharedPreferences.getInstance();
    getStorage.remove(_accountKey2);
  }
}

final accountService2 = AccountService2();
