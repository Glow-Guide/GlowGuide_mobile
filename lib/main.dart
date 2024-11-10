import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart'; // Import for date formatting initialization
import 'package:prototpye_glowguide/pages/camera_page.dart';
import 'package:prototpye_glowguide/pages/forgot_password.dart';
import 'package:prototpye_glowguide/pages/history_page.dart';
import 'package:prototpye_glowguide/pages/profile_page.dart';
import 'pages/splash_screen.dart';
import 'pages/welcome_page.dart';
import 'pages/login_page.dart';
import 'pages/register_page.dart';
import 'pages/home_page.dart';
import 'package:page_transition/page_transition.dart';
import 'pages/error_page.dart';
import 'package:camera/camera.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();
  try {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  } catch (e) {
    print("Firebase initialization error: $e");
  }
  final cameras = await availableCameras();
  final firstCamera = cameras[1];

  runApp(MyApp(firstCamera: firstCamera));
}

class MyApp extends StatelessWidget {
  final CameraDescription firstCamera;

  const MyApp({super.key, required this.firstCamera});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GlowGuide',
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return PageTransition(
              child: const SplashScreen(),
              type: PageTransitionType.fade,
              settings: settings,
            );
          case '/welcome':
            return PageTransition(
              child: const WelcomePage(),
              type: PageTransitionType.fade,
              settings: settings,
            );
          case '/login':
            return PageTransition(
              child: const LoginPage(),
              type: PageTransitionType.fade,
              settings: settings,
            );
          case '/register':
            return PageTransition(
              child: RegisterPage(),
              type: PageTransitionType.rightToLeft,
              settings: settings,
            );
          case '/home':
            return PageTransition(
              child: const HomePage(),
              type: PageTransitionType.fade,
              settings: settings,
            );
          case '/history':
            return PageTransition(
              child: const HistoryPage(),
              type: PageTransitionType.fade,
              settings: settings,
            );
          case '/profile':
            return PageTransition(
              child: const ProfilePage(),
              type: PageTransitionType.fade,
              settings: settings,
            );
          case '/camera':
            return PageTransition(
              child: CameraPage(
                camera: firstCamera,
              ),
              type: PageTransitionType.fade,
              settings: settings,
            );

          case '/forgot':
            return PageTransition(
              child: ForgotPassword(),
              type: PageTransitionType.fade,
              settings: settings,
            );
          default:
            return PageTransition(
              child: const ErrorPage(),
              type: PageTransitionType.fade,
              settings: settings,
            );
        }
      },
    );
  }
}
