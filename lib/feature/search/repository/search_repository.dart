import 'package:dictionary/core/constant/api_constant.dart';
import 'package:dictionary/model/dictionary_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchRepositoryProvider = Provider((ref) => SearchRepository());

class SearchRepository {
  SearchRepository();

  static const url = ApiConstant.BASE_URL;

  Future<DictionaryModel> getResponse({required String word}) async {
    final response = await Dio().get(url + word);
    return DictionaryModel.fromJson(response.data[0]);
  }
}
