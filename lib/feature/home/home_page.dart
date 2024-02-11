import 'package:dictionary/theme/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(themeControllerProvider);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              ref.read(themeControllerProvider.notifier).toogleTheme(context);
            },
            icon: isDark
                ? const Icon(Icons.dark_mode)
                : const Icon(Icons.light_mode),
          )
        ],
      ),
    );
  }
}
