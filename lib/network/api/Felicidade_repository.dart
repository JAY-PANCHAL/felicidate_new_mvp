import 'package:dio/dio.dart';

import '../../common/utils/storage_service.dart';
import '../constant/endpoints.dart';
import '../dio/dio_exception.dart';
import '../model/token_model.dart';

import '../model/user_model.dart';
import 'Felicidade_api.dart';

class FelicidadeRepository {
  final FelicidadeApi oeHealthApi;
  final storageService = StorageService();

  FelicidadeRepository(this.oeHealthApi);

  Future<TokenModelClass> getToken(params) async {
    try {
      final response = await oeHealthApi.loadGetData(Endpoints.token, params,null);
      //return ConfigModel.fromJson(response.data);
      return TokenModelClass.fromJson(response.data);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<UserModel> getUserDetails(userid,usertype,token) async {
    try {
      final response = await oeHealthApi.loadGetData("${Endpoints.getUser}/${userid.toString()}/${usertype.toString()}",null,token);
      //return ConfigModel.fromJson(response.data);
      return UserModel.fromJson(response.data);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
}
