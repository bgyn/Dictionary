import 'package:dictionary/feature/recent/recent_controller.dart';
import 'package:dictionary/theme/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomePage extends ConsumerWidget {
  final searchController = TextEditingController();
  HomePage({super.key});
  void clearText() {
    searchController.clear();
  }

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
      body: Padding(
        padding: const EdgeInsets.only(
          top: 60,
          left: 20,
          right: 20,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Dictionary',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      fontSize: 40,
                    ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: searchController,
                decoration: const InputDecoration(
                  hintText: "search here",
                  filled: true,
                  fillColor: Color.fromARGB(255, 212, 212, 212),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide.none,
                  ),
                ),
                onSubmitted: (value) {
                  GoRouter.of(context).pushNamed(
                    'search',
                    pathParameters: {'query': value},
                  );
                  ref
                      .read(recentControllerProvider.notifier)
                      .updateRecent(value);
                  clearText();
                },
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Recent",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  IconButton(
                      onPressed: () {
                        ref
                            .read(recentControllerProvider.notifier)
                            .clearRecent();
                      },
                      icon: const Icon(Icons.delete))
                ],
              ),
              Consumer(builder: (context, ref, child) {
                final list = ref.watch(recentControllerProvider);
                return Column(
                  children: list
                      .map((e) => InkWell(
                            onTap: () {
                              GoRouter.of(context).pushNamed('search',
                                  pathParameters: {'query': e});
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 2),
                              child: Text(
                                "${e[0].toUpperCase()}${e.substring(1)}",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                          ))
                      .toList(),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
