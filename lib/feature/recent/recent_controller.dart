import 'dart:convert';

import 'package:dictionary/core/utility/shred_utility.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final recentControllerProvider =
    StateNotifierProvider<RecentController, List<String>>((ref) {
  try {
    final data = SharedUtility().getRecents();
    final Map<String, dynamic> decodedData = jsonDecode(data);
    if (decodedData.containsKey('wordList') &&
        decodedData['wordList'] is List<dynamic>) {
      return RecentController(data: List<String>.from(decodedData['wordList']));
    }
    return RecentController(data: []);
  } catch (e) {
    return RecentController(data: []);
  }
});

class RecentController extends StateNotifier<List<String>> {
  final List<String> data;
  RecentController({required this.data}) : super(data);

  void updateRecent(String value) {
    List<String> updatedWords = List.from(state);
    updatedWords.add(value);
    state = updatedWords;
    final data = {
      'wordList': updatedWords,
    };
    final encodedDate = jsonEncode(data);
    SharedUtility().setrecents(encodedDate);
  }
}
