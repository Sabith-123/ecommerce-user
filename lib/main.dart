import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_user_app/features/auth/presentation/provider/auth_provider.dart';
import 'package:ecommerce_user_app/features/auth/presentation/view/auth_screen.dart';
import 'package:ecommerce_user_app/features/auth/repo/auth_impl.dart';
import 'package:ecommerce_user_app/features/profile/presentation/view/edit_profile.dart';
import 'package:ecommerce_user_app/firebase_options.dart';
import 'package:ecommerce_user_app/general/core/injection.dart';
import 'package:firebase_auth/firebase_auth.dart' hide AuthProvider;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:sendotp_flutter_sdk/sendotp_flutter_sdk.dart';
import 'package:toastification/toastification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await dotenv.load();
  await configureDependencies();

  // Initialize MSG91 OTP widget before any sendOtp/verifyOtp use
  final widgetId = dotenv.env['MSG91_WIDGET_ID'];
  final authToken = dotenv.env['MSG91_AUTH_TOKEN'];

  if (widgetId != null && authToken != null) {
    OTPWidget.initializeWidget(widgetId, authToken);
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) {
            return AuthProvider(
              AuthImpl(
                sl<FirebaseAuth>(),
                sl<FirebaseMessaging>(),
                sl<FirebaseFirestore>(),
              ),
            );
          },
        ),
      ],
      child: ToastificationWrapper(child: MyApp()),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:
          // AuthScreen()
          EditProfile(),
    );
  }
}
