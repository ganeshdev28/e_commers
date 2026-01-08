import 'package:flutter/material.dart';

class AppResponsive {
  final BuildContext context;
  late final Size _size;

  AppResponsive(this.context) {
    _size = MediaQuery.of(context).size;
  }
  double get width => _size.width;
  double get height => _size.height;

  bool get isMobile => width < 600;
  bool get isTablet => width >= 600 && width < 1024;
  bool get isDesktop => width >= 1024;

  double value({required double mobile, double? tablet, double? desktop}) {
    if (isDesktop && desktop != null) return desktop;
    if (isTablet && tablet != null) return tablet;
    return mobile;
  }

  double font(double size) {
    if (isDesktop) return size * 1.2;
    if (isTablet) return size * 1.1;
    return size;
  }
}
