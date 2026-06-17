import 'dart:async';
import 'package:ecommerce_user_app/features/app_root/presentation/view/app_root.dart';
import 'package:ecommerce_user_app/features/auth/presentation/provider/auth_provider.dart';
import 'package:ecommerce_user_app/features/profile/presentation/view/edit_profile.dart';
import 'package:ecommerce_user_app/general/services/easy_navigation.dart';
import 'package:ecommerce_user_app/general/widgets/show_progress.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class OtpVerificationPage extends StatefulWidget {
  const OtpVerificationPage({super.key});

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  final FocusNode pinPutFocusNode = FocusNode();
  Timer? resendTimer;
  int resentSecondsRemaining = 60;
  bool isResendButtonEnabled = false;
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    startResendTimer();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) pinPutFocusNode.requestFocus();
    });
  }

  void startResendTimer() {
    resendTimer?.cancel();
    resentSecondsRemaining = 60;
    resendTimer = Timer.periodic(Duration(seconds: 1), (_) {
      if (!mounted) return;
      setState(() {
        if (resentSecondsRemaining > 0) {
          resentSecondsRemaining--;
        } else {
          resendTimer?.cancel();
          isResendButtonEnabled = true;
        }
      });
    });
  }

  @override
  void dispose() {
    pinPutFocusNode.dispose();
    resendTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Color(0xFFFAFAFA),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Consumer<AuthProvider>(
                  builder: (context, authProvider, child) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 50),
                        Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: Text(
                            'OTP Verification',
                            style: TextStyle(
                              fontFamily: 'montserrat',
                              fontWeight: FontWeight(600),
                              fontSize: 14,
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: Text(
                            'Enter the verification code we just sent to your number +91 *******21',
                            style: TextStyle(
                              fontFamily: 'montserrat',
                              fontWeight: FontWeight(400),
                              fontSize: 14,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              pinPutFocusNode.requestFocus();
                            },
                            child: Pinput(
                              controller: authProvider.otpCtl,
                              length: 4,
                              keyboardType: TextInputType.number,
                              focusNode: pinPutFocusNode,
                              defaultPinTheme: PinTheme(
                                width: 44,
                                height: 44,
                                textStyle: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.red,
                                  fontFamily: 'montserrat',
                                  fontWeight: FontWeight(600),
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey.shade300,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              followingPinTheme: PinTheme(
                                width: 44,
                                height: 44,
                                textStyle: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontFamily: 'montserrat',
                                  fontWeight: FontWeight(600),
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Color(0xFF100E09)),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              disabledPinTheme: PinTheme(
                                width: 44,
                                height: 44,
                                textStyle: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontFamily: 'montserrat',
                                  fontWeight: FontWeight(600),
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Color.fromARGB(255, 125, 124, 123),
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              focusedPinTheme: PinTheme(
                                width: 44,
                                height: 44,
                                textStyle: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontFamily: 'montserrat',
                                  fontWeight: FontWeight(600),
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Color.fromRGBO(26, 22, 13, 1),
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 20),
                        Center(
                          child: Text(
                            resentSecondsRemaining > 0
                                ? "$resentSecondsRemaining s"
                                : "",
                            style: TextStyle(
                              color: Color(0xFFFF5454),
                              fontFamily: 'montserrat',
                              fontWeight: FontWeight(600),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Center(
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Don't Get OTP? ",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontFamily: 'montserrat',
                                    fontWeight: FontWeight(500),
                                  ),
                                ),
                                TextSpan(
                                  recognizer: resentSecondsRemaining > 0
                                      ? null
                                      : (TapGestureRecognizer()
                                          ..onTap = () {
                                            authProvider.retryOtpFun();
                                          }),
                                  text: " Resend",
                                  style: TextStyle(
                                    color: resentSecondsRemaining > 0
                                        ? Colors.grey
                                        : Color(0xFF2873F0),
                                    fontSize: 12,
                                    fontFamily: 'montserrat',
                                    fontWeight: FontWeight(500),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        InkWell(
                          onTap: () async {
                            await authProvider.verifyOtpFun(
                              onSuccess: () async {
                                await authProvider.checkUserAfterOtp(
                                  onSuccess: (hasName) {
                                    if (!mounted) return;

                                    if (hasName) {
                                      EasyNavigation.pushAndRemoveUntil(
                                        context: context,
                                        page: AppRoot(),
                                      );
                                    } else {
                                      EasyNavigation.pushAndRemoveUntil(
                                        context: context,
                                        page: EditProfile(),
                                      );
                                    }
                                  },
                                  onError: () {
                                    if (!mounted) return;
                                    hideProgress(context);
                                  },
                                );
                              },
                              onError: () {
                                if (!mounted) return;
                                hideProgress(context);
                              },
                            );
                          },
                          child: Container(
                            height: 44,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(60),
                              color: Color(0xFF100E09),
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  'Verify',
                                  style: TextStyle(
                                    color: Color(0xFFFFFFFF),
                                    fontFamily: 'montserrat',
                                    fontWeight: FontWeight(600),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
