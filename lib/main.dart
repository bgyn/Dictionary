import 'package:dictionary/core/utility/shred_utility.dart';
import 'package:dictionary/feature/home/screen/home_page.dart';
import 'package:dictionary/theme/theme.dart';
import 'package:dictionary/theme/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedUtility.ensureInitialized();
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dictionary',
      theme: getAppTheme(context, ref.watch(themeControllerProvider)),
      home: HomePage(),
    );
  }
}
