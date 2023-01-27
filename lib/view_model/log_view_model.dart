
import 'package:employee_management/respositories/loggin_respository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../utils/utils.dart';

class LoggedViewModel with ChangeNotifier{

  final _myRespository = LoggedRespository();

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value){
    _loading = value;
    notifyListeners();
  }

  Future<void> loggedInApi( dynamic data, BuildContext context) async{

    setLoading(true);

    _myRespository.loggedInApi(data).then((value) {

      setLoading(false);
      if(value['status']=='true'){

        Utils.flushBarErrorMessage('Logged In', context,Colors.green);

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

  Future<void> loggedOutApi( dynamic data, BuildContext context) async{

    setLoading(true);

    _myRespository.loggedOutApi(data).then((value) {

      setLoading(false);

      if(value['status']=='true'){

        Utils.flushBarErrorMessage('Logged Out', context,Colors.red);

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
}