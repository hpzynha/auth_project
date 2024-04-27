import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum FieldType {
  email,
  password,
}

class MyTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final bool showVisibilityIcon;
  final bool validateEmail;
  final Widget icon;
  final FieldType fieldType;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.showVisibilityIcon,
    required this.obscureText,
    required this.validateEmail,
    required this.icon,
    required this.fieldType,
  });

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  late bool _obscureText;
  late FocusNode _focusNode;
  bool _showError = false;
  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _showError = widget.controller.text.isEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    String errorText = '';
    // Determine the error message based on the field type
    if (_showError) {
      switch (widget.fieldType) {
        case FieldType.email:
          errorText = 'Email is required';
          break;
        case FieldType.password:
          errorText = 'Password is required';
          break;
      }
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: widget.controller,
        obscureText: _obscureText,
        focusNode: _focusNode,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
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
          errorText: _showError ? errorText : null,
          hintStyle: TextStyle(color: Colors.grey[500]),
        ),
        keyboardType: widget.validateEmail
            ? TextInputType.emailAddress
            : null, // Set keyboard type to email if email validation is enabled
        inputFormatters: widget.validateEmail
            ? [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9@._]'))]
            : null, // Add input formatter to deny non-email inputs if email validation is enabled,
      ),
    );
  }
}
