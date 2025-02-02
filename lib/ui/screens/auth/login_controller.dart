import 'dart:async';


import '../../../controller/base_controller.dart';

class LoginController extends BaseController {
// --------------- Repository -------------


  @override
  Future<void> onInit() async {
    super.onInit();



  }



  // Future apiCallForLogin(context) async {
  //   isLoading.value = true;
  //
  //   final Map<String, dynamic> params = {
  //     "phone_number": mobileController.text.toString(),
  //     "password": passwordController.text.toString(),
  //     "device_type": await AppUtils.getDeviceType(),
  //     "device_token": await AppUtils.getDeviceToken(),
  //     "device_id": await AppUtils.getDeviceId(),
  //     "device_name": await AppUtils.getDeviceName()
  //   };
  //   await repository.loginRequested(params).then((value) async {
  //     isLoading.value = false;
  //     print(value);
  //     var data = jsonDecode(value);
  //     if (data != null) {
  //       LoginModel model = LoginModel.fromJson(data);
  //       if (model.show == true) {
  //         AppUtils.showToast(model.message, context);
  //       }
  //       if (model.status == 200) {
  //         await _storageService.setString(AppConstants.userDataPREF, value);
  //         _storageService.setString(
  //             AppConstants.onboardingDataPREF, "onboardingDataPREF");
  //         mainController=  Get.put(MainController());
  //
  //         //  print("apitoken===========>");
  //         //   print(model.data?.apiToken);
  //         Get.offNamedUntil(Routes.main, (route) => false);
  //       }
  //     }
  //   }, onError: (e) {
  //     isLoading.value = false;
  //     if (e == StringFile().noInternet) {
  //       AppUtils.showSnackBar(e, context, () {
  //         apiCallForLogin(context);
  //       });
  //     } else {
  //       AppUtils.showGetSnackBar("Hold Up!", e, Styles.redColor);
  //     }
  //   });
  // }
}
