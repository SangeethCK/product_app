import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mechinetest/shared/constants/colors.dart';

class CustomImage extends StatelessWidget {
  const CustomImage({
    super.key,
    required this.url,
    this.appendBaseUrl = true,
    this.width,
    this.height,
    this.cacheWidth,
    this.cacheHeight,
    this.borderRadius = BorderRadius.zero,
    this.placeHolder,
    this.local = false,
    this.fit = BoxFit.cover,
    this.isLoading = false,
  });

  final String? url;
  final bool local;
  final String? placeHolder;
  final double? width, height;
  final int? cacheWidth, cacheHeight;
  final BorderRadius borderRadius;
  final BoxFit? fit;
  final bool appendBaseUrl;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: local
          ? Image.asset(
              (url ?? ''),
              fit: fit,
              width: width,
              height: height,
              cacheHeight: cacheHeight,
              cacheWidth: cacheWidth,
            )
          : Builder(
              builder: (context) {
                return CachedNetworkImage(
                  imageUrl: url ?? '',
                  fit: fit,
                  width: width,
                  height: height,
                  memCacheWidth: cacheWidth?.toInt(),
                  memCacheHeight: cacheHeight?.toInt(),
                  errorWidget: (context, error, stackTrace) {
                    if (placeHolder != null) {
                      return Image.asset(
                        placeHolder!,
                        fit: BoxFit.cover,
                        width: width,
                        height: height,
                        cacheHeight: cacheHeight,
                        cacheWidth: cacheWidth,
                      );
                    }
                    return SizedBox(
                      width: width,
                      height: height,
                      child: FittedBox(
                        fit: BoxFit.fitHeight,
                        child: Transform.scale(
                          scale: .6,
                          child: const Icon(
                            Icons.image_not_supported,
                            color: kBlack,
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
