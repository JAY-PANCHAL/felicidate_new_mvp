import 'package:get/get.dart';

import '../common/service_locator.dart';
import '../common/utils/storage_service.dart';
import '../network/api/Felicidade_repository.dart';

class BaseController extends GetxController {
  var isLoading = false.obs;
  final StorageService storageService = StorageService();
  final repo = getIt.get<FelicidadeRepository>();

}
