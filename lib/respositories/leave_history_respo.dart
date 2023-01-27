
import 'package:employee_management/model/availed_leave_model.dart';
import 'package:employee_management/model/leave_history_model.dart';
import '../data/network/baseApiServices.dart';
import '../data/network/networkApiServices.dart';
import '../resources/app_urls.dart';

class LeaveHistoryRespository {

  final BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> leaveHistoryApi(dynamic data) async {

    try {

      dynamic response =
      await _apiServices.getPostApiResponse(AppUrls.leaveHistory, data);
      return response= LeaveHistoryModel.fromJson(response);

    } catch (e) {
      throw e;
    }
  }
}