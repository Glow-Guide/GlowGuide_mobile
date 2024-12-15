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
                      _buildProductCard(
                        'lib/assets/facewash.png',
                        'Facewash',
                        '1) Salicylic Acid \n2) Hyaluronic Acid \n3) Niacinamide \n4) Gentle Exfoliants \nRecommendations : \nCeraVe Foaming Facial Cleanser , La Roche-Posay Effaclar Purifying Foaming Gel , Skintific Pore Clarifying Cleanser '
                      ),
                      _buildProductCard(
                        'lib/assets/moisturizer.png',
                        'Moisturizer',
                        '1) Hyaluronic Acid \n2) Non-comedogenic Oils (seperti Jojoba Oil) \n3) Ceramides \n4) Glycerin  \nRecommendations : \nCeraVe Moisturizing Cream , Skintific Oil Control Moisturizer , Avoskin Hydrating Treatment Essence'
                      ),
                      _buildProductCard(
                        'lib/assets/sunscreen.png',
                        'Sunscreen',
                        '1)Non-comedogenic \n2) Broad Spectrum SPF \n3) Mineral Sunscreen \nRecommendations : \nLa Roche-Posay Anthelios Clear Skin Oil-Free Sunscreen SPF 60 , Azarine , Facetology , EltaMD UV Clear Broad-Spectrum SPF 46'
                      ),
                      _buildProductCard(
                        'lib/assets/serum.png',
                        'Serum',
                        '1)Hyaluronic Acid \n2)Niacinamide \n3) Retinol \n4) Azelaic Acid \n5) Vitamin C \nRecommendations : \n The Ordinary Niacinamide 10% + Zinc 1% , Hada Labo Tokyo Premium Hydrating Lotion , La Roche-Posay Effaclar Serum , Skintific 2% Salicylic Acid Serum , Some By Me Yuja Niacin Serum'
                      ),
                      _buildProductCard(
                        'lib/assets/toner.png',
                        'Toner',
                        '1) Niacinamide \n2) AHA, BHA, PHA \n3) Rose Water \nRecommendations : \nCOSRX AHA/BHA Clarifying Treatment Toner, Paula Choice Skin Perfecting 2% BHA Liquid Exfoliant , Avoskin Miraculous Refining Toner'
                      ),
                      _buildProductCard(
                        'lib/assets/mask.png',
                        'Mask',
                        '1) Clay Mask \n2) Sheet Mask with Niacinamide \n3) Charcoal Mask \nRecommendations : \nThe Ordinary AHA 30% + BHA 2% Peeling Solution , Avoskin Purifying Clay Mask , Some By Me AHA-BHA-PHA 30 Days Miracle Cream'
                      ),
                      _buildProductCard(
                        'lib/assets/pore.png',
                        'Pore Strips',
                        '1) Salicylic Acid \n2) Tea Tree \nRecommendations : \nBiore Deep Cleansing Pore Strips , Breylee blackhead mask , Nose Pore Strips by Kose'
                      ),
                      _buildProductCard(
                        'lib/assets/injection.png',
                        'Treatment',
                        '1) Consult a professional.\n2) Follow the prescribed treatment plan.'
                      ),
                      _buildProductCard(
                        'lib/assets/medicine.png',
                        'Medicine',
                        '1) Take as prescribed by your doctor.\n2) Monitor skin condition and report any issues.'
                      ),
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
                image: AssetImage('lib/assets/what.jpg'),
              ),
            ),
            const Center(
              child: HoverContent(
                titleText: 'Lets Get To Know Types of Acne',
                description:
                    'NODULE \n \nNodules are a more severe form of acne and usually appear as large, hard, inflamed bumps beneath the skin’s surface. Nodules can be painful and usually require medical treatment to avoid scarring. This type of acne forms when hair follicles become clogged with oil and dead skin cells, which then become infected with bacteria. Nodules often take longer to heal than other types of acne.\n  \nPUSTULA \n \nPustules are more common types of acne and are characterized by the presence of pus on top. They usually appear as reddish bumps with a white or yellow center. Pustules form when pores become clogged and infected, causing inflammation. While pustules are less severe than nodules, they can still be painful and require attention to prevent them from bursting and leaving scars.\n  \nBLACKHEAD \n \nBlackheads are a form of non-inflammatory acne that appear as small black or yellow dots on the surface of the skin. Blackheads form when pores become clogged with oil and dead skin cells, but are not infected. The black color of blackheads is caused by oxidation, where oil is exposed to air and changes color. Although blackheads are not painful, they can be an annoying cosmetic problem for many people.\n  \nWHITEHEAD \n \nWhiteheads, on the other hand, are similar to blackheads but are covered by a layer of skin. This makes whiteheads appear as small white or yellow bumps. Whiteheads form when pores become clogged with oil and dead skin cells, but are not exposed to air, so they do not oxidize. While whiteheads are not painful, they can be more difficult to remove than blackheads.',
                 image: AssetImage('lib/assets/acne.jpg'),
              ),
            ),
            const Center(
              child: HoverContent(
                titleText: 'Factors Affecting Acne Growth',
                description:
                    '1) Hormon : \nHormonal changes, especially during puberty, menstruation, or pregnancy, can increase the production of sebum (oil) which clogs pores.\n  \n2) Heredity : \nA family history of acne can increase a person’s risk of developing the condition.\n  \n3) Skin Hygiene : \nPoor hygiene practices, such as not washing your face regularly, can lead to a buildup of oil and dead skin cells, which can contribute to acne.\n  \n4) Diet : \nFoods high in sugar, dairy products, and processed foods can trigger inflammation and increase oil production in the skin.\n  \n5) Stress : \nStress can trigger increased production of hormones such as cortisol, which in turn can increase oil production and worsen acne.\n  \n6) Cosmetic Use : \nSome heavy or oil-based beauty and skincare products can clog pores and cause acne.\n  \n7) Environment : \nExposure to pollution, dust, and dirt can clog pores and increase the risk of acne.\n  \n8) Medications : \nSome medications, especially those containing steroids or lithium, can trigger acne as a side effect.',
                image: AssetImage('lib/assets/factor.jpg'),
              ),
            ),
            const Center(
              child: HoverContent(
                titleText: 'Want Smooth Skin?',
                description:
                    'To effectively overcome the problem of acne, it is crucial to adopt a comprehensive skincare routine tailored to your skin type. Here are some detailed steps and recommendations :\n   \n1. Cleansing \nUse a mild, non-irritating cleanser twice daily to effectively remove excess oil, dirt, and makeup. Opt for products with salicylic acid or tea tree oil to help reduce breakouts without stripping the skin. Avoid harsh ingredients like alcohol and strong fragrances that can irritate and worsen acne.\n  \n2. Exfoliation \nIncorporate chemical exfoliators with alpha hydroxy acids (AHA) or beta hydroxy acids (BHA) into your routine 2-3 times a week to promote cell turnover and unclog pores. If using physical exfoliators, choose gentle options with fine particles to prevent skin irritation.\n  \n3. Moisturizing \nSelect lightweight, oil-free, non-comedogenic moisturizers containing hyaluronic acid or glycerin to provide hydration without clogging pores. Moisturizing is essential for all skin types, as skipping this step can lead to increased oil production and worsen acne.\n  \n4. Treatment Products \nUtilize spot treatments with benzoyl peroxide or salicylic acid directly on active breakouts to reduce inflammation. Consider serums with niacinamide for redness reduction or retinoids to promote cell turnover and prevent clogged pores.\n  \n5. Healthy Diet \nConsume a variety of colorful fruits and vegetables rich in antioxidants and vitamins to support skin health, focusing on foods high in vitamins A, C, and E. Stay hydrated by drinking plenty of water, and limit sugary and processed foods that can trigger acne.\n  \n6. Lifestyle Adjustments \nManage stress through activities like yoga and meditation, as high stress levels can lead to hormonal fluctuations that contribute to acne. Prioritize quality sleep, aiming for 7-9 hours each night to support skin regeneration and overall well-being.',
                image: AssetImage('lib/assets/acne(2).jpg'),
              ),
            ),
            const Center(
              child: HoverContent(
                titleText: 'Unlock the key to flawless, acne free skin!',
                description:
                    'To keep your skin healthy and problem-free, it is important to understand your skin type. Regularly cleansing your face is a crucial first step, followed by diligently exfoliating to remove dead skin cells. Consuming tomatoes is also very beneficial, because it is rich in antioxidants that help maintain healthy skin. In addition, controlling water levels in the body is very important, so exercising and getting enough rest must also be considered. Finally, choosing the right product according to your skin type can be done with the help of the GlowGuide application, which helps find the right product.',
                image: AssetImage('lib/assets/smooth.jpg'),
              ),
            ),
            const Center(
              child: HoverContent(
                titleText: 'Powerful acne solutions!',
                description:
                    'Treating acne effectively requires a combination of the right treatments and healthy habits. First, make sure to wash your face twice a day with a gentle cleanser that’s right for your skin type, so dirt and oil don’t clog your pores. Use products that contain active ingredients like benzoyl peroxide or salicylic acid to help reduce inflammation and prevent breakouts.',
                image: AssetImage('lib/assets/skincare.jpg'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductCard(String imagePath, String productName, String description) {
    return GestureDetector(
      onTap: () {
        _showProductInfoDialog(productName, description);
      },
      child: Card(
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
      ),
    );
  }

void _showProductInfoDialog(String productName, String description) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(productName),
          content: Text(description),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
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