
import 'package:employee_management/model/leave_balance_model.dart';
import 'package:employee_management/respositories/leave_balance_respo.dart';
import 'package:flutter/material.dart';
import '../data/response/api_responses.dart';

class LeaveBalanceViewModel with ChangeNotifier {

  final myRepo = LeaveBalanceRespository();

  ApiResponse<LeaveBalanceModel> leaveBalance = ApiResponse.loading();

  setLeaveBalance(ApiResponse<LeaveBalanceModel> response){

    leaveBalance = response;
    notifyListeners();

  }

  Future<void> fetchLeaveBalanceApi(dynamic data) async {

    setLeaveBalance(ApiResponse.loading());

    myRepo.leaveBalanceApi(data).then((value){

      setLeaveBalance(ApiResponse.completed(value));

    }).onError((error, stackTrace){

      setLeaveBalance(ApiResponse.error(error.toString()));
    });
  }
}