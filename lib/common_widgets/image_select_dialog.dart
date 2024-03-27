import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:untitled/common_widgets/text_widget.dart';
import '../resources/color.dart';
import '../resources/image.dart';
import '../resources/strings.dart';
import 'common_dialog.dart';

class ImageSelectDialog {
  static final ImagePicker _picker = ImagePicker();
  static bool isProgress = false;

  static Future<dynamic> onImageSelection({int? imageCount, required BuildContext mainContext, List<CropAspectRatioPreset>? aspectRatioCrop}) async {
    isProgress = false;
    return showDialog(
        context: mainContext,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  (9).r,
                ),
              ),
            ),
            child: StatefulBuilder(builder: (context, StateSetter setStateNew) {
              return SizedBox(
                height: (140).h,
                // width: (950).w,
                child: Center(
                  child: /*isProgress
                      ? const CircularProgressIndicator(
                          strokeWidth: 3,
                          color: Colors.blue,
                        )
                      : */
                      Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      getDialogButtons(SVGImg.galleryPickerIc, strGallery, ImageSource.gallery, (isPr) {
                        setStateNew(() {
                          isProgress = isPr;
                        });
                      }, imageCount, context, aspectRatioCrop),
                      SizedBox(width: (11).w),
                      Container(
                        height: (85).h,
                        width: (1).w,
                        color: Colors.grey,
                      ),
                      SizedBox(width: (11).w),
                      getDialogButtons(SVGImg.cameraPickerIc, strCamera, ImageSource.camera, (isPr) {
                        setStateNew(() {
                          isProgress = isPr;
                        });
                      }, imageCount, context, aspectRatioCrop)
                    ],
                  ),
                ),
              );
            }),
          );
        });
  }

  static Widget getDialogButtons(
      String icon, String title, ImageSource imageSource, OnShowProgress setState, int? imageQuantity, BuildContext context,
      [List<CropAspectRatioPreset>? aspectRatioCrop]) {
    return GestureDetector(
      onTap: () async {
        // Navigator.pop(context);
        PermissionStatus permissionStatus = PermissionStatus.denied;

        if (imageSource == ImageSource.gallery && Platform.isAndroid) {
          final androidInfo = await DeviceInfoPlugin().androidInfo;
          if (androidInfo.version.sdkInt <= 32) {
            await Permission.storage.request();
          } else {
            await Permission.photos.request();
          }
          if (Platform.isAndroid) {
            if (androidInfo.version.sdkInt <= 32) {
              permissionStatus = await Permission.storage.status;
            } else {
              permissionStatus = await Permission.photos.status;
            }
          }
          // SharedPreferenceUtil.putString(kGalleryPermission, "$permissionStatus");
          if (permissionStatus.isDenied) {
            if (androidInfo.version.sdkInt <= 32) {
              await Permission.storage.request();
            } else {
              await Permission.photos.request();
            }

            if (permissionStatus.isDenied) {
              if (!context.mounted) return;
              showDialog(
                  barrierDismissible: true,
                  context: context,
                  barrierColor: Colors.transparent, // space around dialog

                  builder: (context) => PopScope(
                        canPop: true,
                        child: CustomDialog(
                          content: "Gallery disabled, Allow permission to access the storage in your device setting",
                          onTap: () async {
                            Navigator.pop(context);
                            openAppSettings();
                          },
                          showCloseIcon: false,
                        ),
                      ));
            }
          } else if (permissionStatus.isPermanentlyDenied) {
            if (!context.mounted) return;
            showDialog(
                barrierDismissible: true,
                context: context,
                barrierColor: Colors.transparent, // space around dialog

                builder: (context) => PopScope(
                      canPop: true,
                      child: CustomDialog(
                        content: "Gallery disabled, Allow permission to access the storage in your device setting",
                        onTap: () async {
                          Navigator.pop(context);
                          openAppSettings();
                        },
                        showCloseIcon: false,
                      ),
                    ));
          } else {
            // pickImage(imageSource, setState, imageQuantity);
          }
//////////////////////////////////////
          if (androidInfo.version.sdkInt <= 32) {
            await Permission.storage.request();
          } else {
            await Permission.photos.request();
          }
          if (await Permission.photos.request().isGranted || await Permission.storage.request().isGranted) {
            if (!context.mounted) return;
            pickImage(imageSource, setState, imageQuantity, context, aspectRatioCrop);
          }
        } else {
          if (await Permission.camera.request().isGranted || Platform.isIOS) {
            if (!context.mounted) return;
            pickImage(imageSource, setState, imageQuantity, context, aspectRatioCrop);
          } else {
            if (!context.mounted) return;
            showDialog(
                barrierDismissible: true,
                context: context,
                barrierColor: Colors.transparent, // space around dialog

                builder: (context) => PopScope(
                      canPop: true,
                      child: CustomDialog(
                        content: "Camera disabled, Allow permission to access the camera in your device setting",
                        onTap: () async {
                          Navigator.pop(context);
                          openAppSettings();
                        },
                        showCloseIcon: false,
                      ),
                    ));
          }
          // pickImage(imageSource, setState, imageQuantity, context);
        }
      },
      // controller: null,
      child: SizedBox(
        width: (120).w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(height: 8.h),
            Container(
              height: 70.w,
              width: 70.w,
              decoration: BoxDecoration(shape: BoxShape.circle, color: colorWhite),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: SvgPicture.asset(icon),
              ),
            ),
            SizedBox(height: 8.h),
            Flexible(
              child: TextWidget(
                text: title,
                color: color1D1E20,
                fontSize: 18.sp,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static pickImage(ImageSource imageSource, OnShowProgress setState1, int? imageQuantity, BuildContext context,
      [List<CropAspectRatioPreset>? aspectRatioCrop]) async {
    try {
      setState1.call(true);
      if (imageSource == ImageSource.gallery && imageQuantity != null) {
        List<XFile>? image = await _picker.pickMultiImage(
          maxWidth: 800,
          maxHeight: 800,
          imageQuality: 60,
        );

        if (image.isNotEmpty) {
          setState1.call(false);
          if (!context.mounted) return;
          Navigator.pop(context , image);
        } else {
          setState1.call(false);
          if (!context.mounted) return;
          Navigator.pop(context);
        }
      } else {
        XFile? image = await _picker.pickImage(
          source: imageSource,
          maxWidth: 800,
          maxHeight: 800,
          imageQuality: 60,
        );

        if (image != null) {
          if (!context.mounted) return;
          _cropImage(image, setState1, imageQuantity, context, aspectRatioCrop);
        } else {
          setState1.call(false);
          if (!context.mounted) return;
          Navigator.pop(context);
        }
      }
    } on PlatformException {
      setState1.call(false);
      if (!context.mounted) return;
      Navigator.pop(context);
    }
  }

  static Future _cropImage(imageFile, OnShowProgress setState, imageQuantity, BuildContext context,
      [List<CropAspectRatioPreset>? aspectRatioCrop]) async {
    if (imageFile != null) {
      CroppedFile? cropped = await ImageCropper().cropImage(
          sourcePath: imageFile!.path,
          aspectRatioPresets: aspectRatioCrop ??
              [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9
              ],
          uiSettings: [
            AndroidUiSettings(
                toolbarTitle: 'Crop', cropGridColor: Colors.black, initAspectRatio: CropAspectRatioPreset.original, lockAspectRatio: false),
            IOSUiSettings(title: 'Crop')
          ]);

      if (cropped != null) {
        imageFile = File(cropped.path);
        setState.call(false);
        if (imageQuantity != null) {
          XFile xFileCamera = XFile(imageFile.path);
          List<XFile>? listCameraFile = [];
          listCameraFile.add(xFileCamera);
          if (!context.mounted) return;
          Navigator.pop(context, listCameraFile);
        } else {
          if (!context.mounted) return;
          Navigator.pop(context, imageFile.path);
        }
      }
    } else {
      Navigator.pop(context);
    }
  }
}

typedef OnShowProgress = void Function(bool showProgress);
