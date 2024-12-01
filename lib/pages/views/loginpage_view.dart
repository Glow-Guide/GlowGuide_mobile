import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../controllers/login_controller.dart';
import 'package:prototpye_glowguide/widgets/custom_textfield.dart';
import 'package:prototpye_glowguide/widgets/wavyappbar.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Bind the controller to this view
    final LoginController controller = Get.find<LoginController>();

    return Scaffold(
      backgroundColor: const Color.fromRGBO(228, 224, 225, 1),
      appBar: WavyAppbar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Login",
                    style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Login to continue using the app",
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              CustomTextField(
                labelText: "Email",
                controller: controller.emailController,
                hintText: "Enter your email",
                obscureText: false,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                labelText: "Password",
                controller: controller.passwordController,
                hintText: "Enter your password",
                obscureText: true,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Obx(
                    () => Row(
                      children: [
                        Checkbox(
                          value: controller.rememberMe.value,
                          onChanged: (bool? value) {
                            controller.rememberMe.value = value ?? false;
                          },
                        ),
                        const Text("Remember Me"),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () => Get.toNamed('/forgot'),
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  width: double.infinity,
                  child: Obx(
                    () => ElevatedButton(
                      onPressed: controller.isLoading.value
                          ? null
                          : controller.login,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        backgroundColor: const Color.fromRGBO(91, 56, 12, 0.74),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: controller.isLoading.value
                          ? const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white),
                            )
                          : const Text(
                              'Login',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  TextButton(
                    onPressed: () => Get.toNamed('/register'),
                    child: const Text(
                      "Register",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}