import 'dart:io';
import 'dart:math';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:untitled/utils/shared_preference_util.dart';
import '../common_widgets/common_dialog.dart';
import '../resources/color.dart';
import 'app_constants.dart';
import 'slide_left_route.dart';
import 'package:timeago/timeago.dart' as timeago;

class AppUtils {
  AppUtils._privateConstructor();

  static final AppUtils instance = AppUtils._privateConstructor();


  static Future<String?> getDeviceId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
      SharedPreferenceUtil.putValue(strDeviceIdKey, '${iosDeviceInfo.identifierForVendor}${DateTime.now().microsecond}');
      return '${iosDeviceInfo.identifierForVendor}${DateTime.now().microsecond}'; // unique ID on iOS
    } else {
      AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
      SharedPreferenceUtil.putValue(strDeviceIdKey, '${androidDeviceInfo.id}${DateTime.now().microsecond}');
      return '${androidDeviceInfo.id}${DateTime.now().microsecond}'; // unique ID on Android
    }
  }

  void goBack() {
    Navigator.pop(rootNavigatorKey.currentContext!);
  }

  void pushReplacement({required Widget enterPage, bool shouldUseRootNavigator = false}) {
    ScaffoldMessenger.of(rootNavigatorKey.currentContext!).hideCurrentSnackBar();
    Navigator.of(rootNavigatorKey.currentContext!, rootNavigator: shouldUseRootNavigator).pushReplacement(
      SlideLeftRoute(page: enterPage),
    );
  }

  void push({required Widget enterPage, bool shouldUseRootNavigator = false, Function? callback, BuildContext? context}) {
    ScaffoldMessenger.of(context ?? rootNavigatorKey.currentContext!).hideCurrentSnackBar();
    FocusScope.of(context ?? rootNavigatorKey.currentContext!).requestFocus(FocusNode());
    Navigator.of(context ?? rootNavigatorKey.currentContext!, rootNavigator: shouldUseRootNavigator).push(SlideLeftRoute(page: enterPage)).then((value) {
      callback?.call(value);
    });
  }

  Future<dynamic> pushForResult(BuildContext context, {required Widget enterPage, bool shouldUseRootNavigator = false}) {
    return Navigator.of(context, rootNavigator: shouldUseRootNavigator).push(
      SlideLeftRoute(page: enterPage),
    );
  }

  void pushAndClearStack({required Widget enterPage, bool shouldUseRootNavigator = false}) {
    ScaffoldMessenger.of(rootNavigatorKey.currentContext!).hideCurrentSnackBar();
    Navigator.of(rootNavigatorKey.currentContext!, rootNavigator: shouldUseRootNavigator).pushAndRemoveUntil(SlideLeftRoute(page: enterPage), (Route<dynamic> route) => false);
  }

  Widget commonLoader({double? size, Color? color}) {
    return Center(child: LoadingAnimationWidget.hexagonDots(color: color ?? colorPrimary, size: size ?? 50));
  }

  String getErrorMessage(dynamic error) {
    return error is DioException
        ? error.type == DioExceptionType.connectionTimeout || error.type == DioExceptionType.receiveTimeout || error.type == DioExceptionType.sendTimeout
            ? 'Couldn\'t connect to the server'
            : error.error is SocketException
                ? 'Check Internet Connection'
                : error.response != null && error.response!.data != null
                    ? error.response!.data!["message"]
                    : "An unknown error occurred"
        : "An unknown error occurred";
  }

  /// Get Permission ///
  static Future<bool> handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;
    var location = Location();
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      bool isServiceEnable = false;
      location.requestService().then((value) async {
        isServiceEnable = await location.serviceEnabled();
      });

      showError(message: 'Location services are disabled. Please enable the services');
      return isServiceEnable;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        showError(message: 'Location permissions are denied');
        Future.delayed(Duration(seconds: 2)).then((value) {
          openAppSettings();
        });
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Future.delayed(Duration(seconds: 2)).then((value) {
        openAppSettings();
      });
      showError(message: 'Location permissions are permanently denied, we cannot request permissions.');
      return false;
    }
    return true;
  }

  double randomGen(int min, int max) {
    return double.tryParse('${min + Random().nextInt(max - min)}') ?? 0;
  }

  String utcToLocalDDMonthYY({String? dateString}) {
    if (dateString != null) {
      DateTime utcDateTime = DateTime.parse(dateString);
      DateTime localDateTime = utcDateTime.toLocal();
      return DateFormat("dd MMM yyyy").format(localDateTime).toString();
    } else {
      return '';
    }
  }

  String convertSecondToDateTimeUtc(int? milliSecond) {
    if (milliSecond != null) {
      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(milliSecond, isUtc: true);

      final dateDifference = DateTime.now().difference(dateTime);
      final timeAgoFormat = DateTime.now().subtract(Duration(
        minutes: dateDifference.inMinutes,
      ));
      String timeShow = timeago.format(timeAgoFormat, locale: 'en_short') != 'now' ? '${timeago.format(timeAgoFormat, locale: 'en_short')}' : timeago.format(timeAgoFormat, locale: 'en_short');
      return timeShow;
    } else {
      return '';
    }
  }

  String convertYYMMDDtoDDMMYY({String? dateString}) {
    if (dateString != null) {
      DateTime utcDateTime = DateTime.parse(dateString);
      DateTime localDateTime = utcDateTime.toLocal();
      return DateFormat("dd/MM/yyyy").format(localDateTime).toString();
    } else {
      return '';
    }
  }

  String convertDateToDDMMYYYYHHFormat1({String? dateString}) {
    if (dateString != null) {
      DateTime parseDate = DateFormat("yyyy-MM-ddTHH:mm:ss").parse(dateString, true).toLocal();
      DateTime dt = parseDate;
      String date = DateFormat("dd MMM yyyy hh:mm a").format(dt).toString();
      return date;
    } else {
      return '';
    }
  }

  String? timeUTC24To12HourFormat({String? timeString, dateString}) {
    String to24HrFormat2 = '';

    if (timeString != null && dateString != null) {
      final String dateTimeString = dateString + " " + timeString + '.000000Z';
      DateTime to24HrFormat = DateTime.parse(dateTimeString).toLocal();
      to24HrFormat2 = DateFormat("hh:mm a").format(to24HrFormat);
    }
    return to24HrFormat2;
  }

  static void commonDialog({required String content, required Function onTapAction, bool showCloseIcon = false}) {
    showDialog(
      barrierDismissible: false,
      context: rootNavigatorKey.currentContext!,
      barrierColor: color8E8E8E.withOpacity(0.5),
      builder: (context) => PopScope(
        canPop: false,
        onPopInvoked: (isPop) {
          if (isPop == false) {
            return;
          }
        },
        child: CustomDialog(
          content: content,
          onTap: () async {
            Navigator.of(context, rootNavigator: true).pop();
            onTapAction();
          },
          showCloseIcon: showCloseIcon,
        ),
      ),
    );
  }

  static String getDeviceTypeID() {
    return Platform.isAndroid ? androidDevice : iosDevice;
  }
}

void showError({String? message, Color? messageColor}) => Fluttertoast.showToast(
      msg: message ?? '',
      backgroundColor: messageColor ?? colorFF0000,
      gravity: ToastGravity.TOP,
    );

void showSuccess({String? message, Color? messageColor}) => Fluttertoast.showToast(
      msg: message ?? '',
      backgroundColor: messageColor ?? colorGreen,
      gravity: ToastGravity.TOP,
    );
