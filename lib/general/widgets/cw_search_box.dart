import 'package:ecommerce_user_app/general/utils/app_color.dart';
import 'package:flutter/material.dart';

class CwSearchBox extends StatelessWidget {
  TextEditingController? controller;
  Widget? prefixIcon;
  String? hintText;
  bool? isHintStyle;
  void Function(String)? onChanged;
  CwSearchBox({
    super.key,
    this.controller,
    this.prefixIcon,
    this.hintText,
    this.isHintStyle,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      cursorColor: AppColors.primaryColor,
      style: TextStyle(
        fontFamily: 'rthinksans',
        fontWeight: FontWeight(400),
        fontSize: 18,
        color: AppColors.greenColor,
      ),
      controller: controller,

      // decoration: InputDecoration(hintText: "Name"),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromARGB(169, 101, 101, 132),

            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primarySoftColor, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),

        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor, width: 1),

          borderRadius: BorderRadius.circular(8),
        ),

        prefixIcon: prefixIcon,
        hint: Text(
          hintText!,
          style: TextStyle(
            fontSize: isHintStyle == true ? 18 : 15,
            fontFamily: 'rthinksans',
            fontWeight: FontWeight(400),
            color: isHintStyle == true
                ? AppColors.greenColor
                : AppColors.primarySoftColor,
          ),
        ),
      ),
    );
  }
}
