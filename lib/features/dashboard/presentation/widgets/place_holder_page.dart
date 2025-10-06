import 'package:dna_taskflow_prime/core/extension/responsive_extension.dart';
import 'package:flutter/material.dart';

class PlaceholderPage extends StatelessWidget {
  final String title;
  const PlaceholderPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF7F9FC),
      child: Center(
        child: Text(
          'Welcome to the $title section!',
          style: TextStyle(
            fontSize: context.scaleFont(36),
            fontWeight: FontWeight.w300,
            color: Colors.blue.shade700,
          ),
        ),
      ),
    );
  }
}
