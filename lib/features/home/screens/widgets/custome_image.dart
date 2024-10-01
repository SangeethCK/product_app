import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

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
          ? Center(
              child: Image.asset(
                (url ?? 'assets/icons/92f1ea7dcce3b5d06cd1b1418f9b9413 3.png'),
                fit: fit,
                width: width,
                height: height,
                cacheHeight: cacheHeight,
                cacheWidth: cacheWidth,
              ),
            )
          : Builder(
              builder: (context) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: CachedNetworkImage(
                      imageUrl: url ?? '',
                      fit: BoxFit.fill,
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
                              child: Icon(
                                Icons.image_not_supported,
                                color: Colors.grey.shade500,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
