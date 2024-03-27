import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../resources/color.dart';
import '../resources/strings.dart';
import 'bounce_button.dart';
import 'common_widgets.dart';
import 'text_widget.dart';

class CommonButton extends StatefulWidget {
  final double? width, height;
  final double? borderRadius;
  final String? text;
  final String? stringAssetName;
  final GestureTapCallback? onTap;
  final bool showLoading;
  final bool isIcon;
  final bool isTrailingIcon;
  final Color? textColor;
  final Color? loaderColor;
  final Color? borderColor;
  final Color? backgroundColor;
  final double? verticalPadding;
  final double? horizontalPadding;
  final double? assetHeight;
  final double? assetWidth;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? buttonPadHorizon;
  final double? buttonPadVertical;
  final double borderWidth;
  final Widget? iconWidget;
  final EdgeInsetsGeometry? buttonMargin;
  final Gradient? gradientColor;
  final List<BoxShadow>? boxShadow;

  const CommonButton(
      {Key? key,
      this.width,
      this.borderRadius,
      this.height,
      this.text,
      this.onTap,
      this.showLoading = false,
      this.textColor,
      this.verticalPadding,
      this.stringAssetName,
      this.isIcon = false,
      this.assetWidth,
      this.loaderColor,
      this.assetHeight,
      this.fontSize,
      this.fontWeight,
      this.horizontalPadding,
      this.borderColor,
      this.backgroundColor,
      this.borderWidth = 1.0,
      this.iconWidget,
      this.buttonMargin,
      this.gradientColor,
      this.boxShadow,
      this.buttonPadHorizon,
      this.buttonPadVertical,
      this.isTrailingIcon = false})
      : super(key: key);

  @override
  State<CommonButton> createState() => _CommonButtonState();
}

class _CommonButtonState extends State<CommonButton> {
  @override
  Widget build(BuildContext context) {
    return BounceButton(
      onTap: widget.showLoading ? null : widget.onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: widget.buttonPadHorizon ?? 0.w, vertical: widget.buttonPadVertical ?? 0.h),
        child: Container(
            width: widget.width ?? MediaQuery.of(context).size.width,
            height: widget.height ?? 52.h,
            margin: widget.buttonMargin,
            decoration: BoxDecoration(
              boxShadow:
                  widget.boxShadow ?? [BoxShadow(blurRadius: 8, spreadRadius: 2, offset: const Offset(0, 4), color: colorBlack.withOpacity(0.5))],
              gradient: widget.gradientColor ?? gradientPrimary,
              color: widget.backgroundColor ?? colorPrimary,
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 90.r),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: widget.verticalPadding ?? 10.h, horizontal: widget.horizontalPadding ?? 12.0),
              child: Center(
                child: widget.showLoading
                    ? commonLoader(color: widget.loaderColor ?? colorWhite, size: 25.h)
                    : widget.isIcon
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                widget.stringAssetName!,
                                height: widget.assetHeight,
                                width: widget.assetWidth,
                              ),
                              widthBox(12.w),
                              TextWidget(
                                text: widget.text ?? '',
                                fontSize: widget.fontSize ?? 18.sp,
                                fontWeight: widget.fontWeight ?? FontWeight.w600,
                                fontFamily: strFontName,
                                color: widget.textColor ?? colorWhite,
                              ),
                            ],
                          )
                        : TextWidget(
                            text: widget.text ?? '',
                            fontSize: widget.fontSize ?? 18.sp,
                            fontWeight: widget.fontWeight ?? FontWeight.w600,
                            fontFamily: strFontName,
                            color: widget.textColor ?? colorWhite,
                          ),
              ),
            )),
      ),
    );
  }
}
