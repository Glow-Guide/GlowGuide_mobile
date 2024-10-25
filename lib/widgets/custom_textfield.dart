import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String labelText;
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;

  const CustomTextField(
      {super.key,
      required this.labelText,
      required this.controller,
      required this.hintText,
      required this.obscureText});

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        controller: widget.controller,
        obscureText: _obscureText,
        decoration: InputDecoration(
          
          labelText: widget.labelText,
          hintText: widget.hintText,
          labelStyle: const TextStyle(color: Colors.black),
          filled: true,
          fillColor: const Color.fromRGBO(214, 192, 179, 0.6),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
          suffixIcon: widget.obscureText
              ? IconButton(
                  icon: Icon(
                    _obscureText
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                  onPressed: _toggleObscureText,
                )
              : null, // Only show icon for password fields
        ),
      ),
    );
  }
}
