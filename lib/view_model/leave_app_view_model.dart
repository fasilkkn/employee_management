
import 'package:employee_management/model/availed_leave_model.dart';
import 'package:employee_management/model/leave_history_model.dart';
import 'package:employee_management/respositories/availedeave_respo.dart';
import 'package:employee_management/respositories/leave_app_respo.dart';
import 'package:employee_management/respositories/leave_history_respo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../data/response/api_responses.dart';
import '../utils/utils.dart';

class LeaveAppViewModel with ChangeNotifier {

  final myRepo = AvailedLeaveRespository();
  final _myRespository = LeaveAppRespository();
  final _myRespoleaveHistory = LeaveHistoryRespository();

  ApiResponse<AvailedLeaveModel> availedLeave = ApiResponse.loading();

  ApiResponse<LeaveHistoryModel> leaveHistory = ApiResponse.loading();

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value){
    _loading = value;
    notifyListeners();
  }

  setAvailedLeave(ApiResponse<AvailedLeaveModel> response){
    availedLeave = response;
    notifyListeners();
  }

  setLeaveHistory(ApiResponse<LeaveHistoryModel> response){
    leaveHistory = response;
    notifyListeners();
  }

  ////////////////////////////////////////// total availed leave

  Future<void> fetchAvailedLeaveApi(dynamic data) async {

    setAvailedLeave(ApiResponse.loading());

    myRepo.availedLeaveApi(data).then((value){

      setAvailedLeave(ApiResponse.completed(value));

    }).onError((error, stackTrace){

      setAvailedLeave(ApiResponse.error(error.toString()));
    });
  }

  ////////////////////////////////////////// leave Application form post

  Future<void> leaveAppApi( dynamic data, BuildContext context) async{

    setLoading(true);

    _myRespository.leaveAppApi(data).then((value) {

      setLoading(false);

      if(value['status']=='true'){

        Utils.flushBarErrorMessage(value['message'], context,Colors.green);

      }
      else{
        Utils.flushBarErrorMessage(value['message'], context,Colors.red);
      }

      if(kDebugMode){
        print(value.toString());
      }

    }).onError((error, stackTrace){

      setLoading(false);

      if(kDebugMode){
        Utils.flushBarErrorMessage(error.toString(), context,Colors.red);
        print(error.toString());

      }

    });

  }

////////////////////////////////////////// leave history

  Future<void> fetchLeaveHistoryApi(dynamic data) async {

    setLeaveHistory(ApiResponse.loading());

    _myRespoleaveHistory.leaveHistoryApi(data).then((value){
      print(value);

      setLeaveHistory(ApiResponse.completed(value));

    }).onError((error, stackTrace){

      setLeaveHistory(ApiResponse.error(error.toString()));
    });
  }
}