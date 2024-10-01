import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mechinetest/shared/constants/colors.dart';
import 'package:mechinetest/shared/routes/navigator.dart';
import 'package:mechinetest/shared/themes/font_palette.dart';

void kSnackBar({
  required String content,
  double? height,
  Color color = kWhite,
  IconData? icon,
  int duration = 1000,
  bool error = false,
  bool success = false,
  bool warning = false,
  bool delete = false,
  bool update = false,
  bool floating = false,
  bool infinite = false,
  SnackBarAction? action,
}) {
  ScaffoldMessenger.of(navigatorKey.currentContext!).hideCurrentSnackBar();

  ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
    SnackBar(
      content: SizedBox(
        height: height,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null)
              Icon(
                icon,
                color: kWhite,
                size: 18.sp,
              )
            else
              error == true
                  ? Icon(
                      Icons.error_outline,
                      color: kWhite,
                      size: 18.sp,
                    )
                  : success == true
                      ? Icon(
                          Icons.done,
                          color: kWhite,
                          size: 18.sp,
                        )
                      : delete == true
                          ? Icon(
                              Icons.delete,
                              color: kWhite,
                              size: 18.sp,
                            )
                          : update == true
                              ? Icon(
                                  Icons.update,
                                  color: kWhite,
                                  size: 18.sp,
                                )
                              : const SizedBox.shrink(),
            5.horizontalSpace,
            Flexible(
              child: Text(
                content,
                softWrap: false,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: FontPalette.urbenist14.copyWith(
                  color: kWhite,
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: error
          ? kRedColor
          : success
              ? kGreenColor
              : warning
                  ? kWarningColor
                  : delete
                      ? kRedColor
                      : update
                          ? kBlueColor1
                          : color,
      duration:
          infinite ? const Duration(days: 1) : Duration(milliseconds: duration),
      behavior: floating ? SnackBarBehavior.floating : SnackBarBehavior.fixed,
      action: action,
    ),
  );
}

closeSnack() {
  ScaffoldMessenger.of(navigatorKey.currentContext!).hideCurrentSnackBar();
}
