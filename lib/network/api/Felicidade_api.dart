
import 'dart:convert';

import 'package:dio/dio.dart';

import '../../common/utils/shared_pref_utils.dart';
import '../../common/utils/storage_service.dart';
import '../../common/utils/app_constants.dart';
import '../dio/dio_client.dart';

class FelicidadeApi {
  final DioClient dioClient;
  final storageService = StorageService();

  FelicidadeApi({required this.dioClient});

  Future<String> loadPostData(endpoint, body, context) async {
    var encodeData = json.encode(body);
    var reqData = encodeData;
    try {
      final String response = await dioClient.post(endpoint, data: reqData,
          options: Options(headers: {'auth': await getToken()}));
      var finalresponse = response;
      return finalresponse;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> loadMultipartPostData(endpoint, body) async {
    // if (Environment().config!.httpLogs) {
    //   log("RequestData==>${body.toString()}");
    // }

    try {
      final String response = await dioClient.post(endpoint,
          data: body,
          options: Options(headers: {
            'auth': await getToken()
          }));
      var finalresponse = response;
      // if (Environment().config?.httpLogs == true) {
      //   if (Environment().config!.httpLogs) {
      //     log("ResponseData==>${finalresponse}");
      //   }
      // }
      return finalresponse;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> loadGetData(endpoint) async {
    try {
      final String response =
      await dioClient.get(endpoint, options: Options(headers: {
        'auth': await getToken()
      }));
      var finalresponse = response;
      return finalresponse;
    } catch (e) {
      rethrow;
    }
  }





}
