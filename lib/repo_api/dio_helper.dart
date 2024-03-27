import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:untitled/repo_api/rest_constants.dart';
import '../resources/strings.dart';
import '../utils/shared_preference_util.dart';
import 'app_interceptor.dart';

class DioHelper {
  static final Dio dio = Dio(BaseOptions(baseUrl: RestConstants.baseUrl, connectTimeout: Duration(seconds: 20), receiveDataWhenStatusError: true));

  static init() {
    dio.interceptors.addAll([PrettyDioLogger(requestHeader: true, requestBody: true, responseBody: true, responseHeader: false, error: true, compact: true, maxWidth: 100), AppInterceptor()]);
  }

  static Future<Response> getData({required String url, Map<String, dynamic>? query, bool isHeader = false}) => dio.get(url, queryParameters: query, options: _requestOptions(isHeader: isHeader));

  static Future<Response> postData({required String url, Map<dynamic, dynamic>? data, FormData? formData, bool isHeader = false, bool isLanguage = true, bool isAllow412 = false}) =>
      dio.post(url, data: formData ?? data, options: _requestOptions(isHeader: isHeader, isLanguage: isLanguage, isAllow412: isAllow412));

  static Future<Response> putData({required String url, required Map<String, dynamic> data, Map<String, dynamic>? query, String lang = strLocaleEn, String? token}) {
    lang = 'en'; //SharedPreferenceUtil.getString(myLanguageKey);
    final headers = {'Accept-Language': lang, 'Authorization': token ?? '', 'Content-Type': 'application/json'};
    dio.options.headers = headers;
    return dio.put(url, queryParameters: query, data: data);
  }

  static Options _requestOptions({bool isHeader = false, bool isLanguage = false, bool isAllow412 = false}) {
    final extraOptions = {if (isHeader) 'header': isHeader, if (isLanguage) 'language': true};

    return Options(
        extra: extraOptions,
        validateStatus: (status) {
          return isAllow412 && status == 412
              ? true
              : status == 200
                  ? true
                  : false;
        });
  }
}
