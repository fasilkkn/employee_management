import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../color.dart';

class HomeWidget extends StatefulWidget {
  Color? color1;
  String text;
  BoxBorder? border;
  String? text2;
  Color? textColor;
  Color? text2Color;
  double? textSize;
  double? text2Size;
   HomeWidget({Key? key,this.color1,
     required this.text,
     this.border,
     this.text2,
     this.textColor,
     this.textSize,
     this.text2Size,
     this.text2Color
   }) : super(key: key);


  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 29.w,
      height: 15.h,
      decoration: BoxDecoration(
        border:widget.border,
        color: widget.color1,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10,right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(widget.text,textAlign: TextAlign.center,
              style:TextStyle(
                color: widget.textColor,
                fontSize: widget.textSize,
              ),
            ),
            Text('${widget.text2}',
              // maxLines: 1,
              style:TextStyle(
                color: widget.text2Color,
                fontSize: widget.text2Size,
              ) ,
            )
          ],
        ),
      ),

    );
  }
}
