import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../resources/color.dart';
import '../resources/image.dart';
import '../resources/strings.dart';
import 'common_button.dart';
import 'text_widget.dart';

class CustomDialog extends StatelessWidget {
 final String? content;
 final GestureTapCallback? onTap;
 final GestureTapCallback? onTapClose;
 final bool? showCloseIcon;

 const CustomDialog({Key? key, required this.content, this.onTap, this.onTapClose, this.showCloseIcon = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 5,

      backgroundColor: colorWhite,
      insetPadding: const EdgeInsets.symmetric(
        horizontal: 25.0,
      ),
      child: _buildDialogContent(context),
    );
  }

  Widget _buildDialogContent(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        // color: color7C7C7C.withOpacity(.1),

        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[


          Visibility(
            visible: showCloseIcon == true,
            child: Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.close , color: colorBlack,size: 24.sp, ),
                  )),
            ),
          ),
          Image.asset(
            PNGImages.appNameLogo,
            height: 100,
            width: 100,
          ),

          Align(
            alignment: Alignment.center,
            child: TextWidget(
              text: content,
              color: colorBlack,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          CommonButton(
            text: strGoIt,
            width: MediaQuery.of(context).size.width * 0.3,
            verticalPadding: 12,
            onTap: onTap,

          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
