import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContentDetailsPage extends StatelessWidget {
  const ContentDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Retrieve data from arguments
    final arguments = Get.arguments as Map<String, dynamic>?;

    // Safely retrieve parameters
    final title = arguments?['title'] as String? ?? 'No Title';
    final description = arguments?['description'] as String? ?? 'No Description';
    final image = arguments?['image'] as ImageProvider? ?? const AssetImage('lib/assets/default_image.png');

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: const Color.fromARGB(255, 191, 146, 129),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: image,
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Text(
                description,
                style: const TextStyle(fontSize: 16, color: Colors.black87),
              ),
              const SizedBox(height: 16),
             ElevatedButton(
                onPressed: () {
                  // Action when button is pressed
                  Get.back();
                },
                child: const Text(
                  'Back',
                  style: TextStyle(color: Colors.white), 
                  ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 139, 69, 19), 
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}