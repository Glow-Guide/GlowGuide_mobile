import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prototpye_glowguide/pages/views/displaypage_view.dart';
import 'package:prototpye_glowguide/widgets/wavyappbar.dart';
import 'package:prototpye_glowguide/widgets/custom_navbar.dart';
// A screen that allows users to take a picture using a given camera.
class CameraPage extends StatefulWidget {
  CameraPage({super.key});

  @override
  CameraPageState createState() => CameraPageState();
}

class CameraPageState extends State<CameraPage> {
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    // Show the instruction dialog when the page is loaded.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showInstructionDialog();
    });
  }

  Future<void> _showInstructionDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap a button to dismiss the dialog
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Face the Camera'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Please make sure your face is clearly visible.'),
                Text('Tap "OK" when you are ready to take the photo.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _takePicture() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.front,
      imageQuality: 20
      );
      if (image != null && mounted) {
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DisplayPicturePage(
              imagePath: image.path,
            ),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:WavyAppbar(),
      bottomNavigationBar:CustomNavbar(currentIndex: 2) ,
      body: Column(
        children: [
         const  Expanded(
            child: Center(
              child:  Text('Tap the camera button to take a picture, Please Allow GlowGuide to Access Device Camera', textAlign: TextAlign.center),
            ),
          ),
         
              Container(
                width: double.infinity,
                child: FloatingActionButton(
                  
                  onPressed: _takePicture,
                  child: const Icon(Icons.camera_alt),
                ),
              ),
            
          
          const SizedBox(height: 16), // Add some space at the bottom
        ],
      ),
    );
  }
}