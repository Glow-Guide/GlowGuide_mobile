import 'dart:io';
import 'package:flutter/material.dart';
import 'package:prototpye_glowguide/pages/face_analysis.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class DisplayPicturePage extends StatelessWidget {
  final String imagePath;

  const DisplayPicturePage({super.key, required this.imagePath});

  Future<void> _uploadPicture(BuildContext context) async {
    try {
      final file = File(imagePath);

      // Upload picture to Supabase storage
      final String fullPath = await supabase.storage.from('images').upload(
          'images/${DateTime.now().millisecondsSinceEpoch}.jpg', file,
          fileOptions: const FileOptions(cacheControl: '3600', upsert: false));

      // Navigate to FaceAnalysisPage after successful upload
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FaceAnalysisPage(imagePath: imagePath),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to upload picture: $e')),
      );
      print(e);
    }
  }

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
                onPressed: () => _uploadPicture(context),
                child: const Text('Save Picture'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
