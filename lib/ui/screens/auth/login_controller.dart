import 'dart:async';
import 'package:felicidade/common/utils/shared_pref_utils.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../controller/base_controller.dart';

class LoginController extends BaseController {
// --------------- Repository -------------


  @override
  Future<void> onInit() async {
    super.onInit();


  }


  Future<void> getCurrentLocation() async {
    var status = await Permission.location.request();

  }

}
