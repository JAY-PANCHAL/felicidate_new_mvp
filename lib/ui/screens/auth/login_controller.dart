import 'dart:async';
import 'dart:convert';
import 'package:felicidade/common/utils/shared_pref_utils.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../common/utils/app_constants.dart';
import '../../../common/utils/strings.dart';
import '../../../controller/base_controller.dart';
import '../../../network/constant/endpoints.dart';
import '../../../network/model/login_model.dart';
import '../../../routes/app_pages.dart';
import '../../widget/constants/app_colors.dart';

class LoginController extends BaseController {

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  Future<void> getCurrentLocation() async {
    var status = await Permission.location.request();
  }

  Future<void> apiCallForFBSignIn(context, FacebookUser user,AccessToken token) async {
    isLoading.value = true;

    //Map<String, dynamic> params = Endpoints.getCommonParam();

    var params = {
      "provider_type": "facebook",
      "name": user.name,
      "mobile_number": "",
      "email": user.email,
      "provider_id": user.id,
      "provider_token": token.tokenString,
      "provider_auth_code": "",
      "profile_picture": user.picture?.data?.url,
      "signature_hash": getDeviceId()
    };
    await repo.signInRequested(params, context).then((value) async {
      isLoading.value = false;
      var data = jsonDecode(value);
      if (data != null) {
        LoginModel model = LoginModel.fromJson(data);
        if (model.status == true) {
          AppConstants.showToast(model.message ?? "");
          Get.toNamed(Routes.oneOnboardingScreen,arguments: {
            "name":user.name,
            "email":user.email,
              "phone":""
          });
        }
      }
    }, onError: (e) {
      isLoading.value = false;
      if (e.toString().contains(Strings.noInternet)) {
        AppConstants.showSnackBar(e.toString(), context, () {
          apiCallForFBSignIn(context, user,token);
        });
      } else {
        AppConstants.showGetSnackBar("Hold Up!", e.toString(), RED);
      }
    });
  }
  Future<void> apiCallForGoogleSignIn(context,String name,String email,String token,String phone,String providerid,String profile) async {
    isLoading.value = true;

    //Map<String, dynamic> params = Endpoints.getCommonParam();

    var params = {
      "provider_type": "google",
      "name": name,
      "mobile_number": phone,
      "email": email,
      "provider_id": providerid,
      "provider_token": token,
      "provider_auth_code": "",
      "profile_picture": profile,
      "signature_hash": getDeviceId()
    };
    await repo.signInRequested(params, context).then((value) async {
      isLoading.value = false;
      var data = jsonDecode(value);
      if (data != null) {
        LoginModel model = LoginModel.fromJson(data);
        if (model.status == true) {
          AppConstants.showToast(model.message ?? "");
          Get.toNamed(Routes.oneOnboardingScreen,arguments: {
            "name":name,
            "email":email,
            "phone":phone
          });
        }
      }
    }, onError: (e) {
      isLoading.value = false;
      if (e.toString().contains(Strings.noInternet)) {
        AppConstants.showSnackBar(e.toString(), context, () {
          apiCallForGoogleSignIn(context,name,email,token,phone,providerid,profile);
        });
      } else {
        AppConstants.showGetSnackBar("Hold Up!", e.toString(), RED);
      }
    });
  }


}

class FacebookUser {
  String? name;
  String? email;
  Picture? picture;
  String? id;

  FacebookUser({this.name, this.email, this.picture, this.id});

  FacebookUser.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    picture =
        json['picture'] != null ? new Picture.fromJson(json['picture']) : null;
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    if (this.picture != null) {
      data['picture'] = this.picture!.toJson();
    }
    data['id'] = this.id;
    return data;
  }
}

class Picture {
  Data? data;

  Picture({this.data});

  Picture.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? height;
  bool? isSilhouette;
  String? url;
  int? width;

  Data({this.height, this.isSilhouette, this.url, this.width});

  Data.fromJson(Map<String, dynamic> json) {
    height = json['height'];
    isSilhouette = json['is_silhouette'];
    url = json['url'];
    width = json['width'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['height'] = this.height;
    data['is_silhouette'] = this.isSilhouette;
    data['url'] = this.url;
    data['width'] = this.width;
    return data;
  }
}
