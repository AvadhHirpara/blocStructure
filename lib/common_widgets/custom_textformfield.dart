import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../resources/color.dart';
import '../resources/strings.dart';

class CustomTextField extends StatelessWidget {
  final String? hint;
  final String? labelText;
  final TextStyle? labelTextStyle;
  final String? suffixText;
  final Widget? prefixIcon;
  final Widget? suffixWidget;
  final List<Color>? containerColor;
  final Color? color;
  final Color? cursorColor;
  final Color? hintColor;
  final double? hintFontSize;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? initialValue;
  final bool? readOnly;
  final TextAlign? textAlign;
  final Widget? suffix;
  final TextInputType? textInputType;
  final int? maxLines;
  final bool? isDense;
  final GestureTapCallback? onTap;
  final Function? onTapSuffixIcon;
  final double? height;
  final double? horizontalContentPadding;
  final double? verticalContentPadding;
  final double? textHeight;
  final double? width;
  final double? topPadding;
  final ValueChanged<String>? onFieldSubmitted;
  final FormFieldValidator<String>? validator;
  final int? maxLength;
  final TextInputAction? textInputAction;
  final TextCapitalization? textCapitalization;
  final List<TextInputFormatter>? inputFormatters;
  final bool isShadowEnable;
  final bool isBorderEnable;
  final String? fontFamilyText;
  final String? suffixFontFamilyText;
  final String? fontFamilyHint;
  final FontWeight? fontWeightText;
  final FontWeight? suffixFontWeightText;
  final FontWeight? fontWeightHint;
  final String? suffixIconName;
  final Widget? suffixIconWidget;
  final double? suffixIconHeight;
  final double? suffixIconWidth;
  final bool passwordVisible;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final bool autoFocus;
  final bool expands;
  final double? fontSize;
  final double? suffixFontSize;
  final TextAlignVertical? textAlignVertical;
  final String? counterText;
  final Color? fieldBorderClr;
  final Color? fieldInputClr;
  final Color? borderColor;
  final double? borderRadius;
  final double? contentPadding;
  final double? fieldHorizontalPadding;
  final EdgeInsets? scrollPadding;
  final EdgeInsetsGeometry? containerFieldPadding;
  final List<BoxShadow>? boxShadow;

  const CustomTextField(
      {super.key,
      this.hint,
      this.suffixText,
      this.labelText,
      this.labelTextStyle,
      this.suffixWidget,
      this.containerColor,
      this.expands = false,
      this.autoFocus = false,
      this.prefixIcon,
      this.color,
      this.controller,
      this.borderColor,
      this.textAlignVertical,
      this.fieldInputClr,
      this.focusNode,
      this.initialValue,
      this.readOnly,
      this.textAlign,
      this.suffix,
      this.textInputType,
      this.maxLines = 1,
      this.isDense,
      this.onTap,
      this.scrollPadding,
      this.height,
      this.onFieldSubmitted,
      this.verticalContentPadding,
      this.horizontalContentPadding,
      this.validator,
      this.maxLength,
      this.cursorColor,
      this.textInputAction,
      this.inputFormatters,
      this.width,
      this.hintColor,
      this.hintFontSize,
      this.isBorderEnable = true,
      this.isShadowEnable = false,
      this.fontFamilyText,
      this.suffixFontFamilyText,
      this.suffixFontWeightText,
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
      this.fontSize,
      this.suffixFontSize,
      this.fieldBorderClr,
      this.borderRadius,
      this.textHeight,
      this.fieldHorizontalPadding,
      this.containerFieldPadding,
      this.boxShadow,
      this.textCapitalization,
      this.topPadding,
      this.contentPadding});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: fieldHorizontalPadding ?? 20.w),
      child: Container(
        height: height ?? 58.h,
        width: width,
        padding: EdgeInsets.only(top: topPadding ?? 4.h),
        decoration: BoxDecoration(
            boxShadow: boxShadow,
            color: color ?? colorECECEC.withOpacity(0.6),
            borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
            border: Border.all(color: borderColor ?? Colors.transparent)),
        child: Align(
          alignment: Alignment.center,
          child: TextFormField(
            textAlignVertical: textAlignVertical,
            autofocus: autoFocus,
            inputFormatters: inputFormatters,
            textInputAction: textInputAction,
            validator: validator,
            onTap: onTap,
            scrollPadding: scrollPadding ?? const EdgeInsets.all(20.0),
            textCapitalization: textCapitalization ?? TextCapitalization.none,
            // obscuringCharacter: '*',
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
            style: TextStyle(
                color: fieldInputClr ?? color1D1E20,
                fontSize: fontSize ?? 15.sp,
                fontFamily: fontFamilyText ?? strFontName,
                fontWeight: fontWeightText ?? FontWeight.w500,
                height: textHeight),
            cursorColor: cursorColor ?? color1D1E20,
            onChanged: onChanged,
            onEditingComplete: onEditingComplete,
            decoration: InputDecoration(
              enabled: true,
              counterText: counterText ?? "",
              isDense: isDense ?? true,
              labelText: labelText,
              hintText: hint,
              labelStyle: labelTextStyle ??
                  TextStyle(
                    color: hintColor ?? color1D1E20.withOpacity(0.6),
                    fontSize: 16.sp,
                    fontFamily: fontFamilyHint ?? strFontName,
                    fontWeight: fontWeightHint ?? FontWeight.w400,
                  ),
              counterStyle: TextStyle(
                color: color1D1E20,
                fontSize: suffixFontSize ?? 14.sp,
                fontFamily: suffixFontFamilyText ?? strFontName,
                fontWeight: suffixFontWeightText ?? FontWeight.w400,
              ),
              prefixIcon: prefixIcon,
              focusColor: Colors.black12,
              suffixText: suffixText,
              suffix: suffix,
              suffixStyle: TextStyle(
                color: color1D1E20,
                fontSize: suffixFontSize ?? 14.sp,
                fontFamily: suffixFontFamilyText ?? strFontName,
                fontWeight: suffixFontWeightText ?? FontWeight.w400,
              ),
              // focusedBorder: OutlineInputBorder(
              //   borderSide: BorderSide(
              //       color: fieldBorderClr ?? Colors.transparent, width: 2.0),
              //   borderRadius: BorderRadius.circular(borderRadius ?? 16.0),
              // ),
              suffixIcon: suffixIconWidget ??
                  (suffixIconName != null
                      ? Padding(
                          padding: EdgeInsets.all(12),
                          child: SvgPicture.asset(suffixIconName!, width: suffixIconWidth, height: suffixIconHeight),
                        )
                      : null),
              contentPadding: EdgeInsets.symmetric(horizontal: horizontalContentPadding ?? 12.w, vertical: verticalContentPadding ?? 8.h),
              hintStyle: TextStyle(
                color: hintColor ?? color1D1E20.withOpacity(0.6),
                fontSize: hintFontSize ?? 16.sp,
                fontFamily: fontFamilyHint ?? strFontName,
                fontWeight: fontWeightHint ?? FontWeight.w400,
              ),
              filled: true,
              fillColor: Colors.transparent,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(borderRadius ?? 16.0), borderSide: BorderSide.none),
            ),
          ),
        ),
      ),
    );
  }
}
