import 'package:flutter/material.dart';

class SquareTitle extends StatelessWidget {
  final Widget widget;
  final Function()? onTap;
  const SquareTitle({super.key, required this.widget, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(16),
          color: Colors.grey[200],
        ),
        child: widget,
      ),
    );
  }
}
