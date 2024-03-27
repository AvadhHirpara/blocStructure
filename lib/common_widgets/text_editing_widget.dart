import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../resources/color.dart';
import '../resources/strings.dart';

class TextEditingWidget extends StatelessWidget {
  final String? hint, initialValue, fontFamilyText, fontFamilyHint, counterText, prefixIconName;
  final Widget? prefixIcon;
  final Color? color, textColor;
  final Color? hintColor, prefixIcColor;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool? readOnly;
  final TextAlign? textAlign;
  final Widget? suffixIcon;
  final TextInputType? textInputType;
  final int? maxLines;
  final bool? isDense, isFocusBorder;
  final GestureTapCallback? onTap;
  final GestureTapCallback? onTapSuffixIcon;
  final double? height;
  final double? width;
  final ValueChanged<String>? onFieldSubmitted;
  final FormFieldValidator<String>? validator;
  final int? maxLength;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final bool isShadowEnable;
  final bool enabled;
  final bool isBorderEnable;
  final FontWeight? fontWeightText;
  final FontWeight? fontWeightHint;
  final String? suffixIconName;
  final Widget? suffixIconWidget;
  final double? suffixIconHeight, suffixIconWidth;
  final bool passwordVisible;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final bool autoFocus;
  final bool expands;
  final double? fontSize, hintSize, borderRadius, contentPaddingHorizontal, contentPaddingVertical, textHeight;
  final BoxConstraints? prefixIconConstraints;
  final TextCapitalization textCapitalization;
  final TextStyle? counterStyle;

  const TextEditingWidget(
      {super.key,
      this.hint,
      this.hintSize,
      this.enabled = true,
      this.expands = false,
      this.autoFocus = false,
      this.prefixIconConstraints,
      this.prefixIconName,
      this.prefixIcon,
      this.color,
      this.controller,
      this.focusNode,
      this.isFocusBorder,
      this.initialValue,
      this.readOnly,
      this.textAlign,
      this.suffixIcon,
      this.textInputType,
      this.maxLines = 1,
      this.isDense,
      this.onTap,
      this.height,
      this.onFieldSubmitted,
      this.validator,
      this.maxLength,
      this.textInputAction,
      this.inputFormatters,
      this.width,
      this.hintColor,
      this.isBorderEnable = true,
      this.isShadowEnable = true,
      this.fontFamilyText,
      this.fontFamilyHint,
      this.fontWeightHint,
      this.fontWeightText,
      this.suffixIconName,
      this.suffixIconHeight,
      this.suffixIconWidth,
      this.onTapSuffixIcon,
      this.passwordVisible = false,
      this.suffixIconWidget,
      this.onChanged,
      this.onEditingComplete,
      this.counterText,
      this.borderRadius,
      this.fontSize,
      this.contentPaddingHorizontal,
      this.contentPaddingVertical,
      this.textCapitalization = TextCapitalization.none,
      this.prefixIcColor,
      this.textColor,
      this.counterStyle,
      this.textHeight});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(borderRadius ?? 14.0)),
      child: TextFormField(
        autofocus: autoFocus,
        inputFormatters: inputFormatters,
        textCapitalization: textCapitalization,
        textInputAction: textInputAction,
        validator: validator,
        onTap: onTap,
        obscureText: passwordVisible,
        maxLength: maxLength,
        controller: controller,
        focusNode: focusNode,
        onFieldSubmitted: onFieldSubmitted,
        initialValue: initialValue,
        readOnly: readOnly ?? false,
        maxLines: maxLines,
        textAlign: textAlign ?? TextAlign.left,
        keyboardType: textInputType,
        expands: expands,
        autocorrect: false,

        autovalidateMode: AutovalidateMode.always,
        style: TextStyle(
          color: textColor ?? color1D1E20,
          fontSize: fontSize ?? 14.sp,
          height: textHeight,
          fontFamily: fontFamilyText ?? strFontName,
          fontWeight: fontWeightText ?? FontWeight.w400,
        ),
        onChanged: onChanged,
        onEditingComplete: onEditingComplete,
        decoration: InputDecoration(
          enabled: enabled,
          counterText: counterText ?? "",
          counterStyle: counterStyle,
          isDense: isDense ?? isDense,
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(borderRadius ?? 10.r), borderSide: const BorderSide(color: colorTransparent)),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(borderRadius ?? 10.r), borderSide: const BorderSide(color: colorTransparent)),
          disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(borderRadius ?? 10.r), borderSide: const BorderSide(color: colorTransparent)),
          prefixIcon: prefixIconName != null
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 30.w,
                    height: 30.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: colorWhite, borderRadius: BorderRadius.circular(10)),
                    child: SvgPicture.asset(prefixIconName!, height: 14.h, width: 14.w,   ),
                  ),
                )
              : prefixIcon,
          suffixIcon: suffixIconWidget ??
              (suffixIconName != null
                  ? GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: onTapSuffixIcon,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: SvgPicture.asset(suffixIconName!),
                      ))
                  : null),
          hintText: hint!,
          errorMaxLines: 2,
          contentPadding: EdgeInsets.symmetric(horizontal: contentPaddingHorizontal ?? 18, vertical: contentPaddingVertical ?? 18),
          hintStyle: TextStyle(
            color: hintColor ?? color1D1E20.withOpacity(0.6),
            fontSize: hintSize ?? 14.sp,
            fontFamily: fontFamilyHint ?? strFontName,
            fontWeight: fontWeightHint ?? FontWeight.w400,
          ),

          filled: true,
          prefixIconConstraints: prefixIconConstraints,
          fillColor: color ?? colorWhite,
          // border: OutlineInputBorder(borderRadius: BorderRadius.circular(borderRadius ?? 16.r), borderSide: BorderSide.none),
        ),
      ),
    );
  }
}
