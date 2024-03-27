import 'package:permission_handler/permission_handler.dart';

import '../resources/strings.dart';
import 'app_utils.dart';

class PermissionManager {
  /* # ----- Check Permission ------------------------- # */
  static Future<bool> isPermissionGranted(Permission permission) async {
    return await permission.isGranted;
  }

  /* # ----- Request Permission ------------------------- # */
  static Future<bool> requestPermission(Permission permission) async {
    var status = await permission.request();
    return status == PermissionStatus.granted;
  }

  /* # ----- Request Permission ------------------------- # */
  static Future<bool> shouldShowRequestRationale(Permission permission) async {
    return await permission.shouldShowRequestRationale;
  }

  /* # ----- Check Multi Permission Method 1 ------------------------- # */
  static Future<bool> multiRequestPermissions(List<Permission> permissions) async {
    Map<Permission, PermissionStatus> statuses = await permissions.request();
    bool allGranted = statuses.values.every((status) => status == PermissionStatus.granted);
    return allGranted;
  }

  /* # ----- Check Multi Permission Method 2 ------------------------- # */
  static Future<bool> hasAllPermissionsGranted(List<Permission> permissions) async {
    return await Future.wait(permissions.map((permission) => isPermissionGranted(permission))).then((granted) => granted.every((isGranted) => isGranted));
  }

  /* # ----- Open App Setting ------------------------- # */
  static Future<void> openAppSetting() async {
    await openAppSettings();
  }

  /* # ----- Check GPS Enable ------------------------- # */
  static Future<bool> gpsLocation() async {
    if (await Permission.locationWhenInUse.serviceStatus.isEnabled) return true;
    return false;
  }

  /*-----------------------------------------------------------*/

  static notificationDialog() {
    // AppUtils.commonDialog(
    //   content: 'Notification permission is required to use this app. Please grant permission to continue. You can enable notification permission in the app settings.',
    //   onTapAction: () async {
    //     SharedPreferenceUtil.putBool(isNotificationPermission, false);
    //     await PermissionManager.openAppSetting();
    //   },
    // );
  }

  static Future<bool> notificationPermission() async {
    var notificationStatus = await Permission.notification.status;
    if (notificationStatus.isGranted) {
      return true;
    } else if (notificationStatus.isPermanentlyDenied) {
      PermissionManager.notificationDialog();
      return false;
    } else {
      await Permission.notification.request();
      return false;
    }
  }

 Future<bool> cameraMicPermissionReq() async {
   bool allPermissionsGranted =
       await PermissionManager.multiRequestPermissions(
       [
         Permission.camera,
         Permission.microphone
       ]);
   if (!allPermissionsGranted) {
     await PermissionManager.cameraAndMicPermissionDialog();
   }
   return allPermissionsGranted;
 }

  static Future cameraAndMicPermissionDialog() async {

      AppUtils.commonDialog(
        content: strPermissionForCameraAndMic,
        onTapAction: () async {
          await PermissionManager.openAppSetting();
        },
        showCloseIcon: true,
      );

  }

  static Future<bool> locationPermission() async {
    var locationStatus = await Permission.locationAlways.status;
    if (locationStatus.isGranted) {
      return true;
    } else if (locationStatus.isPermanentlyDenied) {
      locationDialog();
      return false;
    } else {
      await Permission.locationAlways.request();
      return false;
    }
  }

  static locationDialog() {
    AppUtils.commonDialog(
      content: 'Location permission is required to use this app. Please grant permission to continue. You can enable location permission in the app settings.',
      onTapAction: () async {
        // SharedPreferenceUtil.putBool(isLocationPermission, false);
        await PermissionManager.openAppSetting();
      },
    );
  }

  static Future<bool> commonLocationPermissionCheckerDialog() async {
    await Permission.locationAlways.request().then((value) {
      if (value.isDenied) {
        Permission.locationAlways.request().then((value1) async {
          if (value1.isDenied) {
            await Permission.locationAlways.request();
            return false;
          } else if (value1.isPermanentlyDenied) {
            locationDialog();
            return false;
          } else {
            return true;
          }
        });
      } else if (value.isPermanentlyDenied) {
        locationDialog();
        return false;
      } else {
        return true;
      }
    });
    return false;
  }
}
