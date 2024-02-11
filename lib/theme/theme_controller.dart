// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dictionary/core/utility/shred_utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeControllerProvider = StateNotifierProvider<ThemeController, bool>(
  (ref) {
    final value = SharedUtility().themeMode();
    return ThemeController(isDarkModeDefaultValue: value);
  },
);

class ThemeController extends StateNotifier<bool> {
  final bool isDarkModeDefaultValue;
  ThemeController({required this.isDarkModeDefaultValue})
      : super(isDarkModeDefaultValue);
  toogleTheme(BuildContext context) {
    state = !state;
    SharedUtility().updateThemeMode(state);
  }
}
