import 'package:flutter/material.dart';

class RegisterGender extends StatefulWidget {
  const RegisterGender({super.key});

  @override
  _RegisterGenderState createState() => _RegisterGenderState();
}

class _RegisterGenderState extends State<RegisterGender> {
  String? selectedGender;

  @override
  Widget build(BuildContext context) {
    // double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(228, 224, 225, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(228, 224, 225, 1),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "What is your gender?",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: screenWidth * 0.95,
                  height:
                      screenWidth * 0.95, // Ensure the container is a circle
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromRGBO(214, 192, 179, 0.6),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedGender = 'male';
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 15),
                        backgroundColor: selectedGender == 'male'
                            ? Colors.blue
                            : Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        'Male',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedGender = 'female';
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 15),
                        backgroundColor: selectedGender == 'female'
                            ? Colors.pink
                            : Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        'Female',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/home',
                      (Route<dynamic> route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    backgroundColor: const Color.fromRGBO(91, 56, 12, 0.74),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'Register',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
