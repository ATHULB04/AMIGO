import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class FrostedGlassBox extends StatelessWidget {
  const FrostedGlassBox(
      {super.key,
      required this.width,
      required this.height,
      required this.child});

  final double width;
  final double height;
  // ignore: prefer_typing_uninitialized_variables
  final child;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.sp),
      child: Container(
        width: width.w,
        height: height.h,
        color: Colors.transparent,
        child: Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.sp),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.13),
                    ),
                    gradient: LinearGradient(colors: [
                      Colors.white.withOpacity(0.15),
                      Colors.white.withOpacity(0.05)
                    ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
              ),
            ),
            Center(
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}
