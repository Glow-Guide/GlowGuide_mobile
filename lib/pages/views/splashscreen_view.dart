import 'package:flutter/material.dart';
import '../views/welcomepage_view.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _opacity = 0.0;
  double _loadingOpacity = 0.0;

  @override
  void initState() {
    super.initState();
    _fadeIn();
    _fadeInLoading();
    _navigateToWelcome();
  }

  _fadeIn() {
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _opacity = 1.0;
      });
    });
  }

  _fadeInLoading() {
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _loadingOpacity = 1.0;
      });
    });
  }

  _navigateToWelcome() async {
    await Future.delayed(const Duration(seconds: 5), () {});
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const WelcomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
                backgroundColor: const Color.fromRGBO(228, 224, 225, 1),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedOpacity(
              opacity: _opacity,
              duration: const Duration(seconds: 2),
              child: const Text(
                "WELCOME TO GLOW GUIDE!",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            AnimatedOpacity(
              opacity: _opacity,
              duration: const Duration(seconds: 2),
              child: Container(
                height: screenHeight * 0.4,
                width: screenWidth * 0.8,
                child: Image.asset('lib/assets/splash.png'),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            AnimatedOpacity(
              opacity: _loadingOpacity,
              duration: const Duration(seconds: 2),
              child: LoadingAnimationWidget.inkDrop(
                color: const Color.fromARGB(255, 141, 19, 248),
                size: 50,
              ),
            ),
          ],
        ),
      ),
    );
  }
}