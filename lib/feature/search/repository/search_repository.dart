import 'package:dictionary/core/constant/api_constant.dart';
import 'package:dictionary/model/dictionary_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchRepositoryProvider = Provider((ref) => SearchRepository());

class SearchRepository {
  SearchRepository();

  static const url = ApiConstant.BASE_URL;

  Future<DictionaryModel> fetchData({required String word}) async {
    try {
      final response = await Dio().get(url + word);
      if (response.statusCode == 200) {
        return DictionaryModel.fromJson(response.data[0]);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Failed to fetch data. Please try again later.');
    }
  }
}
