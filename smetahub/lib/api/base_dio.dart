// Package imports:
import 'package:dio/dio.dart';
import 'package:smetahub/core/utils/constants.dart';

/// Синглтон Dio, для работы с сетью
class BaseDio {
  factory BaseDio() => _singleton;

  BaseDio._internal();

  static final BaseDio _singleton = BaseDio._internal();

  final Dio dio = Dio(
    BaseOptions(
      baseUrl: Constants.baseUrl,
    ),
  )..interceptors.add(
      LogInterceptor(requestBody: true, responseBody: true),
    );

  // void setToken({String? token}) {
  //   if (token == null) {
  //     dio.options.headers.remove('Authorization');
  //   } else {
  //     dio.options.headers = <String, dynamic>{'Authorization': 'Bearer $token'};
  //   }
  // }
}
