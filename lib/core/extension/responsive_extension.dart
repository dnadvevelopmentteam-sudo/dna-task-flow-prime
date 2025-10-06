
import 'package:flutter/material.dart';

extension ResponsiveTextExtension on BuildContext {
  double get screenWidth => MediaQuery.sizeOf(this).width;

  // Base mobile width for scaling comparison
  static const double mobileBreakpoint = 600;
  static const double desktopBreakpoint = 900;

  // Scales the font size based on screen width, with a minimum size limit.
  double scaleFont(double baseSize) {
    if (screenWidth >= mobileBreakpoint) {
      // Use the base size on tablet/desktop
      return baseSize;
    }
    // Calculate scale factor: ScreenWidth / MobileBreakpoint.
    // Clamp it to prevent font sizes from shrinking below 85% of the base size.
    final double scaleFactor = (screenWidth / mobileBreakpoint).clamp(
      0.85,
      1.0,
    );
    return baseSize * scaleFactor;
  }

  // Helper to determine if we are in mobile view for layout adjustments
  bool get isMobile => screenWidth < mobileBreakpoint;
  bool get isDrawerMode => screenWidth < desktopBreakpoint;
}

extension WidgetListExtension on List<Widget> {
  // Utility extension to easily add spacing between Row children
  List<Widget> withSpacing(double space) {
    if (isEmpty) return [];
    List<Widget> list = [];
    for (int i = 0; i < length; i++) {
      list.add(this[i]);
      if (i < length - 1) {
        list.add(SizedBox(width: space));
      }
    }
    return list;
  }
}