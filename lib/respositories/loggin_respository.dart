
import '../data/network/baseApiServices.dart';
import '../data/network/networkApiServices.dart';
import '../resources/app_urls.dart';

class LoggedRespository {

  BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> loggedInApi(dynamic data) async {
    try {
      dynamic response =
      await _apiServices.getPostApiResponse(AppUrls.loggedIn, data);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> loggedOutApi(dynamic data) async {
    try {
      dynamic response =
      await _apiServices.getPostApiResponse(AppUrls.loggedOut, data);
      return response;
    } catch (e) {
      throw e;
    }
  }
}