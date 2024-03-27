import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:untitled/common_widgets/text_widget.dart';
import '../resources/color.dart';
import '../resources/image.dart';
import '../resources/strings.dart';
import '../utils/app_constants.dart';
import 'custom_textformfield.dart';

bool validateVehiclePlate(String plate) {
  RegExp regex = RegExp(r'^[A-Z]{3}\d[A-Z]\d{2}$');
  return regex.hasMatch(plate);
}

Widget dottedBorderCard({GestureTapCallback? onTapDottedCard}) {
  return GestureDetector(
    onTap: onTapDottedCard,
    child: DottedBorder(
      color: colorD3D1D8,
      borderType: BorderType.RRect,
      radius: Radius.circular(10),
      dashPattern: const [6, 6],
      child: Container(
        height: 90.h,
        width: 90.w,
        decoration: BoxDecoration(
            color: colorF8F8F8, borderRadius: BorderRadius.circular(10)),
        padding: EdgeInsets.only(
          left: 6.w,
          right: 6.w,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              SVGImg.icUploadImage,
              height: 30.h,
              width: 35.w,
            ),
            heightBox(6.h),
            TextWidget(
              text: strUploadImage,
              color: colorBlack,
              fontSize: 11.sp,
              fontWeight: FontWeight.w500,
              textAlign: TextAlign.center,
            ),
            heightBox(2.h),
          ],
        ),
      ),
    ),
  );
}

List<DateTime> generateDateList(int numberOfDays) {
  List<DateTime> dateList = [];
  DateTime currentDate = DateTime.now().add(const Duration(days: 1));
  for (int i = 0; i < numberOfDays; i++) {
    DateTime nextDate = currentDate.add(Duration(days: i));
    dateList.add(nextDate);
  }

  return dateList;
}

class UppercaseTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

class AlphabeticInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final newText = newValue.text.replaceAll(RegExp(r'[^a-zA-Z]'), '');

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}

class OnlyNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final newText = newValue.text.replaceAll(RegExp('[^0-9]'), '');

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}

class NumberDotInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final newText = newValue.text.replaceAll(RegExp('r[^0-9]-.'), '');

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}

Widget heightBox(double height) {
  return SizedBox(height: height);
}

Widget widthBox(double width) {
  return SizedBox(width: width);
}

Widget commonLoader({double? size, Color? color}) {
  return Center(
    child: LoadingAnimationWidget.hexagonDots(
      color: color ?? colorPrimary,
      size: size ?? 48,
    ),
  );
}

Widget screenLoader({double? size, Color? color}) {
  return Center(
    child: LoadingAnimationWidget.hexagonDots(
      color: color ?? colorED2730,
      size: size ?? 48,
    ),
  );
}

Widget paginationLoader({double? size, Color? color}) {
  return Center(
    child: SizedBox(
      height: 30.h,
      child: LoadingAnimationWidget.prograssiveDots(
        color: color ?? colorED2730,
        size: size ?? 56,
      ),
    ),
  );
}

Widget noDataFound({String? text, double? sizeHW}) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          PNGImages.noAuctionFoundImg,
          height: sizeHW ?? 220.h,
          width: sizeHW ?? 220.w,
        ),
        heightBox(20.h),
        TextWidget(
          text: text ?? strNoDataFound,
          fontSize: 20.sp,
          color: color151515,
        )
      ],
    ),
  );
}

Widget searchTextField(
    {TextEditingController? controller,
    ValueChanged<String>? onChange,
    String? hintText,
    Widget? suffixIcon}) {
  return CustomTextField(
    controller: controller,
    hint: hintText ?? strSearch,
    height: 54.h,
    borderRadius: 50.r,
    prefixIcon: Padding(
      padding: const EdgeInsets.all(15),
      child: Image.asset(
        PNGImages.bbSearchIc,
        height: 20.h,
        width: 20.w,
        color: color1D1E20.withOpacity(0.5),
      ),
    ),
    suffixIconWidget: suffixIcon,
    onChanged: onChange,
    borderColor: colorBlack.withOpacity(0.1),
  );
}

