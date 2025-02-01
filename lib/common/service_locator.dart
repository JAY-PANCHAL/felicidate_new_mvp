
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../network/api/Felicidade_api.dart';
import '../network/api/Felicidade_repository.dart';
import '../network/dio/dio_client.dart';


final getIt = GetIt.instance;

Future<void> setup() async {

  getIt.registerSingleton(Dio());
  getIt.registerSingleton(DioClient(getIt<Dio>()));
  getIt.registerSingleton(FelicidadeApi(dioClient: getIt<DioClient>()));
  getIt.registerSingleton(FelicidadeRepository(getIt.get<FelicidadeApi>()));
  // getIt.registerSingleton(HomeController());
}
