import 'package:ecommerce_user_app/general/utils/app_color.dart';
import 'package:flutter/material.dart';

class CwTextFormfield extends StatelessWidget {
  final bool isWantTitle;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String? hintText;
  final String? title;
  final bool isSelectable;
  final IconData? suffixIconData;
  final Function()? suffixIconOnPressed;
  final bool isWantType;
  bool? isHintStyle;
  TextInputType? keyboardType;
  final bool? obscureText;
  final String? errorText;
  final bool? isPassword;
  TextInputAction? textInputAction;
  Iterable<String>? autofillHints;

  CwTextFormfield({
    super.key,
    this.isWantTitle = true,
    this.controller,
    this.validator,
    this.hintText,
    this.title,
    this.isSelectable = false,
    this.suffixIconData,
    this.suffixIconOnPressed,
    this.isHintStyle = false,
    this.isWantType = true,
    this.keyboardType = TextInputType.text,
    this.obscureText = true,
    this.errorText,
    this.isPassword = false,
    this.textInputAction,
    this.autofillHints,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isWantTitle
            ? Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  title!,
                  style: TextStyle(
                    fontFamily: 'rthinksans',
                    fontWeight: FontWeight(400),
                    color: AppColors.blackColor,
                    fontSize: 17,
                  ),
                ),
              )
            : SizedBox(),
        SizedBox(height: 5),
        TextFormField(
          textInputAction: textInputAction,
          autofillHints: autofillHints,
          keyboardType: keyboardType,
          readOnly: isSelectable == true && isWantType == false ? true : false,
          cursorColor: AppColors.greenColor,
          style: TextStyle(
            fontFamily: 'rthinksans',
            fontWeight: FontWeight(400),
            fontSize: 18,
            color: AppColors.greenColor,
          ),
          controller: controller,
          validator: validator,
          obscureText: isPassword == true ? true : false,
          // decoration: InputDecoration(hintText: "Name"),
          decoration: InputDecoration(
            errorText: errorText,
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromARGB(169, 101, 101, 132),

                width: 1,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.primarySoftColor,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(8),
            ),

            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.primaryColor, width: 1),

              borderRadius: BorderRadius.circular(8),
            ),

            suffixIcon: isSelectable
                ? IconButton(
                    icon: Icon(suffixIconData, color: AppColors.greenColor),
                    onPressed: suffixIconOnPressed,
                  )
                : null,
            hint: Text(
              hintText!,
              style: TextStyle(
                fontSize: isHintStyle == true ? 18 : 12,
                fontFamily: 'rthinksans',
                fontWeight: FontWeight(400),
                color: isHintStyle == true
                    ? AppColors.greenColor
                    : AppColors.primarySoftColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