Widget profileItems(
    {required String svgImgPath,
    required String title,
    bool? hideLine,
    bool? hideArrow,
    GestureTapCallback? onTap}) {
  return Column(
    children: [
      GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 18.h),
          child: Row(
            children: [
              SvgPicture.asset(svgImgPath),
              widthBox(14.w),
              SizedBox(
                width: 230.w,
                child: TextWidget(
                  text: title,
                  fontSize: 16.sp,
                  maxLines: 2,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Spacer(),
              Visibility(
                visible: !(hideArrow ?? false),
                child: SvgPicture.asset(
                  SVGImg.arrowRightIc,
                  width: 20.w,
                  height: 20.h,
                  colorFilter: ColorFilter.mode(
                      color1D1E20.withOpacity(0.5), BlendMode.srcIn),
                ),
              ),
            ],
          ),
        ),
      ),
      Visibility(
          visible: !(hideLine == true),
          child: lineSeparator(
              size: MediaQuery.of(rootNavigatorKey.currentContext!).size,
              height: 0.4.h)),
    ],
  );
}

Widget lineSeparator(
    {required Size size, double? width, double? height, Color? color}) {
  return Container(
    height: height ?? 1.h,
    width: width ?? size.width,
    color: color ?? colorDDDDDD,
  );
}

Widget tempProfileBorderImg({String? imgAsset, double? radius}) {
  return ClipOval(
    child: Container(
        height: radius ?? 20.h,
        width: radius ?? 20.w,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            // borderRadius: BorderRadius.circular(radius ?? 20.r),
            border: GradientBoxBorder(
              gradient: LinearGradient(colors: fillGradient),
              width: 1.5.w,
            )),
        child: ClipOval(child: Image.asset(imgAsset ?? tempProfileImg1))),
  );
}

Widget liveCountWidget({
  String? countStr,
}) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.h),
          decoration: BoxDecoration(
            boxShadow: const [],
            gradient: gradientPrimary,
            borderRadius: BorderRadius.circular(6.r),
          ),
          child: TextWidget(
            text: strLive,
            fontSize: 10.sp,
            fontWeight: FontWeight.w500,
            color: colorWhite,
          )),
      widthBox(2.w),
      Container(
        height: 16.h,
        width: 30.w,
        decoration: BoxDecoration(
          color: colorBlack.withOpacity(0.3),
          borderRadius: BorderRadius.circular(5.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(SVGImg.personIc),
            widthBox(2.w),
            TextWidget(
              text: countStr ?? '0',
              color: colorWhite,
              fontSize: 10.sp,
              fontWeight: FontWeight.w500,
            )
          ],
        ),
      )
    ],
  );
}

Widget selectedStar(
    {required String starRate,
    double? width,
    paddingHorizon,
    bool? isNeedToShowTxt}) {
  int starRateInt = double.parse(starRate).roundToDouble().toInt();
  return SizedBox(
    height: width ?? 30.h,
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListView.builder(
            itemCount: starRateInt,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(right: paddingHorizon ?? 2.w),
                child: Image.asset(
                  PNGImages.starSelected,
                  height: width ?? 30.h,
                  width: width ?? 30.w,
                ),
              );
            }),
        ListView.builder(
            itemCount: 5 - starRateInt,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(right: paddingHorizon ?? 2.w),
                child: Image.asset(
                  PNGImages.starUnSelected,
                  height: width ?? 30.h,
                  width: width ?? 30.w,
                ),
              );
            }),
        Visibility(visible: (isNeedToShowTxt ?? true), child: widthBox(4.w)),
        Visibility(
          visible: (isNeedToShowTxt ?? true),
          child: TextWidget(
            text: '($starRate)',
            fontWeight: FontWeight.w500,
            fontSize: 9.sp,
            color: colorBlack.withOpacity(0.8),
          ),
        )
      ],
    ),
  );
}

Tab tabBarItemCommon(String text) {
  return Tab(
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
      ),
      child: Align(
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
                fontFamily: strFontName),
          )),
    ),
  );
}

Widget dottedButton(
    {required BuildContext context,
    required String txtBtn,
    GestureTapCallback? onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: DottedBorder(
      borderType: BorderType.RRect,
      radius: Radius.circular(10.r),
      color: colorEB4335,
      strokeWidth: 1.w,
      dashPattern: const [6, 2],
      child: SizedBox(
        height: 45.w,
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              PNGImages.icPlusGradient,
              height: 16.h,
              width: 16.w,
            ),
            widthBox(12.w),
            TextWidget(
              text: txtBtn,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
      ),
    ),
  );
}




Widget dropDownSelectItem({required String title, bool? isSelected}) {
  return Row(
    children: [
      TextWidget(
        text: title,
        color: isSelected == true
            ? color1D1E20.withOpacity(0.9)
            : color1D1E20.withOpacity(0.6),
        fontSize: isSelected == true ? 15.sp : 14.sp,
        fontWeight: isSelected == true ? FontWeight.w500 : null,
      ),
      Spacer(),
      SvgPicture.asset(SVGImg.dropDownArrow)
    ],
  );
}




