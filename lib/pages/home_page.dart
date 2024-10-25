import 'package:flutter/material.dart';
import 'package:prototpye_glowguide/widgets/wavyappbar.dart';
import 'package:prototpye_glowguide/widgets/custom_navbar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WavyAppbar(),
      bottomNavigationBar: const CustomNavbar(currentIndex: 0),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            content(),
            content(),
            content(),
            content(),
            content(),
          ],
        ),
      ),
    );
  }
}

class content extends StatelessWidget {
  const content({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(20),
        ),
        height: 200,
        width: double.infinity,
        child: Column(
          children: [
            const Text(
              "lorem ipsum dolor sit amet",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Flexible(
                  child: Text(
                    "lorem ipsum dolor sit amet",
                    softWrap: true,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.white,
                      height: 100,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
