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


}
