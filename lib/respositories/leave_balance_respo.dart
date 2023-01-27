
import 'package:employee_management/model/leave_balance_model.dart';

import '../data/network/baseApiServices.dart';
import '../data/network/networkApiServices.dart';
import '../resources/app_urls.dart';

class LeaveBalanceRespository {

  final BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> leaveBalanceApi(dynamic data) async {

    try {

      dynamic response =
      await _apiServices.getPostApiResponse(AppUrls.leaveBalance, data);
      return response= LeaveBalanceModel.fromJson(response);

    } catch (e) {
      throw e;
    }
  }
}