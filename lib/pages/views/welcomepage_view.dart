import 'package:flutter/material.dart';
import 'package:typewritertext/typewritertext.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(228, 224, 225, 100),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'lib/assets/welcome.jpg', 
              fit:
                  BoxFit.cover, 
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: screenHeight * 0.57,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text('GlowGuide',
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TypeWriter.text(
                  'Est enim irure aute elit quis labore eiusmod in cillum. Minim pariatur id elit id dolor commodo irure in officia esse. Non occaecat reprehenderit minim ullamco non incididunt.',
                  duration: const Duration(milliseconds: 50),
                  style:
                      const TextStyle(color: Color.fromARGB(219, 95, 42, 42)),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(96, 51, 12, 74),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
                    elevation: 5, 
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(20), 
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  child: const Center(
                    child: Text(
                      "LOGIN",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: const BorderSide(color: Colors.black, width: 2),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/register');
                  },
                  child: const Center(
                    child: Text(
                      "REGISTER",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}