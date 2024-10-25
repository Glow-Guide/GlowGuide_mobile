import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'face_analysis.dart';
import 'package:prototpye_glowguide/widgets/custom_navbar.dart';

class CameraPage extends StatefulWidget {
  @override
  _ImagePickerPageState createState() => _ImagePickerPageState();
}

class _ImagePickerPageState extends State<CameraPage> {
  XFile? _image; // Store the selected image
  bool _isProcessing = false; // For showing a loading indicator when processing

  final ImagePicker _picker = ImagePicker(); // ImagePicker instance

  // Method to pick image from camera
  Future<void> _pickImageFromCamera() async {
    try {
      setState(() {
        _isProcessing = true; // Show loading while picking
      });

      final pickedFile = await _picker.pickImage(source: ImageSource.camera);
      
      if (pickedFile != null) {
        setState(() {
          _image = pickedFile;
        });
        // Navigate to the face analysis page after image selection
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FaceAnalysisPage(imagePath: _image!.path),
          ),
        );
      }
    } catch (e) {
      print("Error picking image: $e");
    } finally {
      setState(() {
        _isProcessing = false; // Hide loading after picking
      });
    }
  }

  // Method to pick image from gallery
  Future<void> _pickImageFromGallery() async {
    try {
      setState(() {
        _isProcessing = true; // Show loading while picking
      });

      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      
      if (pickedFile != null) {
        setState(() {
          _image = pickedFile;
        });
        // Navigate to the face analysis page after image selection
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FaceAnalysisPage(imagePath: _image!.path),
          ),
        );
      }
    } catch (e) {
      print("Error picking image: $e");
    } finally {
      setState(() {
        _isProcessing = false; // Hide loading after picking
      });
    }
  }

  // Method to clear selected image
  void _clearImage() {
    setState(() {
      _image = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomNavbar(currentIndex:2  ),
      appBar: AppBar(
        title: Text(_image == null ? 'Select Image' : 'Preview'),
        actions: _image != null
            ? [
                IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: _clearImage,
                )
              ]
            : null,
      ),
      body: Stack(
        children: [
          // Display the selected image or a placeholder message
          _image == null
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Glow guide will use a picture of your skin and analyze it. Please take a photo or upload one from the gallery.",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 20),
                      _buildControlPanel(), // Control panel for buttons
                    ],
                  ),
                )
              : Image.file(
                  File(_image!.path),
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),

          // Loading indicator
          if (_isProcessing)
            Center(
              child: Container(
                color: Colors.black54,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            ),
        ],
      ),
    );
  }

  // Control panel with buttons to pick image from camera or gallery
  Widget _buildControlPanel() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: _pickImageFromCamera,
          child: Text('Take Photo'),
        ),
        SizedBox(width: 16),
        ElevatedButton(
          onPressed: _pickImageFromGallery,
          child: Text('Upload from Gallery'),
        ),
      ],
    );
  }
}
