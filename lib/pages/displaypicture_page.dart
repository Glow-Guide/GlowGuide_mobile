import 'dart:io';
import 'package:flutter/material.dart';
import 'package:prototpye_glowguide/pages/face_analysis.dart';

// A widget that displays the picture taken by the user.
class DisplayPicturePage extends StatelessWidget {
  final String imagePath;

  const DisplayPicturePage({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Image.file(File(imagePath)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Retake Picture'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          FaceAnalysisPage(imagePath: imagePath),
                    ),
                  );
                },
                child: const Text('Save Picture'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
