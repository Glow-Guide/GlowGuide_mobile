import 'package:carousel_slider/carousel_slider.dart';
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
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.front,
        imageQuality: 50,
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

  Future<void> _pickImageFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
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

  int _current = 0;
  final CarouselSliderController _controller = CarouselSliderController();

  List list = [
    [
      'lib/assets/take_picture.png',
      'Take a picture from camera',
    ],
    ['lib/assets/upload_icon.png', ' Or pick a picture from galery'],
    ['lib/assets/scan_face.png', 'Get Predictions and treatment recommendation']
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: WavyAppbar(),
      bottomNavigationBar: const CustomNavbar(currentIndex: 2),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
              child: SizedBox(
            height: double.maxFinite,
            width: double.maxFinite,
            child: ClipRRect(
              child: Image.asset(
                'lib/assets/lema.jpg',
                fit: BoxFit.cover,
              ),
            ),
          )),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),
            padding: const EdgeInsets.only(bottom: 16),
            child: Column(
              children: [
                CarouselSlider(
                    carouselController: _controller,
                    items: list
                        .map((item) => Container(
                              padding: const EdgeInsets.only(top: 16),
                              child: Column(
                                children: [
                                  Image.asset(
                                    item[0],
                                    width: 116,
                                    height: 116,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Text(
                                      item[1].toString(),
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                            ))
                        .toList(),
                    options: CarouselOptions(
                        autoPlay: true,
                        enlargeCenterPage: true,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });
                        })),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: list.asMap().entries.map((entry) {
                    return GestureDetector(
                      onTap: () => _controller.animateToPage(entry.key),
                      child: Container(
                        width: 12.0,
                        height: 12.0,
                        margin: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 4.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                (Theme.of(context).brightness == Brightness.dark
                                        ? Colors.white
                                        : Colors.black)
                                    .withOpacity(
                                        _current == entry.key ? 0.9 : 0.4)),
                      ),
                    );
                  }).toList(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FloatingActionButton(
                      backgroundColor: const Color.fromRGBO(91, 56, 12, 0.74),
                      onPressed: _takePicture,
                      child: const Icon(Icons.camera_alt, color: Colors.white,),
                    ),
                    FloatingActionButton(
                      backgroundColor: const Color.fromRGBO(91, 56, 12, 0.74),
                      onPressed: _pickImageFromGallery,
                      child: const Icon(Icons.photo_library, color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 16), // Add some space at the bottom
        ],
      ),
    );
  }
}
