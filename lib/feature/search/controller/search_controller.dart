import 'package:dictionary/feature/search/repository/search_repository.dart';
import 'package:dictionary/model/dictionary_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getResponseProvider =
    FutureProvider.autoDispose.family((ref, String arg) {
  final searchContoller = ref.watch(searchControllerProvider.notifier);
  return searchContoller.fetchData(arg);
});

final searchControllerProvider =
    StateNotifierProvider((ref) => SearchController(
          searchRepository: ref.read(searchRepositoryProvider),
        ));

class SearchController extends StateNotifier<bool> {
  final SearchRepository _searchRepository;
  SearchController({required SearchRepository searchRepository})
      : _searchRepository = searchRepository,
        super(false);

  Future<DictionaryModel> fetchData(String word) {
    return _searchRepository.fetchData(word: word);
  }
}
