import 'dart:ui';

import 'package:ecommerce_user_app/general/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class CToast {
  static void success({required String msg}) {
    toastification.show(
      type: ToastificationType.success,
      style: ToastificationStyle.flatColored,
      autoCloseDuration: const Duration(seconds: 3),
      animationDuration: const Duration(milliseconds: 400),
      animationBuilder: (context, animation, alignment, child) {
        return SlideTransition(
          position: Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero)
              .animate(
                CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
              ),
          child: FadeTransition(
            opacity: animation,
            child: tostWidget(msg: msg, type: ToastificationType.success),
          ),
        );
      },
    );
  }

  static void warning({required String msg}) {
    toastification.show(
      type: ToastificationType.warning,
      style: ToastificationStyle.flatColored,
      autoCloseDuration: const Duration(seconds: 3),
      animationDuration: const Duration(milliseconds: 400),
      animationBuilder: (context, animation, alignment, child) {
        return SlideTransition(
          position: Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero)
              .animate(
                CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
              ),
          child: FadeTransition(
            opacity: animation,
            child: tostWidget(msg: msg, type: ToastificationType.warning),
          ),
        );
      },
    );
  }

  static void info({required String msg}) {
    toastification.show(
      type: ToastificationType.info,
      style: ToastificationStyle.flatColored,
      autoCloseDuration: const Duration(seconds: 3),
      animationDuration: const Duration(milliseconds: 400),
      animationBuilder: (context, animation, alignment, child) {
        return SlideTransition(
          position: Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero)
              .animate(
                CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
              ),
          child: FadeTransition(
            opacity: animation,
            child: tostWidget(msg: msg, type: ToastificationType.info),
          ),
        );
      },
    );
  }

  static void error({required String msg}) {
    toastification.show(
      type: ToastificationType.error,
      style: ToastificationStyle.flatColored,
      autoCloseDuration: const Duration(seconds: 3),
      animationDuration: const Duration(milliseconds: 400),
      animationBuilder: (context, animation, alignment, child) {
        return SlideTransition(
          position: Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero)
              .animate(
                CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
              ),
          child: FadeTransition(
            opacity: animation,
            child: tostWidget(msg: msg, type: ToastificationType.error),
          ),
        );
      },
    );
  }

  static void iconTost({required String msg}) {
    toastification.show(
      type: ToastificationType.success,
      title: Text(
        msg,
        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
      ),
      style: ToastificationStyle.flatColored,
      alignment: Alignment.bottomCenter,
      autoCloseDuration: const Duration(seconds: 4),
      animationDuration: const Duration(milliseconds: 300),
      animationBuilder: (context, animation, alignment, child) {
        return Center(
          child: FadeTransition(
            opacity: animation,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 5),
              margin: EdgeInsets.only(bottom: 5),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                msg,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        );
      },
      primaryColor: AppColors.primaryOrange,
      // backgroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      borderRadius: BorderRadius.circular(12),
      boxShadow: const [
        BoxShadow(
          color: Color(0x07000000),
          blurRadius: 16,
          offset: Offset(0, 16),
          spreadRadius: 0,
        ),
      ],
      showProgressBar: false,
    );
  }

  static Widget tostWidget({
    required String msg,
    required ToastificationType type,
  }) {
    final colors = _getToastColors(type);

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          clipBehavior: Clip.antiAlias,
          margin: EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                colors['primary']!.withOpacity(0.95),
                colors['secondary']!.withOpacity(0.95),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.white.withOpacity(0.3),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: colors['primary']!.withOpacity(0.3),
                blurRadius: 20,
                offset: Offset(0, 8),
                spreadRadius: 0,
              ),
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: Offset(0, 4),
                spreadRadius: 0,
              ),
            ],
          ),
          child: Stack(
            children: [
              // Animated gradient overlay
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.white.withOpacity(0.1),
                        Colors.transparent,
                        Colors.black.withOpacity(0.05),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
              ),
              // Content
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                child: Row(
                  children: [
                    // Icon with animated glow effect
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: iconType(type),
                    ),
                    SizedBox(width: 12),
                    // Message text
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _getToastTitle(type),
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 0.5,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            msg,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.white.withOpacity(0.95),
                              height: 1.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Map<String, Color> _getToastColors(ToastificationType type) {
    switch (type) {
      case ToastificationType.success:
        return {'primary': Color(0xFF00C853), 'secondary': Color(0xFF64DD17)};
      case ToastificationType.error:
        return {'primary': Color(0xFFFF1744), 'secondary': Color(0xFFFF5252)};
      case ToastificationType.info:
        return {'primary': Color(0xFF2979FF), 'secondary': Color(0xFF448AFF)};
      case ToastificationType.warning:
        return {'primary': Color(0xFFFF9100), 'secondary': Color(0xFFFFAB00)};
      default:
        return {'primary': Color(0xFF00C853), 'secondary': Color(0xFF64DD17)};
    }
  }

  static String _getToastTitle(ToastificationType type) {
    switch (type) {
      case ToastificationType.success:
        return 'Success';
      case ToastificationType.error:
        return 'Error';
      case ToastificationType.info:
        return 'Info';
      case ToastificationType.warning:
        return 'Warning';
      default:
        return 'Notification';
    }
  }

  // Icon constants for tree shaking
  static const IconData _successIcon = IconData(
    0xf007,
    fontFamily: 'FlutterIconsax',
    fontPackage: 'iconsax_flutter',
  );

  static const IconData _errorIcon = IconData(
    0xeab3,
    fontFamily: 'FlutterIconsax',
    fontPackage: 'iconsax_flutter',
  );

  static const IconData _infoIcon = IconData(
    0xecde,
    fontFamily: 'FlutterIconsax',
    fontPackage: 'iconsax_flutter',
  );

  static const IconData _warningIcon = IconData(
    0xeb11,
    fontFamily: 'FlutterIconsax',
    fontPackage: 'iconsax_flutter',
  );

  static Icon iconType(ToastificationType type) {
    switch (type) {
      case ToastificationType.success:
        return const Icon(_successIcon, size: 20, color: Colors.white);
      case ToastificationType.error:
        return const Icon(_errorIcon, size: 20, color: Colors.white);
      case ToastificationType.info:
        return const Icon(_infoIcon, size: 20, color: Colors.white);
      case ToastificationType.warning:
        return const Icon(_warningIcon, size: 20, color: Colors.white);
      default:
        return const Icon(_successIcon, size: 20, color: Colors.white);
    }
  }
}
