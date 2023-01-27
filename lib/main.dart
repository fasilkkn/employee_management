import 'package:employee_management/utils/routes/routes.dart';
import 'package:employee_management/utils/routes/routes_name.dart';
import 'package:employee_management/view_model/auth_view_model.dart';
import 'package:employee_management/view_model/home_view_model.dart';
import 'package:employee_management/view_model/leave_app_view_model.dart';
import 'package:employee_management/view_model/log_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthViewModel()),
          ChangeNotifierProvider(create: (_) => LoggedViewModel()),
          ChangeNotifierProvider(create: (_) => LeaveBalanceViewModel()),
          ChangeNotifierProvider(create: (_) => LeaveAppViewModel()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            fontFamily: "SourceSans",
            primarySwatch: Colors.blue,
          ),
          initialRoute: RouteNames.login,
          onGenerateRoute: Routes.generateRoute,
        ),
      );
    });
  }
}
