import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mechinetest/shared/consrants/colors.dart';

class AppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppbarWidget({
    super.key,
    this.title,
    this.logo = false,
    this.centerTitle = false,
    this.actions = const [],
    this.color,
    this.iconColor,
    this.actionTitle,
    this.shadow = false,
    this.hideLeading = false,
  });

  final String? title, actionTitle;
  final bool logo, shadow, centerTitle;
  final List<Widget> actions;
  final Color? color, iconColor;
  final bool hideLeading;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(
        size: 20,
      ),
      backgroundColor: color,
      elevation: shadow ? null : 0,
      leadingWidth: logo ? 22.w : null,
      shape: Border(
          bottom: BorderSide(
              color: shadow ? kBlack26 : kTransparentColor, width: 0.25)),
      leading: hideLeading
          ? const SizedBox()
          : logo
              ? Transform.scale(
                  scale: 1,
                  child: SvgPicture.asset(''),
                )
              : Navigator.canPop(context)
                  ? IconButton(
                      onPressed: () {
                        Navigator.maybePop(context);
                      },
                      icon: const Icon(Icons.arrow_back_ios),
                    )
                  : null,
      titleSpacing: Navigator.canPop(context) == true ? 0 : null,
      title: title != null
          ? Text(
              title!,
            )
          : null,
      centerTitle: centerTitle,
      actions: actionTitle != null
          ? [
              Center(
                child: Text(
                  actionTitle!,
                ),
              ),
            ]
          : actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
