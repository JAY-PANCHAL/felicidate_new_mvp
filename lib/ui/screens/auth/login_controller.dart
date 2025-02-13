import 'dart:async';
import 'package:felicidade/common/utils/shared_pref_utils.dart';

import '../../../controller/base_controller.dart';

class LoginController extends BaseController {
// --------------- Repository -------------


  @override
  Future<void> onInit() async {
    super.onInit();

    setTockenMethod();

  }


  Future<void> setTockenMethod() async {
    await setToken('Bearer 156|c8XTsQF6ApkNUVSYdfNEFWZZiTcZU38QfnCKiVSBcbeea0f7');

  }


}
