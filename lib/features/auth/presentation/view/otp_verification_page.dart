import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

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
                child: Column(
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
                              border: Border.all(color: Colors.grey.shade300),
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
                                        // context
                                        //     .read<AuthUserProvider>()
                                        //     .handleRetryOtp();
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
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
