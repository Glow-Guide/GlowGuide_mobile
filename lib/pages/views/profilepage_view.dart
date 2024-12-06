import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';
import 'package:prototpye_glowguide/widgets/custom_navbar.dart';

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
      appBar: AppBar(
        elevation: 0,
        backgroundColor: accentColor,
        title: const Text("Profile", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
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
              _buildEditableCard(
                label: "Your Name",
                value: Obx(() => Text(controller.username.value)),
                onEdit: controller.editProfile,
              ),
              const SizedBox(height: 10),
              _buildEditableCard(
                label: "Email",
                value: Obx(() => Text(controller.email.value)),
                onEdit: controller.editProfile,
              ),

              const SizedBox(height: 20),
              // Additional Data Section
              _buildStaticCard(
                label: "Birthdate",
                value: Obx(() => Text(controller.birthdate.value)),
              ),
              const SizedBox(height: 10),
              _buildStaticCard(
                label: "Gender",
                value: Obx(() => Text(controller.gender.value)),
              ),
              const SizedBox(height: 20),
              // About Section
              const ExpansionTile(
                title: Text('About'),
                subtitle: Text(''),
                children: <Widget>[
                  ListTile(
                      title: Text(
                          "Acne Detection App is a modern solution that utilizes technology to help users "
                          "diagnose and understand their acne type. With advanced features, this app provides recommendations "
                          "the best treatment according to your skin needs.")),
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
                    title: Text(' Usage Data: '),
                    subtitle: Text(
                        'Information about how you interact with our application, such as pages viewed and actions taken'),
                    trailing: Text(''),
                  ),
                  ListTile(
                    title: Text(' Device Information '),
                    subtitle:
                        Text('Device type, operating system, and app version.'),
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

  // Widget for editable profile cards
  Widget _buildEditableCard({
    required String label,
    required Widget value,
    required VoidCallback onEdit,
  }) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
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
                const SizedBox(height: 5),
                value,
              ],
            ),
            IconButton(
              onPressed: onEdit,
              icon: const Icon(Icons.edit, color: accentColor),
            ),
          ],
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
