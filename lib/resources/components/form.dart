import 'package:flutter/material.dart';

import '../color.dart';

class CustomFormfield extends StatefulWidget {
  const CustomFormfield(
      {Key? key,
      required this.controller,
      this.type,
      this.hinttext,
      this.prefixIcon})
      : super(key: key);

  final TextEditingController? controller;
  final TextInputType? type;
  final String? hinttext;
  final Widget? prefixIcon;

  @override
  State<CustomFormfield> createState() => _CustomFormfieldState();
}

class _CustomFormfieldState extends State<CustomFormfield> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.type,
      // onFieldSubmitted: (value){
      //   Utils.fieldFocusChange(context, emailFocusNode, passwordFocusNode);
      // },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: AppColors.maincolor)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: AppColors.maincolor)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: AppColors.maincolor)),

        hintText: widget.hinttext,
        // labelText: 'email',
        prefixIcon: widget.prefixIcon,
      ),
      validator: (text) {
        print('validate');
        if (text == null || text.isEmpty) {
          return "value can't be empty";
        }
        // return null;
      },
    );
  }
}
