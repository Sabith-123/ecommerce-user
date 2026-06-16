import 'package:ecommerce_user_app/general/services/easy_navigation.dart';
import 'package:ecommerce_user_app/general/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

void showProgress(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => const _CustomLoadingDailog(),
  );
}

void hideProgress(BuildContext context) {
  EasyNavigation.pop(context: context);
}

class _CustomLoadingDailog extends StatelessWidget {
  const _CustomLoadingDailog();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: PopScope(
        canPop: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(10),
              ),
              child: LoadingAnimationWidget.inkDrop(
                color: AppColors.primaryOrange,
                size: 50,
              ),
              // child: Image.asset(
              //   AppImages.openBook,
              //   scale: 5,
              // ),
            ),
          ],
        ),
      ),
    );
  }
}
