import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prototpye_glowguide/widgets/wavyappbar.dart';
import 'package:prototpye_glowguide/widgets/custom_navbar.dart';
import '../controllers/home_controller.dart';
import 'contentdetails_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();

    return Scaffold(
      appBar: WavyAppbar(),
      bottomNavigationBar: const CustomNavbar(currentIndex: 0),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Obx(
                () => Text(
                  'Hello, ${homeController.username.value.isEmpty ? 'Guest' : homeController.username.value}! Welcome to GlowGuide',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
            ),
           
            Center(
              child: HoverContent(
                titleText: 'What is GlowGuide?',
                text: 'The Glow Guide application offers an innovative solution for modern users facing challenges in identifying their acne types and determining the right skincare products. Utilizing image processing technology, it enables users to detect their skin and acne types through facial photos and provides tailored skincare recommendations. Glow Guide aims to simplify skin care, reduce the risk of issues from incorrect product choices, and deliver accessible guidance via smartphone, all without high costs or the need for in-person consultations.',
                image: const AssetImage('lib/assets/splash.png'),
              ),
            ),
            Center(
              child: HoverContent(
                titleText: 'Want acne-free skin?',
                text: 'To overcome this problem, it is important to do the right care. Use products that suit your skin type, such as gentle cleansers, exfoliators, and non-comedogenic moisturizers. Also, maintain a healthy diet by consuming lots of vegetables, fruits, and water.',
                image: const AssetImage('lib/assets/acne.jpg'),
              ),
            ),
            Center(
              child: HoverContent(
                titleText: 'Discover the secret to smooth, acne-free skin!',
                text: 'To keep your skin healthy and problem-free, it is important to understand your skin type. Regularly cleansing your face is a crucial first step, followed by diligently exfoliating to remove dead skin cells. Consuming tomatoes is also very beneficial, because it is rich in antioxidants that help maintain healthy skin. In addition, controlling water levels in the body is very important, so exercising and getting enough rest must also be considered. Finally, choosing the right product according to your skin type can be done with the help of the GlowGuide application, which helps find the right product.',
                image: const AssetImage('lib/assets/smooth.jpg'),
              ),
            ),
            Center(
              child: HoverContent(
                titleText: 'Effective way to deal with acne!',
                text: 'Treating acne effectively requires a combination of the right treatments and healthy habits. First, make sure to wash your face twice a day with a gentle cleanser that’s right for your skin type, so dirt and oil don’t clog your pores. Use products that contain active ingredients like benzoyl peroxide or salicylic acid to help reduce inflammation and prevent breakouts.',
                image: const AssetImage('lib/assets/product.jpg'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HoverContent extends StatefulWidget {
  final String text;
  final String titleText;
  final ImageProvider image;

  const HoverContent({
    Key? key,
    required this.text,
    required this.image,
    required this.titleText,
  }) : super(key: key);

  @override
  _HoverContentState createState() => _HoverContentState();
}

class _HoverContentState extends State<HoverContent> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<double>(begin: 1.0, end: 1.05).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _isHovered = true;
          _controller.forward();
        });
      },
      onExit: (_) {
        setState(() {
          _isHovered = false;
          _controller.reverse();
        });
      },
      child: ScaleTransition(
        scale: _animation,
        child: GestureDetector(
          onTap: () {
            // Navigasi ke halaman detail
            Get.to(
              () => ContentDetailsPage(),
              arguments: {
                'title': widget.titleText,
                'description': widget.text,
                'image': widget.image,
              },
              transition: Transition.fadeIn,
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(5.0), 
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromRGBO(219, 205, 197, 0.74),
                borderRadius: BorderRadius.circular(20),
              ),
              height: 150, 
              width: MediaQuery.of(context).size.width * 0.9, 
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5), 
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center, 
                  mainAxisAlignment: MainAxisAlignment.center, 
                  children: [
                    Text(
                      widget.titleText,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15, // font judul
                      ),
                      textAlign: TextAlign.center, 
                    ),
                    const SizedBox(height: 10), // jarak antara judul dan teks
                    Text(
                      widget.text,
                      style: const TextStyle(
                        fontSize: 10, // font teks
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}