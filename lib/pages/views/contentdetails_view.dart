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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
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
              ),
            ),
            const SizedBox(height: 16),
            Text(
              description,
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}