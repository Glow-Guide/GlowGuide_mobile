import 'package:flutter/material.dart';
import 'package:prototpye_glowguide/widgets/wavyappbar.dart';
import 'package:prototpye_glowguide/widgets/custom_navbar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WavyAppbar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
             Container(
              margin:EdgeInsets.all(16),
              color: const Color.fromARGB(255, 214, 204, 166),
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Hi GlowFriends!!!"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.people,
                        size: 50,
                      ),
                      Text("Hello First"),
                      Icon(Icons.edit)
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 200,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(
                    255, 174, 163, 129), // Warna coklat muda
                padding: EdgeInsets.symmetric(
                    horizontal: 30, vertical: 15), // Ukuran padding
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      10), // Membuat sudut tombol melengkung
                ),
              ),
              onPressed: () {
                // Aksi saat tombol ditekan
                print('Tombol Register ditekan');
              },
              child: Text(
                'Register',
                style: TextStyle(
                  fontSize: 18, // Ukuran teks
                  color: Colors.white, // Warna teks
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomNavbar(currentIndex: 3),
    );
  }
}
