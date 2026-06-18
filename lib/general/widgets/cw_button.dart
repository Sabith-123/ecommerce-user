import 'package:ecommerce_user_app/general/utils/app_color.dart';
import 'package:flutter/material.dart';

class CwButton extends StatelessWidget {
  void Function()? onTap;
  String? title;
  Color? buttonColor;
  Color? textColor;
  IconData? icon;
  Color? iconColor;
  bool? isLoading;
  Widget? progressIndicator;
  double? width;
  CwButton({
    super.key,
    this.onTap,
    required this.title,
    this.buttonColor = AppColors.primaryColor,
    this.textColor = Colors.white,
    this.icon,
    this.iconColor,
    this.isLoading = false,
    this.progressIndicator,
    this.width = double.infinity,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isLoading == false ? onTap : null,
      highlightColor: AppColors.transperentColor,
      splashColor: AppColors.transperentColor,
      child: Container(
        width: width,
        height: isLoading == true ? 100 : 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),

          color: isLoading == true ? AppColors.white : buttonColor,
        ),
        child: isLoading == true
            ? Center(child: progressIndicator)
            : Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      title!,
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'rthinksans',
                        fontWeight: FontWeight.w700,
                        color: textColor ?? Colors.white,
                      ),
                    ),
                    if (icon != null) ...[
                      SizedBox(width: 15),

                      Icon(icon, color: iconColor ?? Colors.white),
                    ],
                  ],
                ),
              ),
      ),
    );
  }
}
