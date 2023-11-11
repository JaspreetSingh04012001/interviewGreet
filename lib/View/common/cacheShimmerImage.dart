import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class CacheShimmerImage extends StatelessWidget {
  String url;
  double? width;
  double? height;
  EdgeInsetsGeometry? margin;
  AlignmentGeometry? alignment;
  BoxDecoration? boxDecoration;
  BoxFit? fit;
  CacheShimmerImage(
      {Key? key,
      required this.url,
      this.height,
      this.fit,
      this.width,
      this.margin,
      this.alignment,
      this.boxDecoration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageBuilder: (context, imageProvider) => Container(
        clipBehavior: Clip.none,
        height: height,
        width: width,
        margin: margin,
        decoration: boxDecoration?.copyWith(
            image: DecorationImage(
                image: imageProvider,
                fit: fit ?? BoxFit.cover,
                alignment: alignment ?? Alignment.center)),
      ),
      imageUrl: url,
      placeholder: (context, url) => Shimmer(
        duration: const Duration(milliseconds: 1500), //Default value
        // interval: Duration(seconds: 5),
        child: Container(
          height: height,
          width: width,
          decoration: boxDecoration,
          // width: width - 40,
        ),
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
