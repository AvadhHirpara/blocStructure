import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:untitled/common_widgets/text_widget.dart';
import '../resources/color.dart';
import '../resources/image.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? iconImage;
  final String? prefixTextName, prefixIcon;
  final bool? shouldShowBackButton;
  final bool? showLogoTitle;
  final PreferredSizeWidget? bottom;
  final bool? isPrefixIcon;
  final Widget? leading;
  final Widget? prefixWidget;
  final bool automaticallyImplyLeading;
  final GestureTapCallback? onTapPrefix;
  final GestureTapCallback? onPressBack;
  final Color? statusBarColor, backgroundColor, textColor;
  final GestureTapCallback? onTapAction;
  final double? toolbarHeight, titleSpacing;
  final Brightness? statusBarIconBrightness;
  final Brightness? statusBarBrightness;
  final bool? centerTitle;
  final Widget? flexibleSpace;
  final Widget? titleWidget;

  const CommonAppBar(
      {super.key,
      this.title,
      this.shouldShowBackButton = true,
      this.showLogoTitle = false,
      this.bottom,
      this.isPrefixIcon,
      this.prefixIcon,
      this.prefixTextName,
      this.toolbarHeight,
      this.onTapPrefix,
      this.iconImage,
      this.onPressBack,
      this.automaticallyImplyLeading = true,
      this.leading,
      this.statusBarColor,
      this.prefixWidget,
      this.backgroundColor,
      this.textColor,
      this.onTapAction,
      this.statusBarBrightness,
      this.centerTitle = true,
      this.flexibleSpace,
      this.titleSpacing,
      this.statusBarIconBrightness,
      this.titleWidget});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: statusBarIconBrightness ?? Brightness.dark,
          systemNavigationBarColor: Colors.transparent,
          statusBarBrightness: statusBarBrightness ?? Brightness.light,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
        backgroundColor: backgroundColor ?? colorWhite,
        surfaceTintColor: Colors.transparent,
        // elevation: 5.0,
        // shadowColor: colorWhite.withOpacity(0.1),
        automaticallyImplyLeading: automaticallyImplyLeading,
        toolbarHeight: toolbarHeight ?? 56.h,
        title: titleWidget ??
            ((showLogoTitle ?? false)
                ? Image.asset(
                    PNGImages.imgLogoTextTrans,
                    height: 45.h,
                    width: 120.w,
                  )
                : Padding(
                    padding: const EdgeInsets.only(bottom: 1.0),
                    child: iconImage ??
                        TextWidget(
                          text: title ?? '',
                          color: textColor ?? colorBlack,
                          fontWeight: FontWeight.w600,
                          fontSize: 18.sp,
                        ),
                  )),
        titleSpacing: titleSpacing ?? 0,
        centerTitle: centerTitle,
        leading: (shouldShowBackButton ?? true)
            ? leading ??
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: onPressBack ??
                      () {
                        if (Navigator.canPop(context)) Navigator.pop(context);
                      },
                  child: Container(
                    height: 40.h,
                    width: 40.w,
                    margin: const EdgeInsets.only(left: 20),
                    padding: const EdgeInsets.only(right: 2),
                    child: SvgPicture.asset(
                      SVGImg.icBack,
                      height: 40.h,
                      width: 40.w,
                    ),
                  ),
                )
            : Container(),
        leadingWidth: 55,
        actions: [
          prefixTextName != null
              ? GestureDetector(
                  onTap: onTapPrefix,
                  child: Container(
                    margin: EdgeInsets.only(right: 15.w),
                    padding: const EdgeInsets.only(right: 5, left: 5, top: 0),
                    child: TextWidget(
                      text: prefixTextName,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      onTap: onTapAction,
                    ),
                  ),
                )
              : prefixIcon != null
                  ? GestureDetector(
                      onTap: onTapAction,
                      child: Container(
                        margin: const EdgeInsets.only(
                          right: 22,
                          bottom: 5,
                        ), // padding:  EdgeInsets.only(right: 5, left),
                        child: SvgPicture.asset(prefixIcon!),
                      ),
                    )
                  : prefixWidget ?? const SizedBox.shrink(),
        ],
        bottom: bottom,
        flexibleSpace: flexibleSpace);
  }

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight ?? 50.h);
}
