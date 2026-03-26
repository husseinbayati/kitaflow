import 'package:flutter/material.dart';
import '../constants/design_tokens.dart';

/// Responsive Breakpoint Helpers.
enum Breakpoint { mobile, tablet, desktop }

abstract final class ScreenBreakpoints {
  static double width(BuildContext context) => MediaQuery.sizeOf(context).width;

  static bool isMobile(BuildContext context) =>
      width(context) < DesignTokens.breakpointMobile;

  static bool isTablet(BuildContext context) =>
      width(context) >= DesignTokens.breakpointMobile &&
      width(context) < DesignTokens.breakpointTablet;

  static bool isDesktop(BuildContext context) =>
      width(context) >= DesignTokens.breakpointTablet;

  static bool isTabletOrAbove(BuildContext context) =>
      width(context) >= DesignTokens.breakpointMobile;

  static Breakpoint current(BuildContext context) {
    final w = width(context);
    if (w < DesignTokens.breakpointMobile) return Breakpoint.mobile;
    if (w < DesignTokens.breakpointTablet) return Breakpoint.tablet;
    return Breakpoint.desktop;
  }

  // Constraint-basiert (für LayoutBuilder)
  static Breakpoint fromConstraints(BoxConstraints constraints) {
    if (constraints.maxWidth < DesignTokens.breakpointMobile) return Breakpoint.mobile;
    if (constraints.maxWidth < DesignTokens.breakpointTablet) return Breakpoint.tablet;
    return Breakpoint.desktop;
  }
}
