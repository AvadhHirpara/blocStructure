import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../resources/color.dart';
import '../resources/strings.dart';

class TextWidget extends StatefulWidget {
  final String? text;
  final Color? color;
  final FontStyle? fontStyle;
  final double? fontSize;
  final double? letterSpacing;
  final TextAlign? textAlign;
  final GestureTapCallback? onTap;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final TextOverflow? textOverflow;
  final int? maxLines;
  final double? textHeight;
  final TextStyle? textStyle;
  final TextDecoration? decoration;

  const TextWidget({super.key, this.text, this.color = colorBlack, this.fontSize, this.fontFamily = strFontName,
    this.letterSpacing, this.textAlign, this.onTap, this.fontWeight = FontWeight.normal, this.textOverflow,
    this.maxLines, this.textHeight, this.textStyle, this.decoration, this.fontStyle});

  @override
  TextWidgetState createState() => TextWidgetState();
}

class TextWidgetState extends State<TextWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: widget.onTap,
      child: Text(
        widget.text ?? '',
        textAlign: widget.textAlign ?? TextAlign.left,
        maxLines: widget.maxLines,
        softWrap: true,
      overflow: widget.textOverflow  ,
        style: widget.textStyle ??
            TextStyle(
              color: widget.color ?? color1D1E20,
              height: widget.textHeight,
              fontSize: widget.fontSize ?? 14.sp,
              letterSpacing: widget.letterSpacing,
              decoration: widget.decoration,
              fontFamily: widget.fontFamily ?? strFontName,
              fontWeight: widget.fontWeight,
                fontStyle:   widget.fontStyle
            ),
      ),
    );
  }
}
