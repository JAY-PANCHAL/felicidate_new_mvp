import 'package:dio/dio.dart';

import '../../common/utils/storage_service.dart';
import '../constant/endpoints.dart';
import '../dio/dio_exception.dart';
import '../model/connect_to_feli_model.dart';
import '../model/save_feelings_model.dart';
import '../model/token_model.dart';

import 'Felicidade_api.dart';

class   FelicidadeRepository {
  final FelicidadeApi felicidateApi;
  final storageService = StorageService();

  FelicidadeRepository(this.felicidateApi);


  Future<String> signInRequested(params, context) async {
    try {
      final response = await felicidateApi.loadPostData(
          Endpoints.signIn,params, context);
      return response;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<String> resendOtpRequested(params, context) async {
    try {
      final response = await felicidateApi.loadPostData(
          Endpoints.resendOtp,params, context);
      return response;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<String> verifyOtpRequested(params, context) async {
    try {
      final response = await felicidateApi.loadPostData(
          Endpoints.verifyOtp,params, context);
      return response;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }


  Future<String> createNewJournalRequested(params, context) async {
    try {
      final response = await felicidateApi.loadPostData(
          Endpoints.createNewJournal,params, context);
      return response;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<String> getJournalEntriesRequested(params, context) async {
    try {
      final response = await felicidateApi.loadPostData(
          Endpoints.getJournalEntries,params, context);
      return response;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }


  Future<String> saveFeelingsApi(params, context) async {
    try {
      final response = await felicidateApi.loadPostData(
          Endpoints.saveFeelings,params, context);
      return response;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
  Future<String> getDiaryDetailsApi(params, context) async {
    try {
      final response = await felicidateApi.loadPostData(
          Endpoints.getDiaryDetail,params, context);
      return response;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<String> getInitialDetailsRequested(params, context) async {
    try {
      final response = await felicidateApi.loadPostData(
          Endpoints.initialDetails,params, context);
      return response;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<String> connectToFeliApi(params, context) async {
    try {
      final response = await felicidateApi.loadPostData(
          Endpoints.connectToFeli,params, context);
      return response;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
}
