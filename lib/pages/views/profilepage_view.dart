import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';
import 'package:prototpye_glowguide/widgets/wavyappbar.dart';
import 'package:prototpye_glowguide/widgets/custom_navbar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Bind the controller to this view
    final controller = Get.find<ProfileController>();

    return Scaffold(
      appBar: WavyAppbar(),
      bottomNavigationBar: const CustomNavbar(currentIndex: 3),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              color: const Color.fromRGBO(219, 205, 197, 0.74),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 50,
                    backgroundImage: AssetImage('lib/assets/splash.png'),
                  ),
                  Obx(() => Text(
                        "Hello, ${controller.username.value}",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )),
                  IconButton(
                    onPressed: controller.editProfile,
                    icon: const Icon(Icons.edit),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() => Text(
                      "Email: ${controller.email.value}",
                      style: const TextStyle(fontSize: 16),
                    )),
                const SizedBox(height: 10),
                Obx(() => Text(
                      "Joined at: ${controller.createdAt.value}",
                      style: const TextStyle(fontSize: 16),
                    )),
                const SizedBox(height: 10),
                Obx(() => Text(
                      "Birthdate: ${controller.birthdate.value}",
                      style: const TextStyle(fontSize: 16),
                    )),
                const SizedBox(height: 10),
                Obx(() => Text(
                      "Gender: ${controller.gender.value}",
                      style: const TextStyle(fontSize: 16),
                    )),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: controller.signOut,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: const Color.fromRGBO(91, 56, 12, 0.74),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  'Sign Out',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
