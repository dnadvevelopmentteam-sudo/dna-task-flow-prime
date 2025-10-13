import 'package:flutter/material.dart';

class LeaderboardContent extends StatelessWidget {
  final String title;
  final String failureMessage;

  const LeaderboardContent({
    super.key,
    required this.title,
    required this.failureMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFEEEEEE)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF333333),
            ),
          ),
          const Divider(height: 25, thickness: 1, color: Color(0xFFEEEEEE)),
          Text(
            failureMessage,
            style: const TextStyle(fontSize: 14, color: Color(0xFF757575)),
          ),
        ],
      ),
    );
  }
}
