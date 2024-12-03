import 'package:get/get.dart';
import 'package:prototpye_glowguide/app/routes/app_routes.dart';
import '../../pages/views/splashscreen_view.dart';
import '../../pages/views/welcomepage_view.dart';
import '../../pages/views/loginpage_view.dart';
import '../../pages/views/registerpage_view.dart';
import '../../pages/views/home_view.dart';
import '../../pages/views/historypage_view.dart';
import '../../pages/views/profilepage_view.dart';
import '../../pages/views/camerapage.dart';
import '../../pages/views/forgotpassword_view.dart';
import '../../pages/views/errorpage.dart';
import '../../pages/views/contentdetails_view.dart';
import 'package:camera/camera.dart';
import '../../pages/bindings/home_binding.dart';
import '../../pages/bindings/login_binding.dart';
import '../../pages/bindings/register_binding.dart';
import '../../pages/bindings/profile_binding.dart';
import '../../pages/bindings/forgot_binding.dart';

class AppPages {
  static final cameras = Get.arguments as List<CameraDescription>;
  static final firstCamera = cameras[1];

  static const initial = AppRoutes.splash;

  static final routes = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
      transition: Transition.fade,
    ),
    GetPage(
      name: AppRoutes.welcome,
      page: () => const WelcomePage(),
      binding:HomeBinding() ,
      transition: Transition.fade,
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginPage(),
      binding: LoginBinding(),
      transition: Transition.fade,
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => RegisterPage(),
      binding: RegisterBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomePage(),
      binding: HomeBinding(),
      transition: Transition.fade,
    ),
    GetPage(
      name: AppRoutes.history,
      page: () => const HistoryPage(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => const ProfilePage(),
      binding: ProfileBinding(),
      transition: Transition.fade,
    ),
    GetPage(
      name: AppRoutes.camera,
      page: () => CameraPage(),
      transition: Transition.fade,
    ),
    GetPage(
      name: AppRoutes.forgotPassword,
      page: () => const ForgotPassword(),
      binding: ForgotBinding(),
      transition: Transition.fade,
    ),
    GetPage(
      name: AppRoutes.error,
      page: () => const ErrorPage(),
      transition: Transition.fade,
    ),
    GetPage(
      name: AppRoutes.contentdetails,
      page: () => const ContentDetailsPage(), // Halaman detail konten
      transition: Transition.rightToLeft,
    ),
  ];
}
