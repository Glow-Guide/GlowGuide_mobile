import 'package:flutter/material.dart';
import 'package:prototpye_glowguide/widgets/custom_navbar.dart';
import 'package:horizontal_calendar/horizontal_calendar.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          HorizontalCalendar(
            date: DateTime.now(),
            textColor: Colors.white,
            backgroundColor: Color.fromRGBO(161, 140, 90, 1),
            selectedColor: Color.fromRGBO(96, 51, 12, 0.79),
            // showMonth: true,
            onDateSelected: (date) {
              // Handle date selection
            },
          ),
         const SizedBox(height: 50,),
          // Add more widgets here as needed
          const ListTile(
            title: Text('Item 1', style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('Subtitle 1'),
            trailing: Text("10:00 AM"),
          ),
          const ListTile(
            title: Text('Item 1', style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('Subtitle 1'),
            trailing: Text("10:00 AM"),
          ),
          const ListTile(
            title: Text('Item 1', style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('Subtitle 1'),
            trailing: Text("10:00 AM"),
          ),
          const ListTile(
            title: Text('Item 1', style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('Subtitle 1'),
            trailing: Text("10:00 AM"),
          ),
        ],
      ),
      bottomNavigationBar: const CustomNavbar(currentIndex: 1),
    );
  }
}