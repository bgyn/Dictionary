import 'package:dictionary/core/constant/api_constant.dart';
import 'package:dictionary/model/dictionary_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchRepositoryProvider = Provider((ref) => SearchRepository());

class SearchRepository {
  SearchRepository();

  Future<DictionaryModel> getResponse({required String word}) async {
    String url = '${ApiConstant.BASE_URL}$word';
    final response = await Dio().get(url);
    return DictionaryModel.fromJson(response.data[0]);
  }
}
