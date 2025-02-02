import 'package:dio/dio.dart';

import '../constant/endpoints.dart';

class DioClient {
  // dio instance
  final Dio _dio;

  // injecting dio instance
  DioClient(this._dio) {
    _dio
      ..options.baseUrl = Endpoints.baseUrl
      ..options.connectTimeout = const Duration(seconds: Endpoints.connectionTimeout)
      ..options.receiveTimeout = const Duration(seconds: Endpoints.receiveTimeout)
      ..options.responseType = ResponseType.plain
      ..interceptors.add(LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
      ));
  }

  // Get:-----------------------------------------------------------------------
  Future<String> get(
      String url, {
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onReceiveProgress,
      }) async {
    var encryption =  0;

    try {
      final Response response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: options?.copyWith(
            contentType: (encryption == 1)
                ? Headers.textPlainContentType
                : Headers.jsonContentType),
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  // Post:----------------------------------------------------------------------
  Future<String> post(
      String uri, {
        data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
      }) async {
    var encryption =  0;
    // if (encryption == 0)

    // print("encryption---$encryption");

    try {
      final Response response = await _dio.post(
        uri,
        data: data,
        // queryParameters: queryParameters,
        // queryParameters: data,
        options: options?.copyWith(
            contentType: (encryption == 1)
                ? Headers.textPlainContentType
                : Headers.jsonContentType),
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  // Put:-----------------------------------------------------------------------
  Future<Response> put(
      String uri, {
        data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
      }) async {
    try {
      var encryption =  0;

      final Response response = await _dio.put(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options?.copyWith(
            contentType: (encryption == 1)
                ? Headers.textPlainContentType
                : Headers.jsonContentType),
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Delete:--------------------------------------------------------------------
  Future<dynamic> delete(
      String uri, {
        data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
      }) async {
    try {
      final Response response = await _dio.delete(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}