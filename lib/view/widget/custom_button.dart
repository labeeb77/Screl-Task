import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;
  final Color color;
  final VoidCallback onPressed;
  final Widget child;

  const CustomButton({super.key, 
    required this.width,
    required this.height,
    required this.borderRadius,
    required this.color,
    required this.onPressed,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(borderRadius),
             boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1), 
              spreadRadius: 2, 
              blurRadius: 5, 
              offset: const Offset(0, 3), 
            ),
          ],
        ),
        alignment: Alignment.center,
        child: child,
      ),
    );
  }
}