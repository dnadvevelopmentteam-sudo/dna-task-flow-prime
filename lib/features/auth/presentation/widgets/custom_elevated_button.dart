import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.foregroundColor = Colors.white,
    this.verticalPadding = 16.0,
    this.borderRadius = 8.0,
    this.fontSize = 16.0,
    this.fontWeight = FontWeight.bold,
  });

  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color foregroundColor;
  final double verticalPadding;
  final double borderRadius;
  final double fontSize;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {

    final Color defaultColor = Colors.blue.shade800;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? defaultColor,
          padding: EdgeInsets.symmetric(vertical: verticalPadding),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          elevation: 0,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: foregroundColor,
          ),
        ),
      ),
    );
  }
}
