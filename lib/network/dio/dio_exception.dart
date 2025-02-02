import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../common/utils/shared_pref_utils.dart';
import '../../routes/app_pages.dart';
import '../api/Felicidade_api.dart';

class DioExceptions implements Exception {
  late String message;

  DioExceptions.fromDioError(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.cancel:
        message = "Request to API server was cancelled";
        break;
      case DioErrorType.connectionTimeout:
        message = "Connection timeout with API server";
        break;
      case DioErrorType.receiveTimeout:
        message = "Receive timeout in connection with API server";
        break;
      case DioErrorType.badResponse:
        var decrypedMsg =
        jsonDecode(dioError.response.toString());
        message = _handleError(
          dioError.response?.statusCode,
          decrypedMsg,
        );
        //Opps authontication failed by defaut logout
        if (message == "Unauthorized") {
          onLogout();
          Get.offNamedUntil(Routes.splash, (route) => false);
        }
        break;
      case DioErrorType.sendTimeout:
        message = "Send timeout in connection with API server";
        break;
      case DioErrorType.unknown:
        if (dioError.error is SocketException) {
          message = 'No Internet';
          break;
        }
        message = "Unexpected error occurred";
        break;
      default:
        message = "Something went wrong";
        break;
    }
  }

  String _handleError(int? statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
        return error['message'] ?? 'Bad request';
      case 401:
        return error['message'] ?? 'Unauthorized';
      case 403:
        return error['message'] ?? 'Forbidden';
      case 404:
        return error['message'] ?? 'Oops something went wrong';
      case 500:
        return error['message'] ?? "Internal server error";
      case 502:
        return 'Bad gateway';
      default:
        return error['message'] ?? 'Oops something went wrong';
    }
  }

  @override
  String toString() => message;
}
