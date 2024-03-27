import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dialog.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:untitled/common_widgets/text_widget.dart';
import '../resources/color.dart';
import '../resources/image.dart';
import 'custom_textformfield.dart';

// ignore: must_be_immutable
class CountryPicker extends StatefulWidget {
  CountryPicker({Key? key, this.controller, this.focusNode, this.focusChange, this.margin, this.onTap, this.autoFocus, this.textInputAction, this.onEditingComplete, this.onChanged, required this.onValuePicked, required this.selectedDialogCountry}) : super(key: key);
  TextEditingController? controller;
  FocusNode? focusNode;
  FocusNode? focusChange;
  final ValueChanged<Country> onValuePicked;
  Country selectedDialogCountry;
  final EdgeInsetsGeometry? margin;
  final GestureTapCallback? onTap;
  final bool? autoFocus;
  final TextInputAction? textInputAction;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onChanged;

  @override
  State<CountryPicker> createState() => _CountryPickerState();
}

class _CountryPickerState extends State<CountryPicker> {
  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: widget.focusChange,
      child: CustomTextField(
        focusNode: widget.focusNode,
        onTap: widget.onTap,
        onEditingComplete: widget.onEditingComplete,
        controller: widget.controller,
        textInputAction: TextInputAction.next,
        hint: 'Phone number',
        textInputType: TextInputType.number,
        autoFocus: widget.autoFocus ?? false,
        onChanged: widget.onChanged,
        // listOfFocusNode: widget.listOfFocusNode,
        // index: widget.index,
        // maxLength: 12,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp("[0-9]")),
          LengthLimitingTextInputFormatter(15),
        ],

        prefixIcon: Padding(
          padding: EdgeInsets.only(right: 6.w),
          child: GestureDetector(
            onTap: _openCountryPickerDialog,
            child: _buildDialogShow(widget.selectedDialogCountry),
          ),
        ),
      ),
    );
  }

  void _openCountryPickerDialog() => showDialog(
        context: context,
        builder: (context) => CountryPickerDialog(
          titlePadding: EdgeInsets.all(8.0.h),
          searchInputDecoration: const InputDecoration(hintText: 'Search...'),
          isSearchable: true,
          title: const Text("Select your country code"),
          onValuePicked: widget.onValuePicked,
          itemBuilder: _buildDialogItem,
        ),
      );

  Widget _buildDialogItem(Country country) => Row(
        children: <Widget>[CountryPickerUtils.getDefaultFlagImage(country), SizedBox(width: 8.h), Text("+${country.phoneCode}"), SizedBox(width: 8.h), Flexible(child: Text(country.name))],
      );

  Widget _buildDialogShow(Country country) => IntrinsicHeight(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(width: 12.h),
            TextWidget(
              text: "+${country.phoneCode}",
              color: color1D1E20.withOpacity(0.6),
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
            ),
            Padding(
                padding: EdgeInsets.only(left: 5.w),
                child: SvgPicture.asset(
                  SVGImg.downArrowIc,
                  height: 24.h,
                  width: 24.w,
                )),
          ],
        ),
      );
}
