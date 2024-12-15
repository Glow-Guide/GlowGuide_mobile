import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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

        // Group results by date
        final groupedResults = _groupResultsByDate(controller.results);

        return ListView.builder(
          itemCount: groupedResults.keys.length,
          itemBuilder: (context, index) {
            final date = groupedResults.keys.elementAt(index);
            final resultsForDate = groupedResults[date]!;

            return Card(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      date, // Display date
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Divider(),
                    ...resultsForDate.map((result) => ListTile(
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
                            'Confidence: ${(result['confidence'] * 100).toStringAsFixed(1)}%',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onTap: () {
                            Get.to(() => DetailPage(result: result));
                          },
                        )),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }

  /// Groups scan results by date (formatted as yyyy-MM-dd)
  Map<String, List<Map<String, dynamic>>> _groupResultsByDate(
      List<Map<String, dynamic>> results) {
    final Map<String, List<Map<String, dynamic>>> groupedResults = {};

    for (final result in results) {
      final createdAt = DateTime.parse(result['created_at']).add(const Duration(hours: 7));
      final date = DateFormat('yyyy-MM-dd').format(createdAt);

      if (!groupedResults.containsKey(date)) {
        groupedResults[date] = [];
      }
      groupedResults[date]!.add(result);
    }

    return groupedResults;
  }
}

class DetailPage extends StatelessWidget {
  final Map<String, dynamic> result;

  const DetailPage({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    // Treatment options for each category
    final treatmentOptions = {
      "blackhead": [
        "Use products with Hyaluronic Acid, Niacinamide, Salicylic Acid, Glycolic Acid, Alpha Hydroxy Acid, Beta Hydroxy Acid, Poly Hydroxy Acid, Citric Acid, Tea Tree, Lactic Acid, Asam Azelaic, Clay Mask, Benzoyl Peroxide, Azelaic Acid.",
        "Exfoliation treatment with AHA and BHA to reduce pore size."
      ],
      "whitehead": [
        "Use products with Hyaluronic Acid, Niacinamide, Salicylic Acid, Glycolic Acid, Alpha Hydroxy Acid, Beta Hydroxy Acid, Poly Hydroxy Acid, Citric Acid, Tea Tree, Lactic Acid, Asam Azelaic, Clay Mask, Benzoyl Peroxide, Azelaic Acid.",
        "Exfoliation treatment with AHA and BHA to reduce pore size."
      ],
      "pustula": [
        "Use products with Hyaluronic Acid, Niacinamide, Benzoyl Peroxide, Salicylic Acid, Retinol, Glycerin, Mandelic Acid, Zinc, Acetic Acid, Retinoid, Azelaic Acid, Tetracycline, Clindamycin, Eritromycin, Hydrocortisone.",
        "Use sulfur-based cream to dry out the pimple."
      ],
      "nodule": [
        "Use products with Hyaluronic Acid, Niacinamide, Salicylic Acid, Retinoid, Retinol.",
        "Consume Doxycycline, Dextamine-based medicine.",
        "Please visit a dermatologist if the condition is severe. They might suggest hormone therapy or injections for further treatment."
      ],
    };

    // Format date for display in GMT+7
    final gmt7Date = DateTime.parse(result['created_at']).add(const Duration(hours: 7));
    final formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(gmt7Date);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display image
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
            // Prediction details
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
              'Date: $formattedDate',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),

            // Treatment recommendations
            if (treatmentOptions.containsKey(result['prediction_label'])) ...[
              ExpansionTile(
                title: const Text(
                  'Recommended Treatments',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                children: treatmentOptions[result['prediction_label']]!
                    .map((treatment) => ListTile(
                          title: Text(treatment),
                        ))
                    .toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
