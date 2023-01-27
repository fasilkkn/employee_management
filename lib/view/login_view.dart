
import 'package:employee_management/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../resources/color.dart';
import '../resources/components/form.dart';
import '../utils/utils.dart';
import '../view_model/auth_view_model.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  ValueNotifier<bool> obsecurePassword = ValueNotifier<bool>(true);
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Stack(
            children: [
              Container(
                color: Colors.transparent,
                height: MediaQuery.of(context).size.height,
              ),
              Image.asset('assets/images/Admin1.png',width: 80.w,),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text('\nLogin to\nyour\naccount...',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.sp
                  ),),
              ),
              Positioned(
                top: 60.h,
                left: 10,
                right: 10,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15,right: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomFormfield(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        hinttext: 'email',
                        prefixIcon:const Icon(Icons.email,
                          color: AppColors.maincolor,size: 20,),
                      ),
                      SizedBox(height: 3.h,),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ValueListenableBuilder(
                            valueListenable: obsecurePassword,
                            builder: (context, value, child){
                              return TextFormField(
                                // focusNode: passwordFocusNode,
                                obscureText: obsecurePassword.value,
                                obscuringCharacter: '*',
                                controller: passwordController,
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide(color: AppColors.maincolor)
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide(color: AppColors.maincolor)
                                    ) ,
                                    hintText: 'password',
                                    // labelText: 'password',
                                    prefixIcon: const Icon(Icons.lock,
                                      color: AppColors.maincolor,
                                      size: 20,),
                                    suffixIcon: InkWell(
                                        onTap: (){
                                          obsecurePassword.value = ! obsecurePassword.value;
                                        },
                                        child: obsecurePassword.value? const Icon(Icons.visibility_off,
                                          color: AppColors.maincolor,size: 20,):
                                        const Icon(Icons.visibility,
                                          color: AppColors.maincolor,
                                          size: 20,)
                                    )
                                ),
                              );
                            }
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(onPressed: (){
                            Navigator.of(context).popAndPushNamed(RouteNames.forgotpassword);
                          }, child: Text('forgot password?')),
                        ],
                      ),
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
                            if(emailController.text.isEmpty){
                              Utils.flushBarErrorMessage('please enter email', context,Colors.red);
                            }
                            else if(passwordController.text.isEmpty){
                              Utils.flushBarErrorMessage('please enter password', context,Colors.red);
                            }
                            else if(passwordController.text.length<6){
                              Utils.flushBarErrorMessage('please enter six digit password', context,Colors.red);
                            }
                            else{
                              Map data ={
                                'email': emailController.text.toString(),
                                'password': passwordController.text.toString()
                              };
                              authViewModel.loginApi(data,context);
                              print('print api');
                            }
                          },
                          child: authViewModel.loading?
                          const Center(child: CircularProgressIndicator(color: Colors.white,)):
                          const Center(
                            child: Text(
                              'Log in',
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
              ),
              Positioned(
                  right: 0,
                  // top: 87.5.h,
                  bottom: 0,
                  child: Image.asset('assets/images/Admin1.2.png',width: 27.w,)),

            ]
        ),
      ),
    );
  }
}
