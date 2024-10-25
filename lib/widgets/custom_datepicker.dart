import 'package:flutter/material.dart';

class CustomDatePicker extends StatefulWidget {
  final String labelText;

  const CustomDatePicker({super.key, required this.labelText});

  @override
  _CustomDatePickerState createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  DateTime? _selectedDate;
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Set the initial date to current date
      firstDate: DateTime(1900), // Set the earliest date that can be picked
      lastDate: DateTime.now(), // Set the latest date to today
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        readOnly: true, // Make the field read-only
        onTap: () => _selectDate(context), // Show date picker on tap
        decoration: InputDecoration(
          labelText: widget.labelText,
          hintText: _selectedDate == null
              ? "Select your birth date"
              : "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}", // Show selected date
          filled: true,
          fillColor: const Color.fromRGBO(214, 192, 179, 1),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
