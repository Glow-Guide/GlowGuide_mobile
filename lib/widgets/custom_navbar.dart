import 'package:flutter/material.dart';

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
    return BottomNavigationBar(
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey,
      onTap: onTabTapped,
      currentIndex: widget.currentIndex,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history),
          label: 'History',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.camera_alt),
          label: 'Camera',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}
