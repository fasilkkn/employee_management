import 'package:employee_management/model/availed_leave_model.dart';
import 'package:employee_management/resources/color.dart';
import 'package:employee_management/resources/components/home_widget.dart';
import 'package:employee_management/view_model/auth_view_model.dart';
import 'package:employee_management/view_model/leave_app_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../data/response/status.dart';
import '../view_model/home_view_model.dart';

enum TYPE { casual, sick, paid }

TYPE? type = TYPE.casual;

class LeaveApplication extends StatefulWidget {
  const LeaveApplication({Key? key}) : super(key: key);

  @override
  State<LeaveApplication> createState() => _LeaveApplicationState();
}

class _LeaveApplicationState extends State<LeaveApplication> {
  final _formKey = GlobalKey<FormState>();

  LeaveBalanceViewModel leaveBalanceViewModel = LeaveBalanceViewModel();

  final LeaveAppViewModel _leaveAppViewModel = LeaveAppViewModel();

  TextEditingController reasonController = TextEditingController();
  TextEditingController dateInput = TextEditingController();
  TextEditingController dateInput2 = TextEditingController();

  TextStyle? styles = const TextStyle(color: AppColors.maincolor, fontSize: 17);

  String leaveType = 'Casual';
  @override
  void initState() {
    Map data = {"employee_id": "$empId"};

    leaveBalanceViewModel.fetchLeaveBalanceApi(data);

    _leaveAppViewModel.fetchAvailedLeaveApi(data);

    _leaveAppViewModel.fetchLeaveHistoryApi(data);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final leaveApplication = Provider.of<LeaveAppViewModel>(context);
    double? width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Form(
              key: _formKey,
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.end,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 3.h,
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Leave ',
                          style: TextStyle(
                              color: AppColors.maincolor,
                              fontSize: 25,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          'Application',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Text(
                    'Select',
                    style: TextStyle(color: Colors.black, fontSize: 15.sp),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Container(
                    width: width,
                    height: 27.h,
                    decoration: BoxDecoration(
                      color: AppColors.maincolor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text(
                          'Leave Balance',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 1.h,),
                        ChangeNotifierProvider<LeaveBalanceViewModel>(
                          create: (BuildContext context) =>
                              leaveBalanceViewModel,
                          child: Consumer<LeaveBalanceViewModel>(
                              builder: (context, value, _) {
                            switch (value.leaveBalance.status) {
                              case Status.LOADING:
                                return const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                );
                              case Status.ERROR:
                                return Column(
                                  children: [
                                    Text(
                                        value.leaveBalance.message.toString()),
                                    TextButton(onPressed: (){
                                      // leaveAppListViewModel.fetchLeaveAppListApi();
                                    },
                                        child: const Text('Retry',
                                          style: TextStyle(

                                              fontSize: 20
                                          ),))

                                  ],
                                );
                              case Status.COMPLETED:
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      children: [
                                        HomeWidget(
                                          color1: Colors.white,
                                          textColor: AppColors.maincolor,
                                          text: value.leaveBalance.data!
                                              .data![0].casual
                                              .toString(),
                                          textSize: 25.sp,
                                          text2: 'Casual leave',
                                          text2Size: 12.sp,
                                        ),
                                        Radio(
                                          fillColor:
                                              const MaterialStatePropertyAll(
                                                  Colors.white),
                                          value: TYPE.casual,
                                          onChanged: (TYPE? value) {
                                            setState(() {
                                              leaveType = 'Casual';
                                              type = value;
                                            });
                                          },
                                          groupValue: type,
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        HomeWidget(
                                          color1: Colors.white,
                                          textColor: AppColors.maincolor,
                                          text: value
                                              .leaveBalance.data!.data![0].sick
                                              .toString(),
                                          textSize: 25.sp,
                                          text2: 'Sick leave',
                                          text2Size: 12.sp,
                                        ),
                                        Radio(
                                          fillColor:
                                              const MaterialStatePropertyAll(
                                                  Colors.white),
                                          value: TYPE.sick,
                                          onChanged: (TYPE? value) {
                                            setState(() {
                                              leaveType = 'Sick';
                                              type = value;
                                              print(value);
                                            });
                                          },
                                          groupValue: type,
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        HomeWidget(
                                          color1: Colors.white,
                                          textColor: AppColors.maincolor,
                                          text: value
                                              .leaveBalance.data!.data![0].paid
                                              .toString(),
                                          textSize: 25.sp,
                                          text2: 'Paid leave',
                                          text2Size: 12.sp,
                                        ),
                                        Radio(
                                          fillColor:
                                              const MaterialStatePropertyAll(
                                                  Colors.white),
                                          value: TYPE.paid,
                                          onChanged: (TYPE? value) {
                                            setState(() {
                                              type = value;
                                              leaveType = 'Paid';
                                            });
                                          },
                                          groupValue: type,
                                        ),
                                      ],
                                    )
                                  ],
                                );
                            }
                            return Container();
                          }),
                        ),
                      ],
                    ),
                  ),
                  // ChangeNotifierProvider<LeaveAppViewModel>(
                  //   create: (BuildContext context) => _leaveAppViewModel,
                  //   child: Consumer<LeaveAppViewModel>(
                  //       builder: (context,value, _){
                  //         switch (value.availedLeave.status){
                  //           case Status.LOADING:
                  //             return const Center(child: CircularProgressIndicator(),);
                  //           case Status.ERROR:
                  //             return Text(value.availedLeave.message.toString());
                  //           case Status.COMPLETED:
                  //             return Row(
                  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //               children: [
                  //                 Column(
                  //                   children: [
                  //                     HomeWidget(
                  //                       textColor: Colors.white,
                  //                       color1: AppColors.maincolor,
                  //                       text: value.availedLeave.data!.data![0].casual.toString(),
                  //                       textSize: 25,
                  //                       text2: 'Casual leave',
                  //                       text2Color: Colors.white,
                  //                       text2Size: 15,
                  //                     ),
                  //                     Radio(
                  //                       fillColor: const MaterialStatePropertyAll(AppColors.maincolor),
                  //                       value: TYPE.casual,
                  //                       onChanged: (TYPE? value){
                  //                         setState(() {
                  //                           leaveType = 'Casual';
                  //                           type=value;
                  //                         });
                  //                       }, groupValue: type,
                  //
                  //                     ),
                  //                   ],
                  //                 ),
                  //                 Column(
                  //                   children: [
                  //                     HomeWidget(
                  //                       textColor: Colors.white,
                  //                       color1: AppColors.maincolor,
                  //                       text:value.availedLeave.data!.data![0].sick.toString(),
                  //                       textSize: 25,
                  //                       text2: 'Sick leave',
                  //                       text2Color: Colors.white,
                  //                       text2Size: 15,
                  //                     ),
                  //                     Radio(
                  //                       fillColor: const MaterialStatePropertyAll(AppColors.maincolor),
                  //                       value: TYPE.sick,
                  //                       onChanged: (TYPE? value){
                  //                         setState(() {
                  //                           leaveType = 'Sick';
                  //                           type=value;
                  //                           print(value);
                  //                         });
                  //                       }, groupValue: type,
                  //
                  //                     ),
                  //                   ],
                  //                 ),
                  //                 Column(
                  //                   children: [
                  //                     HomeWidget(
                  //                       textColor: Colors.white,
                  //                       color1: AppColors.maincolor,
                  //                       text: value.availedLeave.data!.data![0].paid.toString(),
                  //                       textSize: 25,
                  //                       text2: 'Paid leave',
                  //                       text2Color: Colors.white,
                  //                       text2Size: 15,
                  //                     ),
                  //                     Radio(
                  //                       fillColor: const MaterialStatePropertyAll(AppColors.maincolor),
                  //                       value: TYPE.paid,
                  //                       onChanged: (TYPE? value){
                  //                         setState(() {
                  //                           type=value;
                  //                           leaveType = 'Paid';
                  //                         });
                  //                       }, groupValue: type,
                  //
                  //                     ),
                  //                   ],
                  //                 )
                  //               ],
                  //             );
                  //         }
                  //         return Container();
                  //       }
                  //   ),
                  // ),

                  SizedBox(
                    height: 3.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 0, right: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: SizedBox(
                            // width: 170,
                            child: TextFormField(
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                              controller: dateInput,
                              decoration: InputDecoration(
                                hintText: 'From',
                                isDense: true,
                                contentPadding:
                                    const EdgeInsets.fromLTRB(20, 20, 20, 0),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: const BorderSide(
                                        color: AppColors.maincolor)),
                                suffixIcon: const Icon(
                                  Icons.calendar_today,
                                  color: AppColors.maincolor,
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: const BorderSide(
                                        color: AppColors.maincolor)),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: const BorderSide(
                                        color: AppColors.maincolor)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: const BorderSide(
                                        color: AppColors.maincolor)),
                              ),
                              readOnly: true,
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(2100));

                                if (pickedDate != null) {
                                  String formattedDate =
                                      DateFormat('MM-dd-yyyy')
                                          .format(pickedDate);
                                  setState(() {
                                    dateInput.text = formattedDate;
                                  });
                                } else {}
                              },
                              validator: (value) =>
                                  value!.isEmpty ? 'Select Date' : null,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: SizedBox(
                            // width: 170,
                            child: TextFormField(
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                              controller: dateInput2,
                              decoration: InputDecoration(
                                hintText: 'To',
                                isDense: true,
                                contentPadding:
                                    const EdgeInsets.fromLTRB(20, 20, 20, 0),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: const BorderSide(
                                        color: AppColors.maincolor)),
                                suffixIcon: const Icon(
                                  Icons.calendar_today,
                                  color: AppColors.maincolor,
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: const BorderSide(
                                        color: AppColors.maincolor)),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: const BorderSide(
                                        color: AppColors.maincolor)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: const BorderSide(
                                        color: AppColors.maincolor)),
                              ),
                              readOnly: true,
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(2100));

                                if (pickedDate != null) {
                                  String formattedDate =
                                      DateFormat('MM-dd-yyyy')
                                          .format(pickedDate);
                                  setState(() {
                                    dateInput2.text = formattedDate;
                                  });
                                } else {}
                              },
                              validator: (value) =>
                                  value!.isEmpty ? 'Select Date' : null,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Container(
                    height: 200,
                    // width: 320,
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: AppColors.maincolor, width: 2),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    child: TextFormField(
                      maxLines: 15,
                      controller: reasonController,
                      keyboardType: TextInputType.text,
                      // onFieldSubmitted: (value){
                      //   Utils.fieldFocusChange(context, emailFocusNode, passwordFocusNode);
                      // },
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:
                                const BorderSide(color: Colors.transparent)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:
                                const BorderSide(color: Colors.transparent)),
                        hintText: 'Write your reason here....',
                        // labelText: 'email',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey;
                          Map data = {
                            "employee_id": "$empId",
                            "leave_type": leaveType,
                            "reason": reasonController.text.toString(),
                            "from_date": dateInput.text.toString(),
                            "to_date": dateInput2.text.toString(),
                            "name": "$firstname $lastname"
                          };
                          leaveApplication.leaveAppApi(data, context);
                        }

                        // _showMaterialDialog();
                        // showAboutDialog(context: context);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.maincolor,
                          maximumSize: const Size(100, 30),
                          minimumSize: const Size(100, 30),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50))),
                      child: const Text(
                        'Apply',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      )),
                  SizedBox(
                    height: 2.h,
                  ),
                  Divider(
                    color: AppColors.maincolor,
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Row(
                    children: [
                      Text(
                        'Leave history',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  ChangeNotifierProvider<LeaveAppViewModel>(
                    create: (BuildContext context) => _leaveAppViewModel,
                    child: Consumer<LeaveAppViewModel>(
                        builder: (context, value, _) {
                      switch (value.leaveHistory.status) {
                        case Status.LOADING:
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        case Status.ERROR:
                          return Column(
                            children: [
                              Text(
                                  value.leaveHistory.message.toString()),
                              TextButton(onPressed: (){
                                Map data={
                                  "employee_id" : '$empId'
                                };
                                _leaveAppViewModel.fetchLeaveHistoryApi(data);
                              },
                                  child: const Text('Retry',
                                    style: TextStyle(
                                        fontSize: 20
                                    ),))
                            ],
                          );;
                        case Status.COMPLETED:
                          return ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: value.leaveHistory.data!.data!.length,
                            separatorBuilder: (BuildContext context, index) {
                              return const Divider(
                                color: Colors.transparent,
                              );
                            },
                            itemBuilder: (BuildContext context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.only(left: 0, right: 0),
                                child: Container(
                                  // height: 200,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                          color: AppColors.maincolor,
                                          width: 1)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10,
                                        right: 10,
                                        top: 10,
                                        bottom: 10),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            Text('Type', style: styles),
                                            Text(
                                              value.leaveHistory.data!
                                                  .data![index].leaveType
                                                  .toString(),
                                              style: styles,
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Text('From', style: styles),
                                            Text(
                                              value.leaveHistory.data!
                                                  .data![index].fromDate
                                                  .toString(),
                                              style: styles,
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Text('To', style: styles),
                                            Text(
                                              value.leaveHistory.data!
                                                  .data![index].toDate
                                                  .toString(),
                                              style: styles,
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                      }
                      return Container();
                    }),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showMaterialDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: Column(
              children: [
                const SizedBox(
                  height: 0,
                ),
                Image.asset(
                  'assets/images/tick.png',
                  scale: 4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Leave ',
                      style: TextStyle(
                          color: AppColors.maincolor,
                          fontWeight: FontWeight.w600),
                    ),
                    const Text(
                      'request sent',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w600),
                    ),
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
