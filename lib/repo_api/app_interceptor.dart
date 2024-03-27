import 'dart:io';

import 'package:dio/dio.dart';
import '../resources/strings.dart';
import '../utils/app_utils.dart';
import '../utils/shared_preference_util.dart';

class AppInterceptor extends Interceptor {

  @override
  Future onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    _addCommonHeaders(options);
    return handler.next(options);
  }

  void _addCommonHeaders(RequestOptions options) {
    if (options.extra.containsKey('header')) options.headers['Authorization'] = _getAuthorizationToken();
    if (options.extra.containsKey('language')) options.headers['Accept-Language'] = 'en'; // SharedPreferenceUtil.getString(myLanguageKey);
  }

  String _getAuthorizationToken() {
    // return "Bearer ${(SharedPreferenceUtil.getUserData()?.token ?? '')}";
    return "Bearer ";
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    if (_shouldHandleError(err)) _handleError();
    return handler.next(err);
  }

  bool _shouldHandleError(DioException error) {
    return (
        /*error.type == DioExceptionType.sendTimeout ||
        error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout ||*/

        (error.type == DioExceptionType.unknown && error.error is SocketException) ||
            (error.type == DioExceptionType.badResponse && (error.response?.statusMessage == 'Unauthorized' && error.response?.statusCode == 401)) ||
            (error.type == DioExceptionType.badResponse && (error.message == 'TokenExpired' || error.message == 'Authorization error')));
  }

  void _handleError() {

      AppUtils.commonDialog(
        content: strPleaseLoginToContinue,
        showCloseIcon: true,
        onTapAction: () async {
          // AppUtils.instance.logout();
        },
      );
  }
}
