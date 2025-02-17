import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:felicidade/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import 'common/dependency_injection.dart';
import 'common/service_locator.dart';
import 'common/utils/color_constants.dart';
import 'common/utils/shared_pref_utils.dart';
import 'common/utils/sp_util.dart';
import 'common/utils/storage_service.dart';
import 'common/utils/strings.dart';

/*final GlobalKey<NavigatorState> navigatorKey =
    GlobalKey<NavigatorState>(debugLabel: "navigator");

FlutterSecureStorage? storage;
StorageService storageService = StorageService();
*/ /*Future<void> backgroundHandler(RemoteMessage message) async {
  print('Handling a background message ${message.messageId}');
}*/ /*


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  */ /* await Firebase.initializeApp(
*/ /* */ /*
    options: DefaultFirebaseOptions.currentPlatform,
*/ /* */ /*

  );
  NotificationHelper().initNotification(navigatorKey);
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
*/ /*
  // await DependencyInjection.init();
  setup();
  // Get.put(StorageService());
  await ScreenUtil.ensureScreenSize();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light));

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  //HttpOverrides.global = MyHttpOverrides();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
    color: AppColors.appColor,
  ));
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
*/ /*  final PushNotificationService _notificationService =
      PushNotificationService();*/ /*

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    // _notificationService.initialize();

    return GestureDetector(
      onTap: (){
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(useMaterial3: false),
        initialRoute: Routes.root,
        getPages: AppPages.routes,
        title: Strings.appName,
      ),
    );
  }
}*/

import 'package:felicidade/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
/*import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';*/
import 'common/dependency_injection.dart';
import 'common/service_locator.dart';
import 'common/utils/color_constants.dart';
import 'common/utils/storage_service.dart';
import 'common/utils/strings.dart';
import 'common/zego_constants.dart';

final GlobalKey<NavigatorState> navigatorKey =
GlobalKey<NavigatorState>(debugLabel: "navigator");

FlutterSecureStorage? storage;
StorageService storageService = StorageService();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  /// Shared Preferences
  await SpUtil.getInstance();

  /// secure storage
  storage = const FlutterSecureStorage();

  /// Device Info
  await setDeviceInfo();

  setup();
  final prefs = await SharedPreferences.getInstance();
  final cacheUserID = prefs.get(cacheUserIDKey) as String? ?? '';
  if (cacheUserID.isNotEmpty) {
    currentUser.id = cacheUserID;
    currentUser.name = 'user_$cacheUserID';
  }

/*  ZegoUIKitPrebuiltCallInvitationService().setNavigatorKey(navigatorKey);

  ZegoUIKit().initLog().then((value) {
    ZegoUIKitPrebuiltCallInvitationService().useSystemCallingUI(
      [ZegoUIKitSignalingPlugin()],
    );
    runApp(MyApp());
  });*/
  runApp(MyApp());

}

Future<void> setDeviceInfo() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  if (Platform.isAndroid) {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    await setDeviceModel("${androidInfo.brand} ${androidInfo.model}");
    await setDeviceId(androidInfo.id);
  }
  if (Platform.isIOS) {
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    await setDeviceModel(iosInfo.systemName);
    await setDeviceId("${iosInfo.identifierForVendor}");
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(useMaterial3: false,
            scaffoldBackgroundColor: const Color(0xFFEFEFEF)),
        initialRoute: Routes.root,
        getPages: AppPages.routes,
        title: Strings.appName,
        navigatorKey: navigatorKey,
      /*  builder: (context, child) {
          return Stack(
            children: [
              child!,
              ZegoUIKitPrebuiltCallMiniOverlayPage(
                contextQuery: () {
                  return navigatorKey.currentState!.context;
                },
              ),
            ],
          );
        },*/
      ),
    );
  }
}
