import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:prototpye_glowguide/app/routes/app_pages.dart';
import 'package:prototpye_glowguide/app/routes/app_routes.dart';
import 'package:prototpye_glowguide/pages/views/errorpage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();
  // Initialize Supabase
  await Supabase.initialize(
    url: 'https://udzgbtgbansqcholjbaw.supabase.co', // Replace with your Supabase URL
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVkemdidGdiYW5zcWNob2xqYmF3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzEzMzk3ODEsImV4cCI6MjA0NjkxNTc4MX0._TScne0jFz-j-2zWHny6EWpPIzY-EheFE2I2ERp5s64', // Replace with your Supabase anon key
  );


  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'GlowGuide',
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
      unknownRoute: GetPage(
        name: AppRoutes.error,
        page: () => const ErrorPage(),
        transition: Transition.fade,
      ),
    );
  }
}