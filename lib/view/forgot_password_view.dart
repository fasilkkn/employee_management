import 'package:employee_management/model/forgot_password_model.dart';
import 'package:employee_management/resources/components/form.dart';
import 'package:employee_management/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../resources/color.dart';
import '../utils/utils.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {



  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordconfirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final forgotPassword = Provider.of<AuthViewModel>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 10,right: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Text('Forgot \nPassword?',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 34.sp,
                    fontWeight: FontWeight.bold
                  ),),
              ],
            ),
            SizedBox(height: 2.h,),
            CustomFormfield(
                controller: emailController,
              hinttext: 'enter your registered email',
            ),
            SizedBox(height: 3.h,),
            CustomFormfield(
                controller: passwordController,
              hinttext: 'enter new password',
            ),
            SizedBox(height: 3.h,),
            CustomFormfield(
              controller: passwordconfirmController,
              hinttext: 'confirm new password',),
            SizedBox(height: 3.h,),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.0),
                gradient: const LinearGradient(
                  begin: Alignment(-0.95, 0.0),
                  end: Alignment(1.0, 0.0),
                  colors: [AppColors.maincolor,Color(0xfffAF8C8A),Color(0xfffA59796)],
                  stops: [0.0,0.5, 1.0],
                ),
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  // minimumSize: Size(300, 35),
                  // maximumSize: Size(300, 35),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)
                  ),
                  backgroundColor: Colors.transparent,
                  disabledForegroundColor: Colors.transparent.withOpacity(0.38),
                  disabledBackgroundColor: Colors.transparent.withOpacity(0.12),
                  shadowColor: Colors.transparent,),
                onPressed: (){
                  setState(() {
                    emailController.text;
                    passwordController.text;
                    passwordconfirmController.text;
                  });
                  if(emailController.text.isEmpty){
                    Utils.flushBarErrorMessage('please enter employee id', context,Colors.red);
                    return;
                  }

                  if(passwordController.text.isEmpty){
                    Utils.flushBarErrorMessage('please enter password', context,Colors.red);
                    return;
                  }

                  if(passwordController.text.length<6){
                    Utils.flushBarErrorMessage('please enter six digit password', context,Colors.red);
                    return;
                  }

                  if(passwordController.text != passwordconfirmController.text){
                    Utils.flushBarErrorMessage('entered password not match', context,Colors.red);
                    return;
                  }

                  if(passwordController.text == passwordconfirmController.text){

                    Map data = {
                      "password": passwordconfirmController.text,
                      "email" : emailController.text
                    };

                    forgotPassword.forgotPasswordApi(data, context);

                    return;
                  }
                  // else{
                  //   // Map data ={
                  //   //   'email': emailController.text.toString(),
                  //   //   'password': passwordController.text.toString()
                  //   // };
                  //   // authViewModel.loginApi(data,context);
                  //   // print('print api');
                  // }
                },
                child: const Center(
                  child: Text(
                    'Submit',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xffffffff),
                      letterSpacing: -0.3858822937011719,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
