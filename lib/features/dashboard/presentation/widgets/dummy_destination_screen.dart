import 'package:flutter/material.dart';

// Placeholder screen for navigation targets.
class DummyDestinationScreen extends StatelessWidget {
  final String title;

  const DummyDestinationScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Text(
          'Navigated to: $title Screen',
          style: const TextStyle(fontSize: 20, color: Colors.black87),
        ),
      ),
    );
  }
}
