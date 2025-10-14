import 'package:dna_taskflow_prime/features/masters/features/staff%20management/presentation/pages/staff_management_page.dart';
import 'package:flutter/material.dart';

class HomeIcon extends StatefulWidget {
  final VoidCallback onPressed;
  const HomeIcon({super.key, required this.onPressed});

  @override
  State<HomeIcon> createState() => HomeIconState();
}

class HomeIconState extends State<HomeIcon> {
  bool isHovering = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      onHover: (hover) {
        setState(() {
          isHovering = hover;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Icon(
          Icons.home_outlined,
          size: 18,
          color: isHovering ? kHoverBlueColor : kDefaultBreadcrumbColor,
        ),
      ),
    );
  }
}
