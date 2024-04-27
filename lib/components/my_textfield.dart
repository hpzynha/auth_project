import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final bool showVisibilityIcon;
  final bool validateEmail;
  final Widget icon;
  const MyTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.showVisibilityIcon,
      required this.obscureText,
      required this.validateEmail,
      required this.icon});

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  late bool _obscureText;
  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: widget.controller,
        obscureText: _obscureText,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          fillColor: Colors.grey.shade200,
          filled: true,
          hintText: widget.hintText,
          prefixIcon: widget.icon,
          suffixIcon: widget
                  .showVisibilityIcon //Check if the icon should be shown
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility))
              : null,
          hintStyle: TextStyle(color: Colors.grey[500]),
        ),
        keyboardType: widget.validateEmail
            ? TextInputType.emailAddress
            : null, // Set keyboard type to email if email validation is enabled
        inputFormatters: widget.validateEmail
            ? [
                FilteringTextInputFormatter.deny(
                    RegExp(r'[^\s@]+@[^\s@]+\.[^\s@]+'))
              ]
            : null, // Add input formatter to deny non-email inputs if email validation is enabled,
      ),
    );
  }
}
