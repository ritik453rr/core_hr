import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../constants/assets.dart';

/// A reusable cached network image with rounded corners, placeholder, and error fallback.
class AppNetworkImage extends StatelessWidget {
  final String imgUrl;
  final double height;
  final double width;
  final double borderRadius;
  final BoxFit fit;
  final Widget Function(BuildContext, String)? placeholder;
  final Widget Function(BuildContext, String, dynamic)? errorWidget;

  const AppNetworkImage({
    super.key,
    this.imgUrl = "",
    this.height = 125,
    this.width = 125,
    this.borderRadius = 12,
    this.fit = BoxFit.cover,
    this.placeholder,
    this.errorWidget,
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
        placeholder: placeholder ??
            (context, url) => ClipRRect(
                  borderRadius: BorderRadius.circular(height / 2),
                  child: Container(
                    height: height,
                    width: width,
                    color: Colors.grey.shade100,
                  ),
                ),
        errorWidget: errorWidget ??
            (context, url, error) => Image.asset(
                  Assets.pngTriangleInsetHey,
                  height: height,
                  width: width,
                  fit: fit,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: height,
                    width: width,
                    color: Colors.grey.shade200,
                    child: const Icon(
                      Icons.image_not_supported_outlined,
                      color: Colors.grey,
                    ),
                  ),
                ),
      ),
    );
  }
}

typedef CommonNetworkImage = AppNetworkImage;
