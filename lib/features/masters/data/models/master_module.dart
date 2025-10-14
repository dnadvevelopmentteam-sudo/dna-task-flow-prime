import 'package:flutter/material.dart';

class MasterModule {
  final String title;
  final String description;
  final String count;
  final String actionText;
  final IconData icon;
  final Color iconColor;
  final String destination;
  final void Function(BuildContext)? onTap;

  MasterModule({
    required this.title,
    required this.description,
    required this.count,
    required this.actionText,
    required this.icon,
    required this.iconColor,
    required this.destination,
    this.onTap,
  });
}
