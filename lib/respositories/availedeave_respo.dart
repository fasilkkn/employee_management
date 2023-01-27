
import 'package:employee_management/model/availed_leave_model.dart';
import 'package:employee_management/model/leave_balance_model.dart';

import '../data/network/baseApiServices.dart';
import '../data/network/networkApiServices.dart';
import '../resources/app_urls.dart';

class AvailedLeaveRespository {

  final BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> availedLeaveApi(dynamic data) async {

    try {

      dynamic response =
      await _apiServices.getPostApiResponse(AppUrls.availedLeaveBalance, data);
      return response= AvailedLeaveModel.fromJson(response);

    } catch (e) {
      throw e;
    }
  }
}