import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';

class CustomNavbar extends StatefulWidget {
  final int currentIndex;
  const CustomNavbar({Key? key, required this.currentIndex}) : super(key: key);

  @override
  _CustomNavbarState createState() => _CustomNavbarState();
}

class _CustomNavbarState extends State<CustomNavbar> {
  void onTabTapped(int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/history');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/camera');
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      backgroundColor: const Color.fromRGBO(161, 140, 90, 1.0), // RGB equivalent of Color(0xFFA18C5A)
      onTap: onTabTapped,
index: widget.currentIndex,
      items:const  [
        CurvedNavigationBarItem(child: Icon(Icons.home), label: 'Home',),
        CurvedNavigationBarItem(child: Icon(Icons.history), label: 'History',),
        CurvedNavigationBarItem(child: Icon(Icons.camera_alt), label: 'Camera',),
        CurvedNavigationBarItem(child: Icon(Icons.person), label: 'Profile',),
      ],
     
    );
  }
}
