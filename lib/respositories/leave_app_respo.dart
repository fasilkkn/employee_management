import '../data/network/baseApiServices.dart';
import '../data/network/networkApiServices.dart';
import '../resources/app_urls.dart';

class LeaveAppRespository {
  BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> leaveAppApi(dynamic data) async {
    try {
      dynamic response =
      await _apiServices.getPostApiResponse(AppUrls.leaveApp, data);
      return response;
    } catch (e) {
      throw e;
    }
  }
}
