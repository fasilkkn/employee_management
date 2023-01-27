import 'package:employee_management/utils/routes/routes_name.dart';
import 'package:employee_management/view/forgot_password_view.dart';
import 'package:employee_management/view/home_view.dart';
import 'package:employee_management/view/leave_approval.dart';
import 'package:employee_management/view/login_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.login:
        return MaterialPageRoute(
          builder: (context) => const LoginView(),
        );
      case RouteNames.home:
        return MaterialPageRoute(builder: (context) => const HomeView(),);
      case RouteNames.leave_approval:
        return MaterialPageRoute(builder: (context) => const LeaveApplication(),);
      case RouteNames.forgotpassword:
        return MaterialPageRoute(builder: (context) => const ForgotPassword(),);
      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text('No page found'),
            ),
          );
        });
    }
  }
}
