import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/forgotpassword_controller.dart';
import 'package:prototpye_glowguide/widgets/custom_textfield.dart';
import 'package:prototpye_glowguide/widgets/wavyappbar.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Bind the controller to this view
    final controller = Get.find<ForgotPasswordController>();

    return Scaffold(
      backgroundColor: const Color.fromRGBO(228, 224, 225, 1),
      appBar: WavyAppbar(),
      body: Align(
        alignment: Alignment.topCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Forgot Password",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            CustomTextField(
              labelText: "Email",
              controller: controller.emailController,
              hintText: "Enter your email",
              obscureText: false,
            ),
           const  SizedBox(height: 20),
            
            const  Padding(
               padding:  EdgeInsets.all(8.0),
               child: Text("This feature is not yet implemented, No email will be sent since we did not set up the SMTP email server for this project due to Supabase updated terms and conditions,Sorry for the inconveniences:(", style: TextStyle(color: Colors.red),),
             ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: controller.sendPasswordResetEmail,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    backgroundColor: const Color.fromRGBO(91, 56, 12, 0.74),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'Send Email',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
