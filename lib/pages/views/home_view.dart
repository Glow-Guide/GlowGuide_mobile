import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:prototpye_glowguide/widgets/wavyappbar.dart';
import 'package:prototpye_glowguide/widgets/custom_navbar.dart';
import '../controllers/home_controller.dart';
import 'contentdetails_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int _current = 0;
  final CarouselController _carouselController = CarouselController();

  List<List<String>> list = [
    [
      'lib/assets/create_account.jpg',
      'Step 1: Create an Account and Register',
    ],
    [
      'lib/assets/complete_form.jpg',
      'Step 2: Complete Personal Data',
    ],
    [
      'lib/assets/take_picture.jpg',
      'Step 3: Take a Face Photo with Selfie or from Gallery',
    ],
    [
      'lib/assets/crop_image.jpg',
      'Step 4: Crop the Photo on the Acne Area',
    ],
    [
      'lib/assets/save_image.jpg',
      'Step 5: Save Photo to View Prediction Results',
    ],
    [
      'lib/assets/diagnosis.jpg',
      'Step 6: Acne Diagnosis Results',
    ],
    [
      'lib/assets/recommendation.jpg',
      'Step 7: Get Skincare Ingredients Recommendations',
    ],
  ];

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
                  'Hello, ${homeController.user.value?.username}! Welcome to GlowGuide',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 72, 35, 21),
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
            ),
            // Carousel for guidance
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                 CarouselSlider.builder(
                    itemCount: list.length,
                    itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
                      Card(
                        elevation: 4,
                        shadowColor: Colors.black.withOpacity(0.2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Image.asset(
                                list[itemIndex][0],
                                fit: BoxFit.contain,
                                height: 80, 
                                width: double.infinity,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                list[itemIndex][1],
                                style: const TextStyle(
                                  fontSize: 16, 
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 72, 35, 21),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    options: CarouselOptions(
                      height: 200, 
                      initialPage: 0,
                      autoPlay: true,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _current = index;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(list.length, (index) {
                      return Container(
                        width: 8.0,
                        height: 8.0,
                        margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _current == index
                              ? Colors.brown.shade600
                              : Colors.grey,
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
            // Product Recommendation
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    'Treatment',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 72, 35, 21),
                    ),
                  ),
                  const SizedBox(height: 10),
                  GridView.count(
                    crossAxisCount: 3,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      _buildProductCard('lib/assets/facewash.png', 'Facewash'),
                      _buildProductCard('lib/assets/moisturizer.png', 'Moisturizer'),
                      _buildProductCard('lib/assets/sunscreen.png', 'Sunscreen'),
                      _buildProductCard('lib/assets/serum.png', 'Serum'),
                      _buildProductCard('lib/assets/toner.png', 'Toner'),
                      _buildProductCard('lib/assets/mask.png', 'Mask'),
                      _buildProductCard('lib/assets/pore.png', 'Pore Strips'),
                      _buildProductCard('lib/assets/injection.png', 'Treatment'),
                      _buildProductCard('lib/assets/medicine.png', 'Medicine'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Glow Hack',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 72, 35, 21),
              ),
            ),
            const Center(
              child: HoverContent(
                titleText: 'What is GlowGuide?',
                description:
                    'The Glow Guide application offers an innovative solution for modern users facing challenges in identifying their acne types and determining the right skincare products. Utilizing image processing technology, it enables users to detect their skin and acne types through facial photos and provides tailored skincare recommendations. Glow Guide aims to simplify skin care, reduce the risk of issues from incorrect product choices, and deliver accessible guidance via smartphone, all without high costs or the need for in-person consultations.',
                image: AssetImage('lib/assets/splash.png'),
              ),
            ),
            const Center(
              child: HoverContent(
                description:
                    'To overcome this problem, it is important to do the right care. Use products that suit your skin type, such as gentle cleansers, exfoliators, and non-comedogenic moisturizers. Also, maintain a healthy diet by consuming lots of vegetables, fruits, and water.',
                titleText: 'Want acne-free skin?',
                image: AssetImage('lib/assets/acne.jpg'),
              ),
            ),
            const Center(
              child: HoverContent(
                description:
                    'To keep your skin healthy and problem-free, it is important to understand your skin type. Regularly cleansing your face is a crucial first step, followed by diligently exfoliating to remove dead skin cells. Consuming tomatoes is also very beneficial, because it is rich in antioxidants that help maintain healthy skin. In addition, controlling water levels in the body is very important, so exercising and getting enough rest must also be considered. Finally, choosing the right product according to your skin type can be done with the help of the GlowGuide application, which helps find the right product.',
                titleText: 'Unlock the key to flawless, acne free skin!',
                image: AssetImage('lib/assets/smooth.jpg'),
              ),
            ),
            const Center(
              child: HoverContent(
                description:
                    'Treating acne effectively requires a combination of the right treatments and healthy habits. First, make sure to wash your face twice a day with a gentle cleanser that’s right for your skin type, so dirt and oil don’t clog your pores. Use products that contain active ingredients like benzoyl peroxide or salicylic acid to help reduce inflammation and prevent breakouts.',
                titleText: 'Powerful acne solutions!',
                image: AssetImage('lib/assets/product.jpg'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductCard(String imagePath, String productName) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            productName,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}

class HoverContent extends StatefulWidget {
  final String titleText;
  final ImageProvider image;
  final String description;

  const HoverContent({
    super.key,
    required this.titleText,
    required this.image,
    required this.description,
  });

  @override
  _HoverContentState createState() => _HoverContentState();
}

class _HoverContentState extends State<HoverContent>
    with SingleTickerProviderStateMixin {
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
            // Navigate to the detailed content page
            Get.to(
              () => const ContentDetailsPage(),
              arguments: {
                'title': widget.titleText,
                'image': widget.image,
                'description': widget.description,
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
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              height: Get.width * 0.45,
              width: MediaQuery.of(context).size.width * 0.9,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.titleText,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10), // space between title and image
                  Container(
                    height: Get.width * 0.3,
                    width: Get.width * 0.5,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: widget.image,
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}