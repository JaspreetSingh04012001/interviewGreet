import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class CustomShimmer extends StatelessWidget {
  double? height;
  double? width;
  CustomShimmer({Key? key, required this.height, required this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      duration: const Duration(milliseconds: 1500), //Default value
      // interval: Duration(seconds: 5),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 215, 214, 214),
          borderRadius: BorderRadius.circular(16),
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.black.withOpacity(0.1),
          //     offset: const Offset(8, 20),
          //     blurRadius: 24,
          //   ),
          // ],
        ),
        // width: width - 40,
      ),
    );
  }
}
