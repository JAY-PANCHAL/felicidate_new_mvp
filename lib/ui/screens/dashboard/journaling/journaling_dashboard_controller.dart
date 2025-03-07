import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';

import '../../../../common/service_locator.dart';
import '../../../../common/utils/app_constants.dart';
import '../../../../common/utils/strings.dart';
import '../../../../controller/base_controller.dart';
import '../../../../network/api/Felicidade_repository.dart';
import '../../../../network/constant/endpoints.dart';
import '../../../../network/model/journal_entries_model.dart';
import '../../../widget/constants/app_colors.dart';



class JournalingDashboardController extends BaseController {
// --------------- Repository -------------

  final repository = getIt.get<FelicidadeRepository>();

  var mMyDiaries = <MyDiaries>[].obs;

  @override
  Future<void> onInit() async {
    super.onInit();



  }


  Future<void> apiCallForGetJournalEntries(context) async {
    isLoading.value = true;


    Map<String, dynamic> params = Endpoints.getCommonParam();
    // params['journal_entry_date'] = AppConstants().getCurrentDate();
    params['journal_entry_date'] = "";

    await repository.getJournalEntriesRequested(params, context).then((value) async {
      isLoading.value = false;
      var data = jsonDecode(value);
      if (data != null) {
        JournalEntriesModel model = JournalEntriesModel.fromJson(data);
        if (model.status == true) {
          mMyDiaries.value = model.data?.myDiaries??[];
        }
      }
    }, onError: (e) {
      isLoading.value = false;
      if (e.toString().contains(Strings.noInternet)) {
        AppConstants.showSnackBar(e.toString(), context, () {
          apiCallForGetJournalEntries(context);
        });
      } else {
        AppConstants.showGetSnackBar("Hold Up!", e.toString(),RED);
      }
    });
  }


}
