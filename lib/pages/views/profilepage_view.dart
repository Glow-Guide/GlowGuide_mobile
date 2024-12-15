import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';
import 'package:prototpye_glowguide/widgets/custom_navbar.dart';
import 'package:prototpye_glowguide/widgets/wavyappbar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  // Define colors for consistent theme
  static const Color backgroundColor = Color.fromRGBO(219, 205, 197, 0.74);
  static const Color accentColor = Color.fromRGBO(91, 56, 12, 0.74);
  static const Color textColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    // Bind the controller to this view
    final controller = Get.find<ProfileController>();

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: WavyAppbar(),
      bottomNavigationBar: const CustomNavbar(currentIndex: 3),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile Image Section
              const CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('lib/assets/splash.jpeg'),
              ),
              const SizedBox(height: 20),
              // Profile Info Section
              _buildStaticCard(
                label: "Your Name",
                value: Obx(() => Text(controller.user.value.username)),
              ),
              const SizedBox(height: 10),
              _buildStaticCard(
                label: "Email",
                value: Obx(() => Text(controller.user.value.email)),
              ),

              const SizedBox(height: 20),
              // Additional Data Section
              _buildStaticCard(
                label: "Birthdate",
                value: Obx(() => Text(controller.user.value.birthdate)),
              ),
              const SizedBox(height: 10),
              _buildStaticCard(
                label: "Gender",
                value: Obx(() => Text(controller.user.value.gender)),
              ),
              const SizedBox(height: 20),
              // About Section
              const ExpansionTile(
                title: Text('About'),
                subtitle: Text(''),
                children: <Widget>[
                  ListTile(
                      title: Text(
                          "GlowGuide is an acne detecting app and treatment recommendation developed by students from Politeknik Negeri Malang as a semester project\n"
                          "Developed using flutter with GetX state management and Supabase as the backend database\n"
                          "We used SVM machine learning model to predict the type of acne based on the image uploaded by the user\n"
                          "Developed by:\n"
                          "1. Brilyan Satria Wahyuda - 2241720019\n"
                          "2. Firstia Aulia Wida Azizah - 2241720135\n"
                          "3. Fransiscus Farrel Edric W. - 2241720032\n"
                          "4. M. Tryo Bagus Anugerah P. - 2241720053")),
                ],
              ),
              // privacy policy
              const ExpansionTile(
                title: Text('Privacy Policy '),
                subtitle: Text(''),
                children: <Widget>[
                  ListTile(
                    title: Text('Personal Information: '),
                    subtitle: Text(
                        'Your name, email address, phone number, and other details provided when registering or using the app.'),
                    trailing: Text(''),
                  ),
             
                  ListTile(
                    title: Text(' Data Security '),
                    subtitle: Text(
                        'We implement security measures to protect your data, but no method of transmission over the internet or electronic storage is 100% secure.'),
                    trailing: Text(''),
                  ),
                  ListTile(
                    title: Text(' Data Sharing '),
                    subtitle: Text(
                        'We do not share your personal information with third parties except as necessary to provide our services or as required by law.'),
                    trailing: Text(''),
                  ),
                  ListTile(
                    title: Text(' Changes to This Policy '),
                    subtitle: Text(
                        'We may update our privacy policy from time to time. We will notify you of any changes by posting the new policy on this page.'),
                    trailing: Text(''),
                  ),
                  ListTile(
                    title: Text(' Contact Us '),
                    subtitle: Text(
                        'If you have any questions about this privacy policy, please contact us at glowguide501@gmail.com.'),
                    trailing: Text(''),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              // Sign Out Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: controller.signOut,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    backgroundColor: accentColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'Sign Out',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget for static information cards
  Widget _buildStaticCard({required String label, required Widget value}) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            const SizedBox(
              height: 10,
              width: double.maxFinite,
            ),
            value,
          ],
        ),
      ),
    );
  }
}
