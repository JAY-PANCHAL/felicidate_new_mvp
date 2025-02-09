import 'package:dio/dio.dart';

import '../../common/utils/storage_service.dart';
import '../constant/endpoints.dart';
import '../dio/dio_exception.dart';
import '../model/token_model.dart';

import '../model/user_model.dart';
import 'Felicidade_api.dart';

class   FelicidadeRepository {
  final FelicidadeApi oeHealthApi;
  final storageService = StorageService();

  FelicidadeRepository(this.oeHealthApi);


  Future<String> loginRequested(params, context) async {
    try {
      final response = await oeHealthApi.loadPostData(
          Endpoints.login,params, context);
      return response;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }


}
