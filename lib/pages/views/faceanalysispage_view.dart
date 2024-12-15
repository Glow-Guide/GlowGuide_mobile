import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/faceanalysis_controller.dart';

class FaceAnalysisPage extends StatelessWidget {
  final String imagePath;

  const FaceAnalysisPage({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    // Bind the controller to this view
    final controller = Get.put(FaceAnalysisController(imagePath: imagePath));

    // Treatment options for each category
    final treatmentOptions = {
      "blackhead": ["Use products with Hyaluronic Acid , Niacinamide ,  Salicylic Acid , Glycolic acid , Alpha Hydroxy Acid, Beta Hydroxy Acid, Poly Hydroxy Acid , Citric Acid , Tea Tree , Lactic Acid , Asam Azelaic, Clay Mask , Benzoil Peroxide , Azelaic Acid", "Exfoliation treatment with AHA and BHA tratment to reduce pore size "],
      "whitehead": ["Use products with Hyaluronic Acid , Niacinamide ,  Salicylic Acid , Glycolic acid , Alpha Hydroxy Acid, Beta Hydroxy Acid, Poly Hydroxy Acid , Citric Acid , Tea Tree , Lactic Acid , Asam Azelaic, Clay Mask , Benzoil Peroxide , Azelaic Acid", "Exfoliation treatment with AHA and BHA tratment to reduce pore size "],
      "pustula": ["Use products with Hyaluronic Acid , Niacinamide , Benzoyl Peroxide , Salicylic Acid , Retinol , Glycerin , Mandelic Acid , Zinc , Acetic Acid , Retinoid , Azelaic Acid , Tetracycline , Clindamycin , Eritromycin ,Hydrocortisole", "Use Sulphur based cream to dry out the pimple"],
      "nodule": ["Use products with Hyaluronic Acid , Niacinamide ,  Salicylic Acid , Retinoid , Retinol", "Consume Doxycycline, Dextamine based medicine", "Please visit dermatologist if the condition is severe, they might give hormone therapy or injection for further treatment"],
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text('Face Analysis'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Display the selected image
            Image.file(
              File(imagePath),
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
              
            ),
            const SizedBox(height: 20),
            // Face Diagnosis Section
            const Text(
              'Face Diagnosis',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Obx(() {
              if (controller.predictionLabel.value.isEmpty) {
                return const CircularProgressIndicator(); // Show loading spinner while fetching results
              }

              return Column(
                children: [
                  Text(
                    'Prediction: ${controller.predictionLabel.value}',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                  ),
                  Text(
                    'Confidence: ${(double.parse(controller.predictionConfidence.value) * 100).toStringAsFixed(0)}%',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 20),
                  // Treatment Recommendations Section
                  if (treatmentOptions.containsKey(controller.predictionLabel.value)) ...[
                    ExpansionTile(
                      title: const Text(
                        'Recommended Treatments',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      children: treatmentOptions[controller.predictionLabel.value]!
                          .map((treatment) => ListTile(
                                title: Text(treatment),
                              ))
                          .toList(),
                    ),
                  ],
                  const SizedBox(height: 10),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
