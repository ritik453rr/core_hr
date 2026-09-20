import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../shimmer/app_shimmer.dart';

/// A reusable cached network image with rounded corners, placeholder, and error fallback.
class AppNetworkImage extends StatelessWidget {
  final String imgUrl;
  final double height;
  final double width;
  final double borderRadius;
  final BoxFit fit;

  const AppNetworkImage({
    super.key,
    this.imgUrl = '',
    this.height = 42,
    this.width = 42,
    this.borderRadius = 12,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: CachedNetworkImage(
        imageUrl: imgUrl,
        height: height,
        width: width,
        fit: fit,
        placeholder: (context, url) => AppShimmer(
          child: Bone(
            width: width,
            height: height,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        errorWidget: (context, url, error) => const Center(
          child: Icon(Icons.person, size: 40, color: Colors.grey),
        ),
      ),
    );
  }
}
