import 'package:employee_management/model/forgot_password_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/response/api_responses.dart';
import '../model/user_model.dart';
import '../respositories/auth_respository.dart';
import '../utils/routes/routes_name.dart';
import '../utils/utils.dart';

var firstname = '';
var lastname = '';
int empId = 0;

class AuthViewModel with ChangeNotifier {

  final _myRespository = AuthRespository();

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  bool _loading1 = false;
  bool get loading1 => _loading1;

  setLoadingforgot(bool value) {
    _loading1 = value;
    notifyListeners();
  }

  ApiResponse<UserModel> userDetails = ApiResponse.loading();

  ApiResponse<ForgotPasswordModel> forgotPassword = ApiResponse.loading();

  setAuth(ApiResponse<UserModel> response) {
    userDetails = response;
    notifyListeners();
  }

  setForgotPassword(ApiResponse<ForgotPasswordModel> response) {
    forgotPassword = response;
    notifyListeners();
  }

  Future<void> loginApi(dynamic data, BuildContext context) async {
    setLoading(true);

    _myRespository.loginApi(data).then((value) {

      setLoading(false);

      if (value['status'] == 'true') {

        firstname = value['firstname'];
        lastname = value['lastname'];
        empId = value['employee_id'];

        Utils.flushBarErrorMessage('Login Successfully', context, Colors.green);
        Navigator.pushNamed(context, RouteNames.home);
      } else {
        Utils.flushBarErrorMessage(value['message'], context, Colors.red);
      }

      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {

      setLoading(false);

      if (kDebugMode) {
        Utils.flushBarErrorMessage(error.toString(), context, Colors.red);
        print(error.toString());
      }
    });
  }

  Future<void> forgotPasswordApi(dynamic data, BuildContext context) async {

    setLoadingforgot(true);

    _myRespository.forgotpasswordApi(data).then((value) {

      setLoadingforgot(false);

      if (value['status'] == 'true') {

        Utils.flushBarErrorMessage('Success', context, Colors.green);
        Navigator.pushNamed(context, RouteNames.login);

      } else {

        Utils.flushBarErrorMessage(value['message'], context, Colors.red);
      }

      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {

      setLoadingforgot(false);

      if (kDebugMode) {

        Utils.flushBarErrorMessage(error.toString(), context, Colors.red);
        print(error.toString());
      }
    });
  }
}
