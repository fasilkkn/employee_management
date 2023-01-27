import 'package:employee_management/data/response/status.dart';
import 'package:employee_management/resources/color.dart';
import 'package:employee_management/resources/components/home_widget.dart';
import 'package:employee_management/utils/routes/routes_name.dart';
import 'package:employee_management/view_model/auth_view_model.dart';
import 'package:employee_management/view_model/home_view_model.dart';
import 'package:employee_management/view_model/log_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:slide_to_act/slide_to_act.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

LeaveBalanceViewModel leaveBalanceViewModel = LeaveBalanceViewModel();

  DateTime date = DateTime.now();
  final DateFormat  formatter = DateFormat('dd-MM-yyyy');
  final DateFormat weekDay = DateFormat('EEEE');
  final DateFormat timeFormat = DateFormat('hh:mm a');
  final taskController = TextEditingController();

  var time1 = '......';
  var time2 = '......';
  bool? marked= false;

  @override
  void initState() {
    Map data={
      "employee_id" : '$empId'
    };
    leaveBalanceViewModel.fetchLeaveBalanceApi(data);
    super.initState();
    getState();
  }
  @override
  Widget build(BuildContext context) {

    final logged = Provider.of<LoggedViewModel>(context);

    double? width = MediaQuery.of(context).size.width;
    double? height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left:15,right: 15),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(height: 3.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children:  [
                              Text('Hello',
                                style: TextStyle(
                                    fontSize: 30.sp,
                                    fontWeight: FontWeight.w700
                                ),),
                              Text(',',
                                style: TextStyle(
                                    color: AppColors.maincolor,
                                    fontSize: 30.sp,
                                    fontWeight: FontWeight.w700
                                ),),
                            ],
                          ),
                          Text('$firstname $lastname',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 25.sp,
                                fontWeight: FontWeight.w700
                            ),),
                        ],
                      ),
                    ),
                    // ChangeNotifierProvider<AuthViewModel>(
                    //   create: (BuildContext context)=> authViewModel ,
                    //   child: Consumer<AuthViewModel>(
                    //     builder: (context,value, _){
                    //       return Column(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           Row(
                    //             mainAxisAlignment: MainAxisAlignment.start,
                    //             children:  [
                    //               Text('Hello',
                    //                 style: TextStyle(
                    //                     fontSize: 30.sp,
                    //                     fontWeight: FontWeight.w700
                    //                 ),),
                    //               Text(',',
                    //                 style: TextStyle(
                    //                     color: AppColors.maincolor,
                    //                     fontSize: 30.sp,
                    //                     fontWeight: FontWeight.w700
                    //                 ),),
                    //             ],
                    //           ),
                    //           Text(value.userDetails.data!.firstname.toString()+value.userDetails.data!.lastname.toString(),
                    //             style: TextStyle(
                    //                 color: Colors.black,
                    //                 fontSize: 30.sp,
                    //                 fontWeight: FontWeight.w700
                    //             ),),
                    //         ],
                    //       );
                    //     },
                    //   ),
                    // ),

                    Row(
                      children: [
                        IconButton(onPressed: (){}, icon: const Icon(Icons.notifications_sharp)),
                        IconButton(onPressed: (){
                          _showMaterialDialog();
                        }, icon: const Icon(Icons.logout)),
                      ],
                    ),

                  ],
                ),
                SizedBox(height: 3.h,),
                Container(
                  width: width,
                  height: 25.h,
                  decoration: BoxDecoration(
                    color: AppColors.maincolor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text('Leave Balance',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600
                      ),),
                      ChangeNotifierProvider<LeaveBalanceViewModel>(
                        create: (BuildContext context) => leaveBalanceViewModel,
                        child: Consumer<LeaveBalanceViewModel>(
                          builder: (context,value, _){
                            switch (value.leaveBalance.status){
                              case Status.LOADING:
                                return const Center(child: CircularProgressIndicator(color: Colors.white,),);
                              case Status.ERROR:
                                return Column(
                                  children: [
                                    Text(
                                        value.leaveBalance.message.toString()),
                                    TextButton(onPressed: (){
                                      Map data={
                                        "employee_id" : '$empId'
                                      };
                                      leaveBalanceViewModel.fetchLeaveBalanceApi(data);
                                    },
                                        child: const Text('Retry',
                                          style: TextStyle(
                                              fontSize: 20
                                          ),))
                                  ],
                                );
                              case Status.COMPLETED:
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    HomeWidget(
                                      color1: Colors.white,
                                      textColor: AppColors.maincolor,
                                      text: value.leaveBalance.data!.data![0].casual.toString(),
                                      textSize: 25.sp,
                                      text2: 'Casual leave',
                                      text2Size: 12.sp,
                                    ),
                                    HomeWidget(
                                      color1: Colors.white,
                                      textColor: AppColors.maincolor,
                                      text: value.leaveBalance.data!.data![0].sick.toString(),
                                      textSize: 25.sp,
                                      text2: 'Sick leave',
                                      text2Size: 12.sp,
                                    ),
                                    HomeWidget(
                                      color1: Colors.white,
                                      textColor: AppColors.maincolor,
                                      text: value.leaveBalance.data!.data![0].paid.toString(),
                                      textSize: 25.sp,
                                      text2: 'Paid leave',
                                      text2Size: 12.sp,
                                    )
                                  ],
                                );
                            }
                            return Container();
                        }
                        ),
                        ),
                    ],
                  ),
                ),
                SizedBox(height: 4.h,),
                InkWell(
                  onTap: (){
                    // _task();
                    Navigator.pushNamed(context, RouteNames.leave_approval);
                  },
                  child: Container(
                    width: 35.w,
                    height: 6.h,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: AppColors.maincolor,
                          width: 2),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Center(child: Text('Apply for leave',
                      style: TextStyle(
                          fontWeight: FontWeight.w600
                      ),)),
                  ),
                ),
                SizedBox(height: 4.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('${weekDay.format(date)}, '),
                    Text(formatter.format(date)),
                  ],
                ),
                SizedBox(height: 4.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        HomeWidget(
                          color1: AppColors.maincolor,
                          textColor: Colors.white,
                          text: time1,
                          textSize: 20.sp,
                          text2: '',
                        text2Size: 0,),
                        const Text('Logged in',
                          style: TextStyle(
                            fontWeight: FontWeight.w600
                        ),)
                      ],
                    ),
                    Column(
                      children: [
                        HomeWidget(
                          border: Border.all(color: AppColors.maincolor),
                          color1: Colors.white,
                          textColor: AppColors.maincolor,
                          text: time2,
                          textSize: 20.sp,
                          text2: '',
                          text2Size: 0,
                        ),
                        const Text('Logged out',style: TextStyle(
                            fontWeight: FontWeight.w600
                        ),)
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 4.h,),
                marked!?
                Builder(
                  builder: (context) {
                    final GlobalKey<SlideActionState> key = GlobalKey();
                    return  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(
                                color: Colors.red
                            )
                        ),
                        child: SlideAction(
                          elevation: 0,
                          reversed: true,
                          key: key,
                          text: 'swipe to login out               ',
                          onSubmit: () {
                            setState(() {
                              time2 = timeFormat.format(DateTime.now());
                              _task();
                              marked = false;
                              saveState();
                              removeState();
                            });

                            Future.delayed(
                              const Duration(seconds: 10),
                                  () {
                                setState(() {
                                  time1='......';
                                  time2='......';
                                });
                              },
                            );
                          },
                          sliderRotate: true,
                          sliderButtonIconSize: 30,
                          // submittedIcon:SlideAction(reversed: true,) ,
                          outerColor:Colors.white,
                          innerColor: Colors.red,
                          textStyle: const TextStyle(
                              fontSize: 20,
                              color: Colors.black
                          ),
                        ),
                      ),
                    );
                  },
                ):
                Builder(
                  builder: (context) {
                    final GlobalKey<SlideActionState> key0 = GlobalKey();
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(
                                color:Colors.green
                            )
                        ),
                        child: SlideAction(
                          elevation: 0,
                          text: '      swipe to login in',
                          key: key0,
                          onSubmit: () {
                            Future.delayed(
                              const Duration(seconds: 1),
                                  () {
                                setState(() {
                                  time1 = timeFormat.format(DateTime.now());

                                  Map data= {
                                    "employee_id": "$empId"
                                  };
                                  logged.loggedInApi(data, context);
                                  marked = true;
                                  saveState();
                                });
                              },
                            );
                          },
                          sliderButtonIconSize: 30,
                          sliderButtonYOffset: 0,
                          outerColor:Colors.white,
                          innerColor: Colors.green,
                          textStyle: const TextStyle(
                              fontSize: 20,
                              color: Colors.black
                          ),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 2.h,),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future <void> saveState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('value', marked!);
    await prefs.setString('time', time1);
    print("saved$marked");
  }

  Future <void> getState()async{
    final prefs = await SharedPreferences.getInstance();
    marked = prefs.getBool('value')??true;
    time1 = prefs.getString('time')??'......';
    setState(() {
      marked;
      time1;
    });
    print("get$marked");
  }

  Future <void> removeState()async{
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('time');
    marked=false;
  }
  void _showMaterialDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
            ),
            title: Column(
              children: [
                const SizedBox(height: 20,),
            const Text('Are you sure you want exit?',
              style:TextStyle(
                  color: Colors.black
              ) ,),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        onPressed: (){
                          // showAboutDialog(context: context);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.maincolor,
                            maximumSize: const Size(80, 25),
                            minimumSize: const Size(80, 25),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)
                            )
                        ),
                        child: const Text('Yes')),
                    ElevatedButton(
                        onPressed: (){
                          // showAboutDialog(context: context);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            maximumSize: const Size(80, 25),
                            minimumSize: const Size(80, 25),
                            shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                  color:  AppColors.maincolor
                                ),
                                borderRadius: BorderRadius.circular(50)
                            )
                        ),
                        child: const Text('No',style: TextStyle(
                          color: AppColors.maincolor

                        ),))
                  ],
                ),

              ],
            ),
            // content:
            // actions: <Widget>[
            //   TextButton(
            //       onPressed: () {
            //         _dismissDialog();
            //       },
            //       child: Text('Close')),
            //   TextButton(
            //     onPressed: () {
            //       print('HelloWorld!');
            //       _dismissDialog();
            //     },
            //     child: Text('HelloWorld!'),
            //   )
            // ],
          );
        });
  }

  void _task() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (dialogContext) {
          final logged = Provider.of<LoggedViewModel>(context);
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
            ),
            title: Column(
              children: [
                const SizedBox(height: 20,),
                const Text('What did you done today?',
                  style:TextStyle(
                      color: Colors.black
                  ) ,),
                const SizedBox(height: 20,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 100,
                      // width: 300,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: AppColors.maincolor,
                              width: 2
                          ),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white
                      ),
                      child: TextFormField(
                        maxLines: 10,
                        controller: taskController,
                        keyboardType: TextInputType.text,
                        // onFieldSubmitted: (value){
                        //   Utils.fieldFocusChange(context, emailFocusNode, passwordFocusNode);
                        // },
                        decoration: InputDecoration(
                          enabledBorder:OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: const BorderSide(color: Colors.transparent)
                          ) ,
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: const BorderSide(color: Colors.transparent)
                          ),
                          hintText: 'write here....',
                          // labelText: 'email',
                        ),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: (){
                          Map data= {
                            "employee_id": "$empId",
                            "task" : taskController.text.toString(),
                            "name" : firstname+lastname
                          };
                          logged.loggedOutApi(data, context);
                          Navigator.of(dialogContext).pop();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.maincolor,
                            maximumSize: const Size(80, 25),
                            minimumSize: const Size(80, 25),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)
                            )
                        ),
                        child: const Text('submit')),
                  ],
                ),

              ],
            ),
            // content:
            // actions: <Widget>[
            //   TextButton(
            //       onPressed: () {
            //         _dismissDialog();
            //       },
            //       child: Text('Close')),
            //   TextButton(
            //     onPressed: () {
            //       print('HelloWorld!');
            //       _dismissDialog();
            //     },
            //     child: Text('HelloWorld!'),
            //   )
            // ],
          );
        });
  }
  _dismissDialog() {
    Navigator.pop(context);
  }
}
