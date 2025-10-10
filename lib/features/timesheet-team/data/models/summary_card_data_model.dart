import 'package:flutter/material.dart';

class SummaryCardData {
  final String title;
  final String value;
  final String description;
  final IconData? icon;
  final Color? iconColor;
  final Widget? indicator;

  SummaryCardData({
    required this.title,
    required this.value,
    required this.description,
    this.icon,
    this.iconColor,
    this.indicator,
  });
}
