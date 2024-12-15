import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/history_controller.dart';
import 'package:prototpye_glowguide/widgets/wavyappbar.dart';
import 'package:prototpye_glowguide/widgets/custom_navbar.dart';
class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HistoryController());

    return Scaffold(
      appBar: WavyAppbar(),
       bottomNavigationBar: const CustomNavbar(currentIndex: 1),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.results.isEmpty) {
          return const Center(
            child: Text(
              'No history found',
              style: TextStyle(fontSize: 18),
            ),
          );
        }

        return ListView.builder(
          itemCount: controller.results.length,
          itemBuilder: (context, index) {
            final result = controller.results[index];
            return Card(
              margin: const EdgeInsets.all(10),
              child: ListTile(
                leading: Image.network(
                  result['image_url'],
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.broken_image);
                  },
                ),
                title: Text(
                  result['prediction_label'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                subtitle: Text(
                  'Confidence: ${(result['confidence'] * 100).toStringAsFixed(1)}%\n'
                  'Date: ${DateTime.parse(result['created_at']).toLocal()}',
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Get.to(() => DetailPage(result: result));
                },
              ),
            );
          },
        );
      }),
    );
  }
}

class DetailPage extends StatelessWidget {
  final Map<String, dynamic> result;

  const DetailPage({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              result['image_url'],
              width: double.infinity,
              height: 300,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.broken_image, size: 100);
              },
            ),
            const SizedBox(height: 20),
            Text(
              'Prediction Label: ${result['prediction_label']}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Confidence: ${(result['confidence'] * 100).toStringAsFixed(1)}%',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              'Date: ${DateTime.parse(result['created_at']).toLocal()}',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
