import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prototpye_glowguide/widgets/custom_textfield.dart';
import '../controllers/register_controller.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final RegisterController controller = Get.find<RegisterController>();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(228, 224, 225, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(228, 224, 225, 1),
        centerTitle: true,
        title: const Text('CREATE ACCOUNT'),
      ),
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.topCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: screenWidth * 0.4,
                height: screenHeight * 0.4,
                child: const Image(image: AssetImage('lib/assets/splash.png')),
              ),
              CustomTextField(
                labelText: "Email",
                controller: controller.emailController,
                hintText: "Enter your email",
                obscureText: false,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                labelText: "Username",
                controller: controller.usernameController,
                hintText: "Enter your username",
                obscureText: false,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                labelText: "Password",
                controller: controller.passwordController,
                obscureText: true,
                hintText: "Enter your password",
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () => controller.selectDate(context),
                child: AbsorbPointer(
                  child: CustomTextField(
                    labelText: "Date of Birth",
                    controller: controller.birthDateController,
                    hintText: "Enter your birth date",
                    obscureText: false,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Radio<String>(
                        value: 'Male',
                        activeColor: Color(Colors.blue[400]!.value),
                        groupValue: controller.selectedGender.value,
                        onChanged: controller.setSelectedGender,
                      ),
                      const Text('Male'),
                      Radio<String>(
                        value: 'Female',
                        activeColor: Color(Colors.pink[400]!.value),
                        groupValue: controller.selectedGender.value,
                        onChanged: controller.setSelectedGender,
                      ),
                      const Text('Female'),
                    ],
                  )),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: SizedBox(
                  width: double.infinity,
                  child: Obx(() => ElevatedButton(
                        onPressed: controller.isLoading.value ? null : controller.register,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          backgroundColor: const Color.fromRGBO(91, 56, 12, 0.74),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: controller.isLoading.value
                            ? const CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              )
                            : const Text(
                                'Next',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
