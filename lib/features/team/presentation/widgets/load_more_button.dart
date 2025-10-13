import 'package:flutter/material.dart';

class LoadMoreButton extends StatefulWidget {
  const LoadMoreButton({super.key});

  @override
  State<LoadMoreButton> createState() => _LoadMoreButtonState();
}

class _LoadMoreButtonState extends State<LoadMoreButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          backgroundColor: _isHovered ? Colors.blue.shade50 : Colors.white,
          side: BorderSide(
            color: _isHovered ? Colors.blue : Colors.grey.shade300,
            width: 1.0,
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        ),
        child: Text(
          'Load More Entries',
          style: TextStyle(
            color: _isHovered ? Colors.blue : Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
