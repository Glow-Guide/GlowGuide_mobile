import 'package:flutter/material.dart';
import 'package:prototpye_glowguide/widgets/wavyappbar.dart';
import 'package:prototpye_glowguide/widgets/custom_navbar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? username;

  @override
  void initState() {
    super.initState();
    _fetchUsername();
  }

  Future<void> _fetchUsername() async {
    final supabase = Supabase.instance.client;
    final response = await supabase.from('users').select('username');

    setState(() {
      if (response.isNotEmpty) {
        username = response[0]['username'] as String?;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WavyAppbar(),
      bottomNavigationBar: const CustomNavbar(currentIndex: 0),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                textAlign: TextAlign.start,
                'Hello, ${username ?? 'Guest'}! welcome to GlowGuide',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Content(
              titleText: 'What is GlowGuide?',
              text:
                  'GlowGuide is a mobile application that helps you to take care of your skin. It provides you with a personalized skincare routine based on the acne analysis.',
              image: AssetImage('lib/assets/splash.png'),
            ),
            const Content(
              titleText: 'Acne prevention tips',
              text: 'Here are some tips to prevent acne',
             image: AssetImage('lib/assets/splash.png'),
            ),
            const Content(
              titleText: 'Choosing the best skincare products for your acne',
              text: 'With the vast skincare choices available, here are some tips to help you choose the best products for your acne',
             image: AssetImage('lib/assets/splash.png'),
            ),
          ],
        ),
      ),
    );
  }
}

class Content extends StatelessWidget {
  final String text;
  final String titleText;
  final ImageProvider image;

  const Content(
      {super.key,
      required this.text,
      required this.image,
      required this.titleText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromRGBO(219, 205, 197, 0.74),
          borderRadius: BorderRadius.circular(20),
        ),
        height: 200,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                titleText,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      text,
                      softWrap: true,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          image: DecorationImage(
                            image: image,
                            fit: BoxFit.cover,
                          ),
                          border: Border.all(
                            color: Colors.white,
                            width: 10,
                          ),
                        ),
                        height: 100,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
