import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../resources/color.dart';

class NetworkImageWidget extends StatelessWidget {
  final double height, width;
  final String? imageUrl;
  final BoxDecoration? boxDecoration;
  final BorderRadius? borderRadius;
  final BoxBorder? border;

  const NetworkImageWidget({Key? key, required this.width, required this.height, this.boxDecoration, this.borderRadius, this.imageUrl, this.border}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl ?? '',
      imageBuilder: (context, imageProvider) => Container(
        height: height,
        width: width,
        decoration: boxDecoration ??
            (borderRadius != null
                ? BoxDecoration(
                    color: colorPrimary,
                    shape: BoxShape.rectangle,
                    border: border,
                    borderRadius: borderRadius,
                    image: DecorationImage(image: imageProvider, fit: BoxFit.fill),
                  )
                : BoxDecoration(
                    color: colorPrimary,
                    border: border,
                    shape: BoxShape.circle,
                    image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                  )),
      ),
      placeholder: (context, url) => Shimmer.fromColors(
        highlightColor: Colors.grey[100]!,
        baseColor: Colors.grey[300]!,
        period: const Duration(seconds: 2),
        child: Container(
          height: height,
          width: width,
          decoration: borderRadius != null
              ? BoxDecoration(
                  color: Colors.grey[400]!,
                  shape: BoxShape.rectangle,
                  borderRadius: borderRadius,
                )
              : BoxDecoration(
                  color: Colors.grey[400]!,
                  shape: BoxShape.circle,
                ),
        ),
      ),
      errorWidget: (context, url, error) => SizedBox(height: height, width: width, child: const Icon(Icons.error)),
    );
  }
}
